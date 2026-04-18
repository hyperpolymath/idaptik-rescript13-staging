// SPDX-License-Identifier: PMPL-1.0-or-later
// Unit tests for CALL instruction (Tier 3  Subroutines)


let testCallBasic = (): bool => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 10)
  Dict.set(state, "y", 5)

  // Define a "double_x" subroutine: ADD x x
  let body = [Add.make("x", "x")]
  let callInstr = Call.make(~name="double_x", ~body)
  callInstr.execute(state)

  Dict.get(state, "x")->Option.getOr(-1) == 20
}

let testCallMultiStep = (): bool => {
  let state = State.createState(~variables=["x", "y", "z"], ~initialValue=0)
  Dict.set(state, "x", 10)
  Dict.set(state, "y", 5)

  // Subroutine: swap x,y then add x,y  final: x=5+10=15, y=10
  let body = [Swap.make("x", "y"), Add.make("x", "y")]
  let callInstr = Call.make(~name="swap_and_add", ~body)
  callInstr.execute(state)

  let x = Dict.get(state, "x")->Option.getOr(-1)
  let y = Dict.get(state, "y")->Option.getOr(-1)
  x == 15 && y == 10
}

let testCallInverse = (): bool => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 10)
  Dict.set(state, "y", 5)
  let original = State.cloneState(state)

  let body = [Add.make("x", "y"), Swap.make("x", "y"), Negate.make("x")]
  let callInstr = Call.make(~name="complex_op", ~body)
  callInstr.execute(state)
  callInstr.invert(state)

  State.statesMatch(state, original)
}

let testCallViaVM = (): bool => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 10)
  Dict.set(state, "y", 5)
  let original = State.cloneState(state)

  let vm = VM.make(state)
  VM.defineSubroutine(vm, "add_xy", [Add.make("x", "y")])
  VM.callSubroutine(vm, "add_xy")->ignore

  let x = Dict.get(VM.getState(vm), "x")->Option.getOr(-1)
  if x != 15 { false }
  else {
    // Undo should reverse the entire CALL
    VM.undo(vm)->ignore
    State.statesMatch(VM.getState(vm), original)
  }
}

let testCallUndefinedSubroutine = (): bool => {
  let state = State.createState(~variables=["x"], ~initialValue=0)
  let vm = VM.make(state)

  switch VM.callSubroutine(vm, "nonexistent") {
  | Some(_errorMsg) => true // Should return error message
  | None => false
  }
}

let testCallReversibility = (): bool => {
  let testCases = [
    ("add", [Add.make("x", "y")]),
    ("negate_swap", [Negate.make("x"), Swap.make("x", "y")]),
    ("triple_add", [Add.make("x", "y"), Add.make("x", "y"), Add.make("x", "y")]),
  ]

  Array.every(testCases, ((_name, body)) => {
    let state = State.createState(~variables=["x", "y"], ~initialValue=0)
    Dict.set(state, "x", 17)
    Dict.set(state, "y", 3)
    let original = State.cloneState(state)

    let callInstr = Call.make(~name="test", ~body)
    callInstr.execute(state)
    callInstr.invert(state)

    State.statesMatch(state, original)
  })
}

let runAll = (): unit => {
  Console.log("[CALL Tests]")

  Console.log(testCallBasic() ? "   Basic subroutine call" : "   Basic call FAILED")
  Console.log(testCallMultiStep() ? "   Multi-step subroutine" : "   Multi-step FAILED")
  Console.log(testCallInverse() ? "   CALL inverse reverses body" : "   CALL inverse FAILED")
  Console.log(testCallViaVM() ? "   CALL via VM.callSubroutine" : "   CALL via VM FAILED")
  Console.log(testCallUndefinedSubroutine() ? "   Undefined subroutine returns error" : "   Undefined subroutine FAILED")
  Console.log(testCallReversibility() ? "   CALL reversibility property" : "   CALL reversibility FAILED")
}
