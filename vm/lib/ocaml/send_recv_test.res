// SPDX-License-Identifier: PMPL-1.0-or-later
// Unit tests for SEND and RECV instructions (Tier 4  I/O Channels)


let testSendBasic = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 42)

  Send.make("firewall", "x").execute(state)

  let ptr = VmState.getPortOutPointer(state, "firewall")
  let val0 = VmState.getPortOutSlot(state, "firewall", 0)

  ptr == 1 && val0 == 42
}

let testSendMultiple = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 10)
  Send.make("net", "x").execute(state)

  Dict.set(state, "x", 20)
  Send.make("net", "x").execute(state)

  Dict.set(state, "x", 30)
  Send.make("net", "x").execute(state)

  let ptr = VmState.getPortOutPointer(state, "net")
  let v0 = VmState.getPortOutSlot(state, "net", 0)
  let v1 = VmState.getPortOutSlot(state, "net", 1)
  let v2 = VmState.getPortOutSlot(state, "net", 2)

  ptr == 3 && v0 == 10 && v1 == 20 && v2 == 30
}

let testSendInverse = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 42)

  let instr = Send.make("display", "x")
  instr.execute(state)
  instr.invert(state)

  VmState.getPortOutPointer(state, "display") == 0
}

let testRecvBasic = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  // Pre-fill input buffer
  VmState.setPortInSlot(state, "sensor", 0, 42)

  Recv.make("sensor", "x").execute(state)

  let x = Dict.get(state, "x")->Option.getOr(-1)
  let ptr = VmState.getPortInPointer(state, "sensor")

  x == 42 && ptr == 1
}

let testRecvAdditive = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 5)
  VmState.setPortInSlot(state, "sensor", 0, 42)

  Recv.make("sensor", "x").execute(state)

  // Additive: 5 + 42 = 47
  Dict.get(state, "x")->Option.getOr(-1) == 47
}

let testRecvInverse = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 5)
  VmState.setPortInSlot(state, "sensor", 0, 42)

  let instr = Recv.make("sensor", "x")
  instr.execute(state)
  instr.invert(state)

  let x = Dict.get(state, "x")->Option.getOr(-1)
  let ptr = VmState.getPortInPointer(state, "sensor")

  x == 5 && ptr == 0
}

let testSendRecvRoundTrip = (): bool => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 42)

  // Send x to port
  Send.make("pipe", "x").execute(state)

  // Copy output to input (simulating game device forwarding)
  let sentValue = VmState.getPortOutSlot(state, "pipe", 0)
  VmState.setPortInSlot(state, "pipe", 0, sentValue)

  // Recv into y
  Recv.make("pipe", "y").execute(state)

  Dict.get(state, "y")->Option.getOr(-1) == 42
}

let testMultiplePortsIndependent = (): bool => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 10)
  Dict.set(state, "y", 20)

  Send.make("portA", "x").execute(state)
  Send.make("portB", "y").execute(state)

  let ptrA = VmState.getPortOutPointer(state, "portA")
  let ptrB = VmState.getPortOutPointer(state, "portB")
  let valA = VmState.getPortOutSlot(state, "portA", 0)
  let valB = VmState.getPortOutSlot(state, "portB", 0)

  ptrA == 1 && ptrB == 1 && valA == 10 && valB == 20
}

let testIOReversibility = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 42)

  // SEND then undo
  let send = Send.make("out", "x")
  send.execute(state)
  send.invert(state)
  let sendOk = VmState.getPortOutPointer(state, "out") == 0

  // RECV then undo
  VmState.setPortInSlot(state, "in", 0, 99)
  let recv = Recv.make("in", "x")
  recv.execute(state)
  recv.invert(state)
  let recvOk = Dict.get(state, "x")->Option.getOr(-1) == 42
    && VmState.getPortInPointer(state, "in") == 0

  sendOk && recvOk
}

let runAll = (): unit => {
  Console.log("[SEND/RECV Tests]")

  Console.log(testSendBasic() ? "   SEND to port" : "   SEND basic FAILED")
  Console.log(testSendMultiple() ? "   SEND multiple values" : "   SEND multiple FAILED")
  Console.log(testSendInverse() ? "   SEND inverse removes from buffer" : "   SEND inverse FAILED")
  Console.log(testRecvBasic() ? "   RECV from port" : "   RECV basic FAILED")
  Console.log(testRecvAdditive() ? "   RECV is additive" : "   RECV additive FAILED")
  Console.log(testRecvInverse() ? "   RECV inverse restores state" : "   RECV inverse FAILED")
  Console.log(testSendRecvRoundTrip() ? "   SEND/RECV round trip" : "   Round trip FAILED")
  Console.log(testMultiplePortsIndependent() ? "   Multiple ports are independent" : "   Multiple ports FAILED")
  Console.log(testIOReversibility() ? "   I/O reversibility property" : "   I/O reversibility FAILED")
}
