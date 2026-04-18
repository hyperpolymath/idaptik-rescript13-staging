// SPDX-License-Identifier: PMPL-1.0-or-later
// DIV instruction - Division with remainder storage
// Operation: q = a / b, r = a mod b
// Inverse: a = (q * b) + r
// This is reversible because we store the remainder!
//
// For proper reversibility, we need both quotient AND remainder.
// This follows the principle: division is only reversible if we keep all information.

let make = (varA: string, varB: string, varQ: string, varR: string): Instruction.t => {
  instructionType: "DIV",
  args: [varA, varB, varQ, varR],
  execute: state => {
    let valA = Dict.get(state, varA)->Option.getOr(0)
    let valB = Dict.get(state, varB)->Option.getOr(1) // Avoid division by zero

    if valB == 0 {
      // Division by zero - store error state
      Dict.set(state, varQ, 0)
      Dict.set(state, varR, valA) // Store original value in remainder
    } else {
      // Normal division: q = a / b, r = a mod b
      let quotient = valA / valB
      let remainder = mod(valA, valB)

      Dict.set(state, varQ, quotient)
      Dict.set(state, varR, remainder)
    }
  },
  invert: state => {
    // Inverse: reconstruct a from quotient and remainder
    // a = (q * b) + r
    let valB = Dict.get(state, varB)->Option.getOr(1)
    let valQ = Dict.get(state, varQ)->Option.getOr(0)
    let valR = Dict.get(state, varR)->Option.getOr(0)

    let _reconstructed = (valQ * valB) + valR
    // In a full implementation, we might restore varA here:
    // Dict.set(state, varA, reconstructed)

    // Clear quotient and remainder (ancilla cleanup)
    Dict.set(state, varQ, 0)
    Dict.set(state, varR, 0)

    // Note: We don't restore varA here because DIV is typically used
    // to compute quotient/remainder, not to transform the dividend
  },
}

// Simpler version: divide and store quotient in ancilla
let makeSimple = (varA: string, varB: string, varQ: string): Instruction.t => {
  instructionType: "DIV_SIMPLE",
  args: [varA, varB, varQ],
  execute: state => {
    let valA = Dict.get(state, varA)->Option.getOr(0)
    let valB = Dict.get(state, varB)->Option.getOr(1)

    if valB != 0 {
      let quotient = valA / valB
      Dict.set(state, varQ, quotient)
    }
  },
  invert: state => {
    // Clear the quotient
    Dict.set(state, varQ, 0)
  },
}
