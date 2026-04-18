// SPDX-License-Identifier: PMPL-1.0-or-later
// SEND  Write register value to a named port's output buffer
//
// Operation: port_out[ptr] = reg; ptr++
// Inverse:   ptr--; port_out[ptr] = 0
//
// SEND is the VM's way of communicating with game devices. Each port is
// a named channel (e.g., "firewall", "network", "display"). Values are
// appended to the port's output buffer.

let make = (port: string, reg: string): Instruction.t => {
  instructionType: "SEND",
  args: [port, reg],
  execute: state => {
    let regVal = Dict.get(state, reg)->Option.getOr(0)
    let ptr = VmState.getPortOutPointer(state, port)
    VmState.setPortOutSlot(state, port, ptr, regVal)
    VmState.setPortOutPointer(state, port, ptr + 1)
  },
  invert: state => {
    let ptr = VmState.getPortOutPointer(state, port)
    let newPtr = ptr - 1
    VmState.setPortOutSlot(state, port, newPtr, 0)
    VmState.setPortOutPointer(state, port, newPtr)
  },
}
