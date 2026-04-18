// SPDX-License-Identifier: PMPL-1.0-or-later
// Tests for IF_POS reversible conditional

let runTests = () => {
  Console.log("[TEST] IF_POS instruction")

  // Test 1: then-branch taken (testReg > 0)
  {
    let state = State.createState(~variables=["x", "y"], ~initialValue=0)
    Dict.set(state, "x", 5)  // positive, so then-branch
    Dict.set(state, "y", 10)

    let instr = IfPos.make(
      ~testReg="x",
      ~exitReg="x",  // x stays positive after then
      ~thenBranch=[Add.make("y", "x")],   // y = 10 + 5 = 15
      ~elseBranch=[Negate.make("y")],
    )

    instr.execute(state)
    let yVal = Dict.get(state, "y")->Option.getOr(-999)
    assert(yVal == 15)
    Console.log("   Then-branch executes when test > 0")

    instr.invert(state)
    let yAfter = Dict.get(state, "y")->Option.getOr(-999)
    assert(yAfter == 10)
    Console.log("   Invert restores original state (then-branch)")
  }

  // Test 2: else-branch taken (testReg <= 0)
  {
    let state = State.createState(~variables=["x", "y"], ~initialValue=0)
    Dict.set(state, "x", -3)  // negative, so else-branch
    Dict.set(state, "y", 10)

    let instr = IfPos.make(
      ~testReg="x",
      ~exitReg="x",  // x stays negative after else
      ~thenBranch=[Add.make("y", "x")],
      ~elseBranch=[Negate.make("y")],   // y = -10
    )

    instr.execute(state)
    let yVal = Dict.get(state, "y")->Option.getOr(-999)
    assert(yVal == -10)
    Console.log("   Else-branch executes when test <= 0")

    instr.invert(state)
    let yAfter = Dict.get(state, "y")->Option.getOr(-999)
    assert(yAfter == 10)
    Console.log("   Invert restores original state (else-branch)")
  }

  // Test 3: zero triggers else-branch (0 is NOT positive)
  {
    let state = State.createState(~variables=["x", "y"], ~initialValue=0)
    Dict.set(state, "y", 7)

    let instr = IfPos.make(
      ~testReg="x",
      ~exitReg="x",
      ~thenBranch=[Add.make("y", "y")],
      ~elseBranch=[Negate.make("y")],  // y = -7
    )

    instr.execute(state)
    let yVal = Dict.get(state, "y")->Option.getOr(-999)
    assert(yVal == -7)
    Console.log("   Zero triggers else-branch (0 is not positive)")
  }

  Console.log("[SUCCESS] All IF_POS tests passed")
}
