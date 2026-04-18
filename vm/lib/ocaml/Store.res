// SPDX-License-Identifier: PMPL-1.0-or-later
// STORE  Additive store from register into memory
//
// Operation: memory[addr] += reg
// Inverse:   memory[addr] -= reg
//
// This is an additive (non-destructive) store  the register value is
// preserved, and memory accumulates the register value. The inverse
// simply subtracts.

let make = (addr: int, reg: string): Instruction.t => {
  instructionType: "STORE",
  args: [Int.toString(addr), reg],
  execute: state => {
    let regVal = Dict.get(state, reg)->Option.getOr(0)
    let memVal = VmState.getMemory(state, addr)
    VmState.setMemory(state, addr, memVal + regVal)
  },
  invert: state => {
    let regVal = Dict.get(state, reg)->Option.getOr(0)
    let memVal = VmState.getMemory(state, addr)
    VmState.setMemory(state, addr, memVal - regVal)
  },
}
