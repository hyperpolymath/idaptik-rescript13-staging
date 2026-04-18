// SPDX-License-Identifier: PMPL-1.0-or-later
// POP  Pop top of stack into register
//
// Janus semantics: register must be 0 before POP (precondition ensures
// no information is lost). The stack value moves into the register.
//
// Forward: sp--; reg = stack[sp]; stack[sp] = 0
// Inverse: stack[sp] = reg; sp++; reg = 0

let make = (reg: string): Instruction.t => {
  instructionType: "POP",
  args: [reg],
  execute: state => {
    let sp = VmState.getStackPointer(state)
    let newSp = sp - 1
    let value = VmState.getStackSlot(state, newSp)
    Dict.set(state, reg, value)
    VmState.clearStackSlot(state, newSp)
    VmState.setStackPointer(state, newSp)
  },
  invert: state => {
    let value = Dict.get(state, reg)->Option.getOr(0)
    let sp = VmState.getStackPointer(state)
    VmState.setStackSlot(state, sp, value)
    VmState.setStackPointer(state, sp + 1)
    Dict.set(state, reg, 0)
  },
}
