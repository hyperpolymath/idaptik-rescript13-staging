// SPDX-License-Identifier: PMPL-1.0-or-later
// LOAD  Additive load from memory into register
//
// Operation: reg += memory[addr]
// Inverse:   reg -= memory[addr]
//
// This is an additive (non-destructive) load  memory contents are
// preserved, and the register accumulates the memory value. The inverse
// simply subtracts, restoring the original register value.
//
// To zero-initialize a register from memory, ensure reg=0 before LOAD.

let make = (reg: string, addr: int): Instruction.t => {
  instructionType: "LOAD",
  args: [reg, Int.toString(addr)],
  execute: state => {
    let regVal = Dict.get(state, reg)->Option.getOr(0)
    let memVal = VmState.getMemory(state, addr)
    Dict.set(state, reg, regVal + memVal)
  },
  invert: state => {
    let regVal = Dict.get(state, reg)->Option.getOr(0)
    let memVal = VmState.getMemory(state, addr)
    Dict.set(state, reg, regVal - memVal)
  },
}
