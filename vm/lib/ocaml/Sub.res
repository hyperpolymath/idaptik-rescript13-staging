// SPDX-License-Identifier: PMPL-1.0-or-later
// SUB instruction - subtracts value of register b from register a

let make = (a: string, b: string): Instruction.t => {
  instructionType: "SUB",
  args: [a, b],
  execute: state => {
    let valA = Dict.get(state, a)->Option.getOr(0)
    let valB = Dict.get(state, b)->Option.getOr(0)
    Dict.set(state, a, valA - valB)
  },
  invert: state => {
    let valA = Dict.get(state, a)->Option.getOr(0)
    let valB = Dict.get(state, b)->Option.getOr(0)
    Dict.set(state, a, valA + valB)
  },
}
