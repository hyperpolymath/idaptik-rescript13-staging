// SPDX-License-Identifier: PMPL-1.0-or-later
// IF_POS  Janus-style reversible conditional for positive values
//
// Executes a sequence of instructions if register `a` > 0.
// The exit assertion `exitReg` must be > 0 after the then-branch,
// or <= 0 after the else-branch.
//
// Forward:  if a > 0 then [thenBranch] else [elseBranch]
//           assert: exitReg > 0 after then, exitReg <= 0 after else
// Reverse:  if exitReg > 0 then reverse(thenBranch) else reverse(elseBranch)
//           assert: a > 0 after reversing then, a <= 0 after reversing else

let make = (
  ~testReg: string,
  ~exitReg: string,
  ~thenBranch: array<Instruction.t>,
  ~elseBranch: array<Instruction.t>,
): Instruction.t => {
  instructionType: "IF_POS",
  args: [testReg, exitReg],
  execute: state => {
    let testVal = Dict.get(state, testReg)->Option.getOr(0)
    if testVal > 0 {
      Array.forEach(thenBranch, instr => instr.execute(state))
    } else {
      Array.forEach(elseBranch, instr => instr.execute(state))
    }
  },
  invert: state => {
    let exitVal = Dict.get(state, exitReg)->Option.getOr(0)
    if exitVal > 0 {
      let reversed = Array.toReversed(thenBranch)
      Array.forEach(reversed, instr => instr.invert(state))
    } else {
      let reversed = Array.toReversed(elseBranch)
      Array.forEach(reversed, instr => instr.invert(state))
    }
  },
}
