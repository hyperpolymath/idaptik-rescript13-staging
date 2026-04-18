// SPDX-License-Identifier: PMPL-1.0-or-later
// Tests for LOOP reversible loop (Janus-style)

let runTests = () => {
  Console.log("[TEST] LOOP instruction")

  // Test 1: Simple counting loop  sum 1+2+3+4+5 = 15
  // Registers: n (counter), sum (accumulator), done (exit flag)
  // Loop: while done != 0, add n to sum, decrement n
  // Setup: n=5, sum=0, done=5 (non-zero means keep going)
  {
    let state = State.createState(~variables=["n", "sum", "one", "done"], ~initialValue=0)
    Dict.set(state, "n", 5)
    Dict.set(state, "one", 1)
    // done starts at 0 for entry assertion, gets set by body

    let loopInstr = Loop.make(
      ~entryReg="done",    // Must be 0 to enter (Janus entry assertion)
      ~exitReg="n",        // Exit when n == 0
      ~body=[
        Add.make("sum", "n"),    // sum += n
        Sub.make("n", "one"),    // n -= 1
      ],
      ~step=[],  // No separate step needed
      (),
    )

    loopInstr.execute(state)
    let sumVal = Dict.get(state, "sum")->Option.getOr(-999)
    let nVal = Dict.get(state, "n")->Option.getOr(-999)
    assert(sumVal == 15)
    assert(nVal == 0)
    Console.log("   Loop computes sum 1..5 = 15")

    // Save state before reversal
    let stateBefore = State.cloneState(state)

    // Reverse the loop
    loopInstr.invert(state)
    let sumAfter = Dict.get(state, "sum")->Option.getOr(-999)
    let nAfter = Dict.get(state, "n")->Option.getOr(-999)
    assert(sumAfter == 0)
    assert(nAfter == 5)
    Console.log("   Reverse restores n=5, sum=0")
    ignore(stateBefore)
  }

  // Test 2: Single iteration loop (body runs once, exit immediately)
  {
    let state = State.createState(~variables=["x", "y", "flag"], ~initialValue=0)
    Dict.set(state, "x", 10)
    Dict.set(state, "y", 3)

    let loopInstr = Loop.make(
      ~entryReg="flag",    // flag=0, entry ok
      ~exitReg="flag",     // flag becomes 0 in body  exit
      ~body=[
        Add.make("x", "y"),    // x = 13
        // flag stays 0, so loop exits after one iteration
      ],
      ~step=[],
      (),
    )

    loopInstr.execute(state)
    let xVal = Dict.get(state, "x")->Option.getOr(-999)
    assert(xVal == 13)
    Console.log("   Single-iteration loop executes body once")

    loopInstr.invert(state)
    let xAfter = Dict.get(state, "x")->Option.getOr(-999)
    assert(xAfter == 10)
    Console.log("   Single-iteration loop reverses correctly")
  }

  Console.log("[SUCCESS] All LOOP tests passed")
}
