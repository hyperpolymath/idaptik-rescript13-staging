// SPDX-License-Identifier: PMPL-1.0-or-later
// VmState.res  Helpers for accessing stack, memory, and port state
//
// The VM uses a flat dict<int> for all state. Stack, memory, and ports
// are encoded with reserved key prefixes:
//   _sp           stack pointer (grows upward from 0)
//   _s:N          stack slot at index N
//   _mem:N        memory address N (0-255)
//   _csp          call stack pointer
//   _cs:N         call stack slot N
//   _pin:PORT     port input read pointer
//   _pout:PORT    port output write pointer
//   _pi:PORT:N    port input buffer slot N
//   _po:PORT:N    port output buffer slot N
//
// User registers use plain names (x, y, z, etc.) and never collide with
// these underscore-prefixed internal keys.

let memorySize = 256

// --- Stack operations ---

let getStackPointer = (state: dict<int>): int =>
  Dict.get(state, "_sp")->Option.getOr(0)

let setStackPointer = (state: dict<int>, sp: int): unit =>
  Dict.set(state, "_sp", sp)

let getStackSlot = (state: dict<int>, index: int): int =>
  Dict.get(state, `_s:${Int.toString(index)}`)->Option.getOr(0)

let setStackSlot = (state: dict<int>, index: int, value: int): unit =>
  Dict.set(state, `_s:${Int.toString(index)}`, value)

let clearStackSlot = (state: dict<int>, index: int): unit =>
  Dict.set(state, `_s:${Int.toString(index)}`, 0)

// --- Memory operations ---

let getMemory = (state: dict<int>, addr: int): int =>
  Dict.get(state, `_mem:${Int.toString(addr)}`)->Option.getOr(0)

let setMemory = (state: dict<int>, addr: int, value: int): unit =>
  Dict.set(state, `_mem:${Int.toString(addr)}`, value)

// --- Call stack operations ---

let getCallStackPointer = (state: dict<int>): int =>
  Dict.get(state, "_csp")->Option.getOr(0)

let setCallStackPointer = (state: dict<int>, csp: int): unit =>
  Dict.set(state, "_csp", csp)

let getCallStackSlot = (state: dict<int>, index: int): int =>
  Dict.get(state, `_cs:${Int.toString(index)}`)->Option.getOr(0)

let setCallStackSlot = (state: dict<int>, index: int, value: int): unit =>
  Dict.set(state, `_cs:${Int.toString(index)}`, value)

// --- Port operations ---

let getPortInPointer = (state: dict<int>, port: string): int =>
  Dict.get(state, `_pin:${port}`)->Option.getOr(0)

let setPortInPointer = (state: dict<int>, port: string, ptr: int): unit =>
  Dict.set(state, `_pin:${port}`, ptr)

let getPortOutPointer = (state: dict<int>, port: string): int =>
  Dict.get(state, `_pout:${port}`)->Option.getOr(0)

let setPortOutPointer = (state: dict<int>, port: string, ptr: int): unit =>
  Dict.set(state, `_pout:${port}`, ptr)

let getPortInSlot = (state: dict<int>, port: string, index: int): int =>
  Dict.get(state, `_pi:${port}:${Int.toString(index)}`)->Option.getOr(0)

let setPortInSlot = (state: dict<int>, port: string, index: int, value: int): unit =>
  Dict.set(state, `_pi:${port}:${Int.toString(index)}`, value)

let getPortOutSlot = (state: dict<int>, port: string, index: int): int =>
  Dict.get(state, `_po:${port}:${Int.toString(index)}`)->Option.getOr(0)

let setPortOutSlot = (state: dict<int>, port: string, index: int, value: int): unit =>
  Dict.set(state, `_po:${port}:${Int.toString(index)}`, value)

// --- Introspection ---

let isInternalKey = (key: string): bool =>
  String.startsWith(key, "_")

// Get only user registers (no internal keys)
let getRegisters = (state: dict<int>): dict<int> => {
  let regs = Dict.make()
  state->Dict.toArray->Array.forEach(((key, value)) => {
    if !isInternalKey(key) {
      Dict.set(regs, key, value)
    }
  })
  regs
}

// Get stack contents as array (bottom to top)
let getStackContents = (state: dict<int>): array<int> => {
  let sp = getStackPointer(state)
  Array.fromInitializer(~length=sp, i => getStackSlot(state, i))
}

// Get a range of memory cells
let getMemoryRange = (state: dict<int>, ~start: int, ~length: int): array<int> =>
  Array.fromInitializer(~length, i => getMemory(state, start + i))

// Get port output buffer contents
let getPortOutputContents = (state: dict<int>, port: string): array<int> => {
  let ptr = getPortOutPointer(state, port)
  Array.fromInitializer(~length=ptr, i => getPortOutSlot(state, port, i))
}

// Get port input buffer contents (unread portion)
let getPortInputRemaining = (state: dict<int>, port: string, ~totalItems: int): array<int> => {
  let ptr = getPortInPointer(state, port)
  Array.fromInitializer(~length=totalItems - ptr, i => getPortInSlot(state, port, ptr + i))
}
