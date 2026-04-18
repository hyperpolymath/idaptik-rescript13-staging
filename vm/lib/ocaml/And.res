// SPDX-License-Identifier: PMPL-1.0-or-later
// AND instruction - Bitwise AND with ancilla
// Operation: c = a AND b (requires c to be 0 initially)
// Inverse: c = 0 (clear c)
// This is reversible using Bennett's trick: we store the result in an ancilla

let make = (varA: string, varB: string, varC: string): Instruction.t => {
  instructionType: "AND",
  args: [varA, varB, varC],
  execute: state => {
    let valA = Dict.get(state, varA)->Option.getOr(0)
    let valB = Dict.get(state, varB)->Option.getOr(0)
    // Bitwise AND: c = a & b
    let result = land(valA, valB)
    Dict.set(state, varC, result)
  },
  invert: state => {
    // Inverse: clear the ancilla (set c to 0)
    // This assumes c was 0 before execute
    Dict.set(state, varC, 0)
  },
}
