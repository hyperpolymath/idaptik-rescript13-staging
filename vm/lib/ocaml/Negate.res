// SPDX-License-Identifier: PMPL-1.0-or-later
// NEGATE instruction - negates value of a register

let make = (a: string): Instruction.t => {
  let negateFn = state => {
    let valA = Dict.get(state, a)->Option.getOr(0)
    Dict.set(state, a, -valA)
  }

  {
    instructionType: "NEGATE",
    args: [a],
    execute: negateFn,
    invert: negateFn, // negating again undoes it
  }
}
