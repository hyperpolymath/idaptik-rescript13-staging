// SPDX-License-Identifier: PMPL-1.0-or-later
// Unit tests for ADD instruction


let testAddBasic = (): bool => {
  let state = State.createState(~variables=["a", "b"], ~initialValue=0)
  Dict.set(state, "a", 10)
  Dict.set(state, "b", 5)

  let instr = Add.make("a", "b")
  instr.execute(state)

  Dict.get(state, "a")->Option.getOr(0) == 15
}

let testAddInverse = (): bool => {
  let state = State.createState(~variables=["a", "b"], ~initialValue=0)
  Dict.set(state, "a", 10)
  Dict.set(state, "b", 5)

  let instr = Add.make("a", "b")
  instr.execute(state)
  instr.invert(state)

  Dict.get(state, "a")->Option.getOr(0) == 10
}

let testAddNegative = (): bool => {
  let state = State.createState(~variables=["a", "b"], ~initialValue=0)
  Dict.set(state, "a", -10)
  Dict.set(state, "b", 5)

  let instr = Add.make("a", "b")
  instr.execute(state)

  Dict.get(state, "a")->Option.getOr(0) == -5
}

let testAddZero = (): bool => {
  let state = State.createState(~variables=["a", "b"], ~initialValue=0)
  Dict.set(state, "a", 42)
  Dict.set(state, "b", 0)

  let instr = Add.make("a", "b")
  instr.execute(state)

  Dict.get(state, "a")->Option.getOr(0) == 42
}

// Property-based test: reversibility
let testAddReversibility = (): bool => {
  let testCases = [
    (10, 5),
    (-10, 5),
    (10, -5),
    (0, 0),
    (100, -100),
    (999, 1),
  ]

  Array.every(testCases, ((a, b)) => {
    let state = State.createState(~variables=["x", "y"], ~initialValue=0)
    Dict.set(state, "x", a)
    Dict.set(state, "y", b)

    let original = State.cloneState(state)
    let instr = Add.make("x", "y")

    instr.execute(state)
    instr.invert(state)

    State.statesMatch(state, original)
  })
}

let runAll = (): unit => {
  Console.log("[ADD Tests]")

  Console.log(testAddBasic() ? "   Basic addition" : "   Basic addition FAILED")
  Console.log(testAddInverse() ? "   Inverse operation" : "   Inverse operation FAILED")
  Console.log(testAddNegative() ? "   Negative numbers" : "   Negative numbers FAILED")
  Console.log(testAddZero() ? "   Adding zero" : "   Adding zero FAILED")
  Console.log(testAddReversibility() ? "   Reversibility property" : "   Reversibility FAILED")
}
