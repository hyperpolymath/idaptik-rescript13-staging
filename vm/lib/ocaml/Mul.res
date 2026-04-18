// SPDX-License-Identifier: PMPL-1.0-or-later
// MUL instruction - Multiplication with ancilla
// Operation: c = c + (a * b) where c is initially 0
// Inverse: c = 0 (clear result)
// Note: This is reversible using ancilla pattern (Bennett's trick)
//
// For true reversibility without ancilla, we'd need more complex approaches
// like using Toffoli gates or reversible arithmetic circuits.
// This simplified version requires c=0 initially for proper reversibility.

let make = (varA: string, varB: string, varC: string): Instruction.t => {
  instructionType: "MUL",
  args: [varA, varB, varC],
  execute: state => {
    let valA = Dict.get(state, varA)->Option.getOr(0)
    let valB = Dict.get(state, varB)->Option.getOr(0)
    let valC = Dict.get(state, varC)->Option.getOr(0)

    // c = c + (a * b)
    let result = valC + (valA * valB)
    Dict.set(state, varC, result)
  },
  invert: state => {
    // Inverse: subtract the product from c
    // This works if we know a and b haven't changed
    let valA = Dict.get(state, varA)->Option.getOr(0)
    let valB = Dict.get(state, varB)->Option.getOr(0)
    let valC = Dict.get(state, varC)->Option.getOr(0)

    let result = valC - (valA * valB)
    Dict.set(state, varC, result)
  },
}

// Alternative: multiply in place (requires division for inverse)
// INTENTIONAL FLAW  educational: demonstrates why in-place multiplication
// breaks reversibility. Division by zero loses information (Landauer erasure),
// and integer division truncates. Use ancilla-based `make` above for true
// reversibility. This exists so students can discover the failure mode.
let makeInPlace = (varA: string, varB: string): Instruction.t => {
  instructionType: "MUL_INPLACE",
  args: [varA, varB],
  execute: state => {
    let valA = Dict.get(state, varA)->Option.getOr(0)
    let valB = Dict.get(state, varB)->Option.getOr(0)
    Dict.set(state, varA, valA * valB)
  },
  invert: state => {
    // WARNING: This is NOT properly reversible!
    // Division may not restore original value for all inputs
    let valA = Dict.get(state, varA)->Option.getOr(0)
    let valB = Dict.get(state, varB)->Option.getOr(1) // Avoid division by zero

    if valB != 0 {
      Dict.set(state, varA, valA / valB)
    }
    // If valB is 0, we can't invert - this breaks reversibility!
  },
}
