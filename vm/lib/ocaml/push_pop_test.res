// SPDX-License-Identifier: PMPL-1.0-or-later
// Unit tests for PUSH and POP instructions (Tier 2  Stack)


let testPushBasic = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 42)

  let instr = Push.make("x")
  instr.execute(state)

  let x = Dict.get(state, "x")->Option.getOr(-1)
  let sp = VmState.getStackPointer(state)
  let s0 = VmState.getStackSlot(state, 0)

  x == 0 && sp == 1 && s0 == 42
}

let testPopBasic = (): bool => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 42)

  Push.make("x").execute(state)
  Pop.make("y").execute(state)

  let y = Dict.get(state, "y")->Option.getOr(-1)
  let sp = VmState.getStackPointer(state)

  y == 42 && sp == 0
}

let testPushInverse = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 42)
  let original = State.cloneState(state)

  let instr = Push.make("x")
  instr.execute(state)
  instr.invert(state)

  // User registers should match
  Dict.get(state, "x")->Option.getOr(-1) == 42 &&
  VmState.getStackPointer(state) == 0
}

let testPopInverse = (): bool => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 42)

  // Push x, then pop into y
  Push.make("x").execute(state)
  let pop = Pop.make("y")
  pop.execute(state)
  // y=42, sp=0
  pop.invert(state)
  // y=0, sp=1, stack[0]=42

  let y = Dict.get(state, "y")->Option.getOr(-1)
  let sp = VmState.getStackPointer(state)
  let s0 = VmState.getStackSlot(state, 0)

  y == 0 && sp == 1 && s0 == 42
}

let testStackLIFO = (): bool => {
  let state = State.createState(~variables=["a", "b", "c", "r"], ~initialValue=0)
  Dict.set(state, "a", 10)
  Dict.set(state, "b", 20)
  Dict.set(state, "c", 30)

  Push.make("a").execute(state)
  Push.make("b").execute(state)
  Push.make("c").execute(state)

  let sp = VmState.getStackPointer(state)
  if sp != 3 { false }
  else {
    // Pop in reverse order
    Pop.make("r").execute(state)
    let r1 = Dict.get(state, "r")->Option.getOr(-1)
    Dict.set(state, "r", 0)

    Pop.make("r").execute(state)
    let r2 = Dict.get(state, "r")->Option.getOr(-1)
    Dict.set(state, "r", 0)

    Pop.make("r").execute(state)
    let r3 = Dict.get(state, "r")->Option.getOr(-1)

    r1 == 30 && r2 == 20 && r3 == 10
  }
}

let testPushReversibility = (): bool => {
  let testCases = [(42, "x"), (-7, "a"), (0, "z"), (999, "r")]

  Array.every(testCases, ((value, reg)) => {
    let state = State.createState(~variables=[reg], ~initialValue=0)
    Dict.set(state, reg, value)

    let instr = Push.make(reg)
    instr.execute(state)
    instr.invert(state)

    Dict.get(state, reg)->Option.getOr(-1) == value &&
    VmState.getStackPointer(state) == 0
  })
}

let runAll = (): unit => {
  Console.log("[PUSH/POP Tests]")

  Console.log(testPushBasic() ? "   PUSH saves value, zeroes register" : "   PUSH basic FAILED")
  Console.log(testPopBasic() ? "   POP restores value from stack" : "   POP basic FAILED")
  Console.log(testPushInverse() ? "   PUSH inverse restores state" : "   PUSH inverse FAILED")
  Console.log(testPopInverse() ? "   POP inverse restores stack" : "   POP inverse FAILED")
  Console.log(testStackLIFO() ? "   Stack is LIFO" : "   Stack LIFO FAILED")
  Console.log(testPushReversibility() ? "   PUSH reversibility property" : "   PUSH reversibility FAILED")
}
