// SPDX-License-Identifier: PMPL-1.0-or-later
// CALL  Execute a named subroutine as a single reversible operation
//
// The subroutine body is captured at instruction creation time. Forward
// execution runs all body instructions in order. Reversal runs all body
// instructions in reverse order, invoking each one's inverse.
//
// CALL appears as a single entry in the VM's history, so "undo" reverses
// the entire subroutine at once  not individual body instructions.

let make = (~name: string, ~body: array<Instruction.t>): Instruction.t => {
  instructionType: "CALL",
  args: [name],
  execute: state => {
    Array.forEach(body, instr => instr.execute(state))
  },
  invert: state => {
    let reversed = Array.toReversed(body)
    Array.forEach(reversed, instr => instr.invert(state))
  },
}
