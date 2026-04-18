// SPDX-License-Identifier: PMPL-1.0-or-later
// Core reversible instruction interface
type t = {
  instructionType: string,
  args: array<string>,
  execute: dict<int> => unit,
  invert: dict<int> => unit,
}

// Helper to create instruction records
let make = (~instructionType, ~args, ~execute, ~invert) => {
  instructionType,
  args,
  execute,
  invert,
}
