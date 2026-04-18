// SPDX-License-Identifier: PMPL-1.0-or-later
// NOOP instruction - no operation (does nothing)

let make = (): Instruction.t => {
  instructionType: "NOOP",
  args: [],
  execute: _state => (),
  invert: _state => (),
}
