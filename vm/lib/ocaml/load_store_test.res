// SPDX-License-Identifier: PMPL-1.0-or-later
// Unit tests for LOAD and STORE instructions (Tier 2  Memory)


let testLoadBasic = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  VmState.setMemory(state, 10, 42)

  let instr = Load.make("x", 10)
  instr.execute(state)

  Dict.get(state, "x")->Option.getOr(-1) == 42
}

let testLoadAdditive = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 5)
  VmState.setMemory(state, 10, 42)

  Load.make("x", 10).execute(state)

  // x should be 5 + 42 = 47 (additive load)
  Dict.get(state, "x")->Option.getOr(-1) == 47
}

let testLoadInverse = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 5)
  VmState.setMemory(state, 10, 42)

  let instr = Load.make("x", 10)
  instr.execute(state)
  instr.invert(state)

  Dict.get(state, "x")->Option.getOr(-1) == 5
}

let testStoreBasic = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 42)

  Store.make(10, "x").execute(state)

  VmState.getMemory(state, 10) == 42
}

let testStoreAdditive = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 10)
  VmState.setMemory(state, 5, 20)

  Store.make(5, "x").execute(state)

  // mem[5] should be 20 + 10 = 30 (additive store)
  VmState.getMemory(state, 5) == 30
}

let testStoreInverse = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  Dict.set(state, "x", 42)

  let instr = Store.make(10, "x")
  instr.execute(state)
  instr.invert(state)

  VmState.getMemory(state, 10) == 0
}

let testLoadStoreRoundTrip = (): bool => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 42)

  // Store x into memory, load into y (both start from 0/empty)
  Store.make(0, "x").execute(state)
  Load.make("y", 0).execute(state)

  let y = Dict.get(state, "y")->Option.getOr(-1)
  y == 42
}

let testMemoryReversibility = (): bool => {
  let testCases = [(42, 0), (-7, 100), (0, 255), (999, 128)]

  Array.every(testCases, ((value, addr)) => {
    let state = State.createState(~variables=["x"], ~initialValue=0)
    Dict.set(state, "x", value)

    let store = Store.make(addr, "x")
    store.execute(state)
    store.invert(state)

    VmState.getMemory(state, addr) == 0
  })
}

let runAll = (): unit => {
  Console.log("[LOAD/STORE Tests]")

  Console.log(testLoadBasic() ? "   LOAD from memory" : "   LOAD basic FAILED")
  Console.log(testLoadAdditive() ? "   LOAD is additive" : "   LOAD additive FAILED")
  Console.log(testLoadInverse() ? "   LOAD inverse restores register" : "   LOAD inverse FAILED")
  Console.log(testStoreBasic() ? "   STORE to memory" : "   STORE basic FAILED")
  Console.log(testStoreAdditive() ? "   STORE is additive" : "   STORE additive FAILED")
  Console.log(testStoreInverse() ? "   STORE inverse restores memory" : "   STORE inverse FAILED")
  Console.log(testLoadStoreRoundTrip() ? "   LOAD/STORE round trip" : "   Round trip FAILED")
  Console.log(testMemoryReversibility() ? "   Memory reversibility property" : "   Memory reversibility FAILED")
}
