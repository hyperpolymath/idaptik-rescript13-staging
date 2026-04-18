// SPDX-License-Identifier: PMPL-1.0-or-later
// PUSH  Push register value onto stack, zero the register
//
// Janus semantics: PUSH saves the register's value on the stack and
// clears the register to 0. This is cleanly reversible because the
// inverse (POP) restores the value from the stack.
//
// Forward: stack[sp] = reg; sp++; reg = 0
// Inverse: sp--; reg = stack[sp]; stack[sp] = 0

let make = (reg: string): Instruction.t => {
  instructionType: "PUSH",
  args: [reg],
  execute: state => {
    let value = Dict.get(state, reg)->Option.getOr(0)
    let sp = VmState.getStackPointer(state)
    VmState.setStackSlot(state, sp, value)
    VmState.setStackPointer(state, sp + 1)
    Dict.set(state, reg, 0)
  },
  invert: state => {
    let sp = VmState.getStackPointer(state)
    let newSp = sp - 1
    let value = VmState.getStackSlot(state, newSp)
    Dict.set(state, reg, value)
    VmState.clearStackSlot(state, newSp)
    VmState.setStackPointer(state, newSp)
  },
}
