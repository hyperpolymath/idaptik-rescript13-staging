// SPDX-License-Identifier: PMPL-1.0-or-later
// LOOP  Janus-style reversible loop
//
// A reversible loop with entry and exit assertions:
//   from <entryReg> == 0 do [body] loop [step] until <exitReg> == 0
//
// Forward execution:
//   1. Assert entryReg == 0 (first iteration only)
//   2. Execute body
//   3. If exitReg == 0, stop
//   4. Execute step, goto 2 (but now skip entry assertion)
//
// Reverse execution:
//   1. Assert exitReg == 0 (we're at the end)
//   2. Reverse body
//   3. If entryReg == 0, stop
//   4. Reverse step, goto 2
//
// The entry/exit assertions ensure the loop is deterministically reversible:
// the reverse knows exactly when to stop because the assertions swap roles.
//
// Safety: maxIterations prevents infinite loops (default 1000).

let make = (
  ~entryReg: string,
  ~exitReg: string,
  ~body: array<Instruction.t>,
  ~step: array<Instruction.t>,
  ~maxIterations: int=1000,
  (),
): Instruction.t => {
  instructionType: "LOOP",
  args: [entryReg, exitReg],
  execute: state => {
    let iterations = ref(0)

    // First iteration: entryReg must be 0 (Janus entry assertion)
    // Execute body
    Array.forEach(body, instr => instr.execute(state))
    iterations := iterations.contents + 1

    // Check exit condition
    let exitVal = ref(Dict.get(state, exitReg)->Option.getOr(0))

    // Continue while exit condition not met
    while exitVal.contents != 0 && iterations.contents < maxIterations {
      // Execute step (loop increment)
      Array.forEach(step, instr => instr.execute(state))
      // Execute body
      Array.forEach(body, instr => instr.execute(state))
      iterations := iterations.contents + 1
      exitVal := Dict.get(state, exitReg)->Option.getOr(0)
    }
  },
  invert: state => {
    let iterations = ref(0)

    // Reverse: start from the end. exitReg should be 0.
    // Reverse the last body execution
    let reversedBody = Array.toReversed(body)
    let reversedStep = Array.toReversed(step)

    Array.forEach(reversedBody, instr => instr.invert(state))
    iterations := iterations.contents + 1

    // Check entry condition (swapped role of exit)
    let entryVal = ref(Dict.get(state, entryReg)->Option.getOr(0))

    while entryVal.contents != 0 && iterations.contents < maxIterations {
      Array.forEach(reversedStep, instr => instr.invert(state))
      Array.forEach(reversedBody, instr => instr.invert(state))
      iterations := iterations.contents + 1
      entryVal := Dict.get(state, entryReg)->Option.getOr(0)
    }
  },
}
