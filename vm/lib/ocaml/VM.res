// SPDX-License-Identifier: PMPL-1.0-or-later
// Reversible Virtual Machine
//
// The VM executes reversible instructions on a flat state dictionary.
// Every instruction has a provably correct inverse. The VM tracks
// execution history so any sequence of operations can be undone.
//
// State encoding: user registers are plain keys (x, y, z). Internal
// state (stack, memory, ports) uses underscore-prefixed keys managed
// by VmState.res. All state lives in one dict<int>.

type t = {
  mutable state: dict<int>,
  mutable history: array<Instruction.t>,
  subroutines: SubroutineRegistry.t,
}

// Create a new VM with initial register state
let make = (initial: dict<int>): t => {
  state: State.cloneState(initial),
  history: [],
  subroutines: SubroutineRegistry.make(),
}

// Run an instruction (forward execution)
let run = (vm: t, instr: Instruction.t): unit => {
  instr.execute(vm.state)
  vm.history = Array.concat(vm.history, [instr])
}

// Undo the last instruction (reverse execution)
let undo = (vm: t): option<Instruction.t> => {
  let len = Array.length(vm.history)
  if len > 0 {
    let lastInstr = Array.getUnsafe(vm.history, len - 1)
    lastInstr.invert(vm.state)
    vm.history = Array.slice(vm.history, ~start=0, ~end=len - 1)
    Some(lastInstr)
  } else {
    None
  }
}

// Undo all instructions (full rewind)
let undoAll = (vm: t): int => {
  let count = ref(0)
  let continue_ = ref(true)
  while continue_.contents {
    switch undo(vm) {
    | Some(_) => count := count.contents + 1
    | None => continue_ := false
    }
  }
  count.contents
}

// Print current state to console
let printState = (vm: t): unit => {
  Console.log2("Current State:", vm.state)
}

// Get current state (immutable copy  includes internal keys)
let getState = (vm: t): dict<int> => {
  State.cloneState(vm.state)
}

// Alias used by examples and puzzle solver
let getCurrentState = getState

// Get only user registers (no internal state like _sp, _mem:N, etc.)
let getRegisters = (vm: t): dict<int> => {
  VmState.getRegisters(vm.state)
}

// Get stack contents as array (bottom to top)
let getStack = (vm: t): array<int> => {
  VmState.getStackContents(vm.state)
}

// Get stack pointer
let getStackPointer = (vm: t): int => {
  VmState.getStackPointer(vm.state)
}

// Get memory cell value
let getMemoryAt = (vm: t, addr: int): int => {
  VmState.getMemory(vm.state, addr)
}

// Get a range of memory cells
let getMemoryRange = (vm: t, ~start: int, ~length: int): array<int> => {
  VmState.getMemoryRange(vm.state, ~start, ~length)
}

// Set a memory cell (for initialization, not tracked in history)
let setMemory = (vm: t, addr: int, value: int): unit => {
  VmState.setMemory(vm.state, addr, value)
}

// Reset VM to a specific state
let resetState = (vm: t, newState: dict<int>): unit => {
  vm.state = State.cloneState(newState)
  vm.history = []
}

// Get history length
let historyLength = (vm: t): int => {
  Array.length(vm.history)
}

// Get full execution history
let getHistory = (vm: t): array<Instruction.t> => {
  vm.history
}

// --- Subroutine management ---

// Define a named subroutine
let defineSubroutine = (vm: t, name: string, body: array<Instruction.t>): unit => {
  SubroutineRegistry.define(vm.subroutines, name, body)
}

// Call a named subroutine (resolves and executes as single history entry)
let callSubroutine = (vm: t, name: string): option<string> => {
  switch SubroutineRegistry.get(vm.subroutines, name) {
  | Some(body) => {
      let callInstr = Call.make(~name, ~body)
      run(vm, callInstr)
      None
    }
  | None => Some(`Subroutine "${name}" not defined`)
  }
}

// List defined subroutine names
let listSubroutines = (vm: t): array<string> => {
  SubroutineRegistry.list(vm.subroutines)
}

// --- Port I/O management ---

// Fill a port's input buffer with values (for game integration / testing)
let fillPortInput = (vm: t, port: string, values: array<int>): unit => {
  values->Array.forEachWithIndex((v, i) => {
    VmState.setPortInSlot(vm.state, port, i, v)
  })
}

// Read the port's output buffer (values written by SEND instructions)
let readPortOutput = (vm: t, port: string): array<int> => {
  VmState.getPortOutputContents(vm.state, port)
}
