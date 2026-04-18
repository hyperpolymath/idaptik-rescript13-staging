// SPDX-License-Identifier: PMPL-1.0-or-later
// XOR instruction - Bitwise exclusive OR
// Operation: a = a XOR b
// Inverse: a = a XOR b (XOR is self-inverse when applied with same operand)

let make = (varA: string, varB: string): Instruction.t => {
  instructionType: "XOR",
  args: [varA, varB],
  execute: state => {
    let valA = Dict.get(state, varA)->Option.getOr(0)
    let valB = Dict.get(state, varB)->Option.getOr(0)
    // Bitwise XOR using land/lor/lnot operators
    let result = lor(land(valA, lnot(valB)), land(lnot(valA), valB))
    Dict.set(state, varA, result)
  },
  invert: state => {
    // XOR is self-inverse: (a XOR b) XOR b = a
    let valA = Dict.get(state, varA)->Option.getOr(0)
    let valB = Dict.get(state, varB)->Option.getOr(0)
    let result = lor(land(valA, lnot(valB)), land(lnot(valA), valB))
    Dict.set(state, varA, result)
  },
}
