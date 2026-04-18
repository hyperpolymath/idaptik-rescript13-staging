// SPDX-License-Identifier: PMPL-1.0-or-later
// IF_ZERO  Janus-style reversible conditional
//
// Executes a sequence of instructions if register `a` == 0.
// The exit assertion `exitReg` must also be zero after the then-branch,
// or non-zero after the else-branch. This lets the reverse execution
// determine which branch was taken without storing a flag.
//
// Forward:  if a == 0 then [thenBranch] else [elseBranch]
//           assert: exitReg == 0 after then, exitReg != 0 after else
// Reverse:  if exitReg == 0 then reverse(thenBranch) else reverse(elseBranch)
//           assert: a == 0 after reversing then, a != 0 after reversing else

let make = (
  ~testReg: string,
  ~exitReg: string,
  ~thenBranch: array<Instruction.t>,
  ~elseBranch: array<Instruction.t>,
): Instruction.t => {
  instructionType: "IF_ZERO",
  args: [testReg, exitReg],
  execute: state => {
    let testVal = Dict.get(state, testReg)->Option.getOr(0)
    if testVal == 0 {
      // Execute then-branch
      Array.forEach(thenBranch, instr => instr.execute(state))
    } else {
      // Execute else-branch
      Array.forEach(elseBranch, instr => instr.execute(state))
    }
  },
  invert: state => {
    // Reverse uses the exit assertion to determine which branch was taken
    let exitVal = Dict.get(state, exitReg)->Option.getOr(0)
    if exitVal == 0 {
      // Was then-branch  reverse it (instructions in reverse order)
      let reversed = Array.toReversed(thenBranch)
      Array.forEach(reversed, instr => instr.invert(state))
    } else {
      // Was else-branch  reverse it
      let reversed = Array.toReversed(elseBranch)
      Array.forEach(reversed, instr => instr.invert(state))
    }
  },
}
