// SPDX-License-Identifier: PMPL-1.0-or-later
// Tests for AND and OR instructions (reversible with ancilla)

// Test AND instruction
let testAndReversibility = (): bool => {
  let testCases = [
    (0b1010, 0b1100, 0b1000), // AND result
    (0xFF, 0xFF, 0xFF),        // All ones
    (0xFF, 0x00, 0x00),        // Zero result
    (0b1111, 0b0101, 0b0101), // Mixed
  ]

  testCases->Array.every(((a, b, expected)) => {
    let state = State.createState(~variables=["a", "b", "c"], ~initialValue=0)
    Dict.set(state, "a", a)
    Dict.set(state, "b", b)
    Dict.set(state, "c", 0)  // Ancilla must be 0

    let original = State.cloneState(state)
    let instr = And.make("a", "b", "c")

    // Execute AND
    instr.execute(state)

    // Check result
    let c = Dict.get(state, "c")->Option.getOr(-1)
    let resultCorrect = c == expected

    // Invert (clear ancilla)
    instr.invert(state)

    // Should match original
    let reversible = State.statesMatch(state, original)

    resultCorrect && reversible
  })
}

// Test OR instruction
let testOrReversibility = (): bool => {
  let testCases = [
    (0b1010, 0b0101, 0b1111), // OR result
    (0xFF, 0xFF, 0xFF),        // All ones
    (0xFF, 0x00, 0xFF),        // One operand
    (0b1100, 0b0011, 0b1111), // Complementary
  ]

  testCases->Array.every(((a, b, expected)) => {
    let state = State.createState(~variables=["a", "b", "c"], ~initialValue=0)
    Dict.set(state, "a", a)
    Dict.set(state, "b", b)
    Dict.set(state, "c", 0)  // Ancilla must be 0

    let original = State.cloneState(state)
    let instr = Or.make("a", "b", "c")

    // Execute OR
    instr.execute(state)

    // Check result
    let c = Dict.get(state, "c")->Option.getOr(-1)
    let resultCorrect = c == expected

    // Invert (clear ancilla)
    instr.invert(state)

    // Should match original
    let reversible = State.statesMatch(state, original)

    resultCorrect && reversible
  })
}

// Test ancilla requirement
let testAncillaRequirement = (): bool => {
  // AND/OR require ancilla to be 0 for proper reversibility
  let state = State.createState(~variables=["a", "b", "c"], ~initialValue=0)
  Dict.set(state, "a", 0b1010)
  Dict.set(state, "b", 0b1100)
  Dict.set(state, "c", 0)

  let instr = And.make("a", "b", "c")

  // Execute
  instr.execute(state)
  let c1 = Dict.get(state, "c")->Option.getOr(-1)

  // Invert
  instr.invert(state)
  let c2 = Dict.get(state, "c")->Option.getOr(-1)

  // c should be back to 0
  c1 == 0b1000 && c2 == 0
}

// Run all tests
let runAllTests = (): bool => {
  Console.log("Testing AND/OR instructions...")

  let testResults = [
    ("AND correctness and reversibility", testAndReversibility()),
    ("OR correctness and reversibility", testOrReversibility()),
    ("Ancilla requirement", testAncillaRequirement()),
  ]

  testResults->Array.forEach(((name, passed)) => {
    if passed {
      Console.log(` ${name}`)
    } else {
      Console.log(` ${name} FAILED`)
    }
  })

  testResults->Array.every(((_, passed)) => passed)
}
