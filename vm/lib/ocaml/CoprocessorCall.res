// SPDX-License-Identifier: PMPL-1.0-or-later
// CoprocessorCall.res  Tombstone — this instruction was not implemented.
//
// Design intent:
//   An early design sketched a COPROC_CALL instruction that would let VM
//   programs dispatch coprocessor operations as a reversible instruction.
//   The idea was superseded by the terminal-level SEND/RECV commands
//   (CoprocessorBridge.res) together with the VM Tier 4 port instructions
//   (Send.res + Recv.res).
//
// Why this file exists:
//   Removing the file entirely would cause a ReScript module-not-found error
//   in any InstructionParser.res reference that was left behind.  This stub
//   preserves the module name with a clear explanation so that future
//   contributors understand why it is empty.
//
// Current architecture (replaces this instruction):
//   - Terminal SEND <domain>:<cmd> [int ...]  — dispatches an async op via
//     CoprocessorManager.call, confirmed immediately, result buffered.
//   - Terminal RECV                           — drains the result buffer.
//   - VM SEND port value                      — Tier 4 reversible port send.
//   - VM RECV port reg                        — Tier 4 reversible port recv.
//
// If a true reversible COPROC_CALL instruction is ever designed, it MUST
// satisfy the key invariant: execute(state) → S', invert(S') → S exactly.
// Async resolution makes this non-trivial; see the Reversibility Patterns
// section of the VM CLAUDE.md for guidance.
