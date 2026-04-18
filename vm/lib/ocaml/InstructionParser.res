// SPDX-License-Identifier: PMPL-1.0-or-later
// InstructionParser.res - Parse text commands into Instruction.t
//
// Supports all 5 VM tiers:
//   Tier 0: ADD, SUB, SWAP, NEGATE, NOOP, XOR, FLIP, ROL, ROR, AND, OR, MUL, DIV
//   Tier 1: IF_ZERO, IF_POS (inline form; LOOP via programmatic API)
//   Tier 2: PUSH, POP, LOAD, STORE
//   Tier 3: CALL (requires subroutine resolver)
//   Tier 4: SEND, RECV

type parseResult =
  | Ok(Instruction.t)
  | Error(string)

// Internal parser with optional subroutine resolver for CALL
let rec parseInternal = (
  input: string,
  resolve: option<string => option<array<Instruction.t>>>,
): parseResult => {
  let trimmed = String.trim(input)
  let tokens = String.split(trimmed, " ")
    ->Array.filter(t => String.length(String.trim(t)) > 0)

  if Array.length(tokens) == 0 {
    Error("Empty command")
  } else {
    let opcode = Array.getUnsafe(tokens, 0)->String.toUpperCase
    let argCount = Array.length(tokens) - 1
    let arg = (i: int) => Array.getUnsafe(tokens, i + 1)

    switch opcode {
    // --- Tier 0: Register arithmetic ---
    | "ADD" =>
      if argCount == 2 {
        Ok(Add.make(arg(0), arg(1)))
      } else {
        Error("ADD requires 2 arguments: ADD <a> <b>")
      }
    | "SUB" =>
      if argCount == 2 {
        Ok(Sub.make(arg(0), arg(1)))
      } else {
        Error("SUB requires 2 arguments: SUB <a> <b>")
      }
    | "SWAP" =>
      if argCount == 2 {
        Ok(Swap.make(arg(0), arg(1)))
      } else {
        Error("SWAP requires 2 arguments: SWAP <a> <b>")
      }
    | "XOR" =>
      if argCount == 2 {
        Ok(Xor.make(arg(0), arg(1)))
      } else {
        Error("XOR requires 2 arguments: XOR <a> <b>")
      }
    | "NEGATE" =>
      if argCount == 1 {
        Ok(Negate.make(arg(0)))
      } else {
        Error("NEGATE requires 1 argument: NEGATE <a>")
      }
    | "FLIP" =>
      if argCount == 1 {
        Ok(Flip.make(arg(0)))
      } else {
        Error("FLIP requires 1 argument: FLIP <a>")
      }
    | "NOOP" =>
      if argCount == 0 {
        Ok(Noop.make())
      } else {
        Error("NOOP takes no arguments")
      }
    | "ROL" =>
      if argCount == 1 {
        Ok(Rol.make(arg(0), ()))
      } else if argCount == 2 {
        switch Int.fromString(arg(1)) {
        | Some(bits) => Ok(Rol.make(arg(0), ~bits, ()))
        | None => Error("ROL second argument must be an integer: ROL <a> [bits]")
        }
      } else {
        Error("ROL requires 1-2 arguments: ROL <a> [bits]")
      }
    | "ROR" =>
      if argCount == 1 {
        Ok(Ror.make(arg(0), ()))
      } else if argCount == 2 {
        switch Int.fromString(arg(1)) {
        | Some(bits) => Ok(Ror.make(arg(0), ~bits, ()))
        | None => Error("ROR second argument must be an integer: ROR <a> [bits]")
        }
      } else {
        Error("ROR requires 1-2 arguments: ROR <a> [bits]")
      }
    | "AND" =>
      if argCount == 3 {
        Ok(And.make(arg(0), arg(1), arg(2)))
      } else {
        Error("AND requires 3 arguments: AND <a> <b> <c> (c = ancilla, must be 0)")
      }
    | "OR" =>
      if argCount == 3 {
        Ok(Or.make(arg(0), arg(1), arg(2)))
      } else {
        Error("OR requires 3 arguments: OR <a> <b> <c> (c = ancilla, must be 0)")
      }
    | "MUL" =>
      if argCount == 3 {
        Ok(Mul.make(arg(0), arg(1), arg(2)))
      } else {
        Error("MUL requires 3 arguments: MUL <a> <b> <c> (c = ancilla)")
      }
    | "DIV" =>
      if argCount == 4 {
        Ok(Div.make(arg(0), arg(1), arg(2), arg(3)))
      } else {
        Error("DIV requires 4 arguments: DIV <a> <b> <q> <r>")
      }

    // --- Tier 1: Conditional execution ---
    // Simple inline form: IF_ZERO <testReg> <exitReg> <instruction>
    | "IF_ZERO" =>
      if argCount >= 3 {
        let testReg = arg(0)
        let exitReg = arg(1)
        let bodyText = Array.sliceToEnd(tokens, ~start=3)->Array.joinWith(" ")
        switch parseInternal(bodyText, resolve) {
        | Ok(bodyInstr) =>
          Ok(IfZero.make(~testReg, ~exitReg, ~thenBranch=[bodyInstr], ~elseBranch=[]))
        | Error(e) => Error(`IF_ZERO body parse error: ${e}`)
        }
      } else {
        Error("IF_ZERO requires at least 3 arguments: IF_ZERO <testReg> <exitReg> <instruction...>")
      }
    | "IF_POS" =>
      if argCount >= 3 {
        let testReg = arg(0)
        let exitReg = arg(1)
        let bodyText = Array.sliceToEnd(tokens, ~start=3)->Array.joinWith(" ")
        switch parseInternal(bodyText, resolve) {
        | Ok(bodyInstr) =>
          Ok(IfPos.make(~testReg, ~exitReg, ~thenBranch=[bodyInstr], ~elseBranch=[]))
        | Error(e) => Error(`IF_POS body parse error: ${e}`)
        }
      } else {
        Error("IF_POS requires at least 3 arguments: IF_POS <testReg> <exitReg> <instruction...>")
      }

    // --- Tier 2: Stack and memory ---
    | "PUSH" =>
      if argCount == 1 {
        Ok(Push.make(arg(0)))
      } else {
        Error("PUSH requires 1 argument: PUSH <reg>")
      }
    | "POP" =>
      if argCount == 1 {
        Ok(Pop.make(arg(0)))
      } else {
        Error("POP requires 1 argument: POP <reg>")
      }
    | "LOAD" =>
      if argCount == 2 {
        switch Int.fromString(arg(1)) {
        | Some(addr) => Ok(Load.make(arg(0), addr))
        | None => Error("LOAD second argument must be an integer address: LOAD <reg> <addr>")
        }
      } else {
        Error("LOAD requires 2 arguments: LOAD <reg> <addr>")
      }
    | "STORE" =>
      if argCount == 2 {
        switch Int.fromString(arg(0)) {
        | Some(addr) => Ok(Store.make(addr, arg(1)))
        | None => Error("STORE first argument must be an integer address: STORE <addr> <reg>")
        }
      } else {
        Error("STORE requires 2 arguments: STORE <addr> <reg>")
      }

    // --- Tier 3: Subroutines ---
    | "CALL" =>
      if argCount == 1 {
        let name = arg(0)
        switch resolve {
        | Some(resolveFunc) =>
          switch resolveFunc(name) {
          | Some(body) => Ok(Call.make(~name, ~body))
          | None => Error(`CALL: subroutine "${name}" not defined`)
          }
        | None =>
          Error("CALL requires subroutine context. Use VM.callSubroutine() or parseExtended().")
        }
      } else {
        Error("CALL requires 1 argument: CALL <name>")
      }

    // --- Tier 4: I/O channels ---
    | "SEND" =>
      if argCount == 2 {
        Ok(Send.make(arg(0), arg(1)))
      } else {
        Error("SEND requires 2 arguments: SEND <port> <reg>")
      }
    | "RECV" =>
      if argCount == 2 {
        Ok(Recv.make(arg(0), arg(1)))
      } else {
        Error("RECV requires 2 arguments: RECV <port> <reg>")
      }

    | unknown => Error(`Unknown instruction: "${unknown}". Type 'help' or '?' for available instructions.`)
    }
  }
}

