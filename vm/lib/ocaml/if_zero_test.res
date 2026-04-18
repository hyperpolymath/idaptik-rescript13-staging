// SPDX-License-Identifier: PMPL-1.0-or-later
// Tests for IF_ZERO reversible conditional

let runTests = () => {
  Console.log("[TEST] IF_ZERO instruction")

  // Test 1: then-branch taken (testReg == 0)
  {
    let state = State.createState(~variables=["x", "y", "flag"], ~initialValue=0)
    Dict.set(state, "x", 0)  // test register = 0, so then-branch runs
    Dict.set(state, "y", 5)
    Dict.set(state, "flag", 0)

    let instr = IfZero.make(
      ~testReg="x",
      ~exitReg="flag",
      ~thenBranch=[Add.make("y", "y")],   // y = y + y = 10
      ~elseBranch=[Negate.make("y")],
    )

    instr.execute(state)
    let yVal = Dict.get(state, "y")->Option.getOr(-999)
    assert(yVal == 10)
    Console.log("   Then-branch executes when test == 0")

    // Reverse it
    instr.invert(state)
    let yAfter = Dict.get(state, "y")->Option.getOr(-999)
    assert(yAfter == 5)
    Console.log("   Invert restores original state (then-branch)")
  }

  // Test 2: else-branch taken (testReg != 0)
  {
    let state = State.createState(~variables=["x", "y"], ~initialValue=0)
    Dict.set(state, "x", 7)  // test register != 0, so else-branch runs
    Dict.set(state, "y", 5)

    let instr = IfZero.make(
      ~testReg="x",
      ~exitReg="x",  // x != 0 after else, confirming else was taken
      ~thenBranch=[Add.make("y", "y")],
      ~elseBranch=[Negate.make("y")],  // y = -5
    )

    instr.execute(state)
    let yVal = Dict.get(state, "y")->Option.getOr(-999)
    assert(yVal == -5)
    Console.log("   Else-branch executes when test != 0")

    instr.invert(state)
    let yAfter = Dict.get(state, "y")->Option.getOr(-999)
    assert(yAfter == 5)
    Console.log("   Invert restores original state (else-branch)")
  }

  // Test 3: Multi-instruction then-branch
  {
    let state = State.createState(~variables=["x", "y", "z"], ~initialValue=0)
    Dict.set(state, "y", 3)
    Dict.set(state, "z", 7)

    let instr = IfZero.make(
      ~testReg="x",
      ~exitReg="x",
      ~thenBranch=[
        Add.make("y", "z"),      // y = 3 + 7 = 10
        Swap.make("y", "z"),     // y = 7, z = 10
        Add.make("z", "y"),      // z = 10 + 7 = 17
      ],
      ~elseBranch=[],
    )

    instr.execute(state)
    let yVal = Dict.get(state, "y")->Option.getOr(-999)
    let zVal = Dict.get(state, "z")->Option.getOr(-999)
    assert(yVal == 7)
    assert(zVal == 17)
    Console.log("   Multi-instruction then-branch executes correctly")

    instr.invert(state)
    let yAfter = Dict.get(state, "y")->Option.getOr(-999)
    let zAfter = Dict.get(state, "z")->Option.getOr(-999)
    assert(yAfter == 3)
    assert(zAfter == 7)
    Console.log("   Multi-instruction then-branch reverses correctly")
  }

  Console.log("[SUCCESS] All IF_ZERO tests passed")
}
