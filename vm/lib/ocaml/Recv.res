// SPDX-License-Identifier: PMPL-1.0-or-later
// RECV  Read from a named port's input buffer into register (additive)
//
// Operation: reg += port_in[ptr]; ptr++
// Inverse:   ptr--; reg -= port_in[ptr]
//
// RECV reads the next value from the port's input buffer and adds it to
// the register. The additive semantics preserve reversibility  the
// inverse subtracts the same value and decrements the pointer.

let make = (port: string, reg: string): Instruction.t => {
  instructionType: "RECV",
  args: [port, reg],
  execute: state => {
    let ptr = VmState.getPortInPointer(state, port)
    let value = VmState.getPortInSlot(state, port, ptr)
    let regVal = Dict.get(state, reg)->Option.getOr(0)
    Dict.set(state, reg, regVal + value)
    VmState.setPortInPointer(state, port, ptr + 1)
  },
  invert: state => {
    let ptr = VmState.getPortInPointer(state, port)
    let newPtr = ptr - 1
    let value = VmState.getPortInSlot(state, port, newPtr)
    let regVal = Dict.get(state, reg)->Option.getOr(0)
    Dict.set(state, reg, regVal - value)
    VmState.setPortInPointer(state, port, newPtr)
  },
}
