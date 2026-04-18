// SPDX-License-Identifier: PMPL-1.0-or-later
// Tests for FLIP instruction (bitwise NOT)

// Test FLIP is self-inverse
let testFlipSelfInverse = (): bool => {
  let testCases = [0, 1, -1, 0xFF, 0b1010, 42, -42, 100, -100]

  testCases->Array.every(value => {
    let state = State.createState(~variables=["x"], ~initialValue=0)
    Dict.set(state, "x", value)

    let original = State.cloneState(state)
    let instr = Flip.make("x")

    // Execute FLIP twice
    instr.execute(state)
    instr.execute(state)

    // Should match original (double negation)
    State.statesMatch(state, original)
  })
}

// Test FLIP reversibility
let testFlipReversibility = (): bool => {
  let testCases = [0, 1, -1, 0xFF, 0b1010, 42]

  testCases->Array.every(value => {
    let state = State.createState(~variables=["x"], ~initialValue=0)
    Dict.set(state, "x", value)

    let original = State.cloneState(state)
    let instr = Flip.make("x")

    // Execute
    instr.execute(state)

    // Invert (which is also FLIP)
    instr.invert(state)

    // Should match original
    State.statesMatch(state, original)
  })
}

// Test FLIP correctness
let testFlipCorrectness = (): bool => {
  let testCases = [
    (0, -1),          // NOT 0 = -1 (all bits set)
    (1, -2),          // NOT 1 = -2
    (0xFF, lnot(0xFF)), // NOT 255
    (42, lnot(42)),   // NOT 42
  ]

  testCases->Array.every(((input, expected)) => {
    let state = State.createState(~variables=["x"], ~initialValue=0)
    Dict.set(state, "x", input)

    let instr = Flip.make("x")
    instr.execute(state)

    let result = Dict.get(state, "x")->Option.getOr(0)
    result == expected
  })
}

// Test FLIP with multiple variables
let testFlipMultipleVars = (): bool => {
  let state = State.createState(~variables=["x", "y", "z"], ~initialValue=0)
  Dict.set(state, "x", 0b1010)
  Dict.set(state, "y", 0b1100)
  Dict.set(state, "z", 0)

  let original = State.cloneState(state)

  // Flip all three
  let flipX = Flip.make("x")
  let flipY = Flip.make("y")
  let flipZ = Flip.make("z")

  flipX.execute(state)
  flipY.execute(state)
  flipZ.execute(state)

  // Flip back
  flipX.invert(state)
  flipY.invert(state)
  flipZ.invert(state)

  State.statesMatch(state, original)
}

// Run all tests
let runAllTests = (): bool => {
  Console.log("Testing FLIP instruction...")

  let testResults = [
    ("FLIP is self-inverse", testFlipSelfInverse()),
    ("FLIP reversibility", testFlipReversibility()),
    ("FLIP correctness", testFlipCorrectness()),
    ("FLIP multiple variables", testFlipMultipleVars()),
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