// Parse a text command (backward compatible  no subroutine context)
let parse = (input: string): parseResult => {
  parseInternal(input, None)
}

// Parse with subroutine resolution (for CALL support)
let parseExtended = (
  input: string,
  ~resolveSubroutine: string => option<array<Instruction.t>>,
): parseResult => {
  parseInternal(input, Some(resolveSubroutine))
}

// Help text listing all available instructions
let helpText = (): string => {
  `TIER 0  Register arithmetic:
  ADD <a> <b>          a = a + b (inverse: a = a - b)
  SUB <a> <b>          a = a - b (inverse: a = a + b)
  SWAP <a> <b>         Exchange values of a and b (self-inverse)
  XOR <a> <b>          a = a XOR b (self-inverse)
  NEGATE <a>           a = -a (self-inverse)
  FLIP <a>             a = NOT a (bitwise complement, self-inverse)
  ROL <a> [bits]       Rotate a left by bits (default 1)
  ROR <a> [bits]       Rotate a right by bits (default 1)
  AND <a> <b> <c>      c = a AND b (c must be 0, ancilla pattern)
  OR <a> <b> <c>       c = a OR b (c must be 0, ancilla pattern)
  MUL <a> <b> <c>      c = c + (a * b) (ancilla pattern)
  DIV <a> <b> <q> <r>  q = a/b, r = a mod b (ancilla pattern)
  NOOP                 No operation

TIER 1  Conditional execution (Janus-style reversible):
  IF_ZERO <test> <exit> <instr>   Execute instr if test == 0
  IF_POS <test> <exit> <instr>    Execute instr if test > 0
  (Block-structured IF/LOOP available via programmatic API)

TIER 2  Stack and memory:
  PUSH <reg>           Push reg onto stack, zero reg (inverse: POP)
  POP <reg>            Pop stack into reg, reg must be 0 (inverse: PUSH)
  LOAD <reg> <addr>    reg += memory[addr] (additive, non-destructive)
  STORE <addr> <reg>   memory[addr] += reg (additive, non-destructive)

TIER 3  Subroutines:
  CALL <name>          Execute named subroutine (single undo step)

TIER 4  I/O channels:
  SEND <port> <reg>    Write reg to port output buffer
  RECV <port> <reg>    Read port input buffer into reg (additive)

REPL COMMANDS:
  undo, u              Undo last move
  hint, h              Show next hint
  status, s            Show current state and progress
  diff, d              Show state comparison with goal
  reset, r             Reset puzzle to initial state
  help, ?              Show this help message
  quit, q              Exit puzzle`
}
