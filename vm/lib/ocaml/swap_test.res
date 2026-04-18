// SPDX-License-Identifier: PMPL-1.0-or-later
// Unit tests for SWAP instruction


let testSwapBasic = (): bool => {
  let state = State.createState(~variables=["a", "b"], ~initialValue=0)
  Dict.set(state, "a", 10)
  Dict.set(state, "b", 20)

  let instr = Swap.make("a", "b")
  instr.execute(state)

  Dict.get(state, "a")->Option.getOr(0) == 20 &&
  Dict.get(state, "b")->Option.getOr(0) == 10
}

let testSwapSelfInverse = (): bool => {
  let state = State.createState(~variables=["a", "b"], ~initialValue=0)
  Dict.set(state, "a", 10)
  Dict.set(state, "b", 20)

  let instr = Swap.make("a", "b")
  instr.execute(state)
  instr.execute(state)  // Swap twice = identity

  Dict.get(state, "a")->Option.getOr(0) == 10 &&
  Dict.get(state, "b")->Option.getOr(0) == 20
}

let testSwapNegative = (): bool => {
  let state = State.createState(~variables=["a", "b"], ~initialValue=0)
  Dict.set(state, "a", -5)
  Dict.set(state, "b", 15)

  let instr = Swap.make("a", "b")
  instr.execute(state)

  Dict.get(state, "a")->Option.getOr(0) == 15 &&
  Dict.get(state, "b")->Option.getOr(0) == -5
}

let testSwapReversibility = (): bool => {
  let testCases = [(10, 20), (-5, 5), (0, 100), (42, -42)]

  Array.every(testCases, ((a, b)) => {
    let state = State.createState(~variables=["x", "y"], ~initialValue=0)
    Dict.set(state, "x", a)
    Dict.set(state, "y", b)

    let original = State.cloneState(state)
    let instr = Swap.make("x", "y")

    instr.execute(state)
    instr.invert(state)

    State.statesMatch(state, original)
  })
}

let runAll = (): unit => {
  Console.log("[SWAP Tests]")

  Console.log(testSwapBasic() ? "   Basic swap" : "   Basic swap FAILED")
  Console.log(testSwapSelfInverse() ? "   Self-inverse property" : "   Self-inverse FAILED")
  Console.log(testSwapNegative() ? "   Negative numbers" : "   Negative numbers FAILED")
  Console.log(testSwapReversibility() ? "   Reversibility property" : "   Reversibility FAILED")
}
