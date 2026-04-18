// SPDX-License-Identifier: PMPL-1.0-or-later
// SWAP instruction - swaps values of two registers

let make = (a: string, b: string): Instruction.t => {
  let swapFn = state => {
    let valA = Dict.get(state, a)->Option.getOr(0)
    let valB = Dict.get(state, b)->Option.getOr(0)
    Dict.set(state, a, valB)
    Dict.set(state, b, valA)
  }

  {
    instructionType: "SWAP",
    args: [a, b],
    execute: swapFn,
    invert: swapFn, // swap is its own inverse
  }
}
