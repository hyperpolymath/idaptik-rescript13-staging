// SPDX-License-Identifier: PMPL-1.0-or-later
// SubroutineRegistry  Named subroutine lookup for CALL instructions
//
// Subroutines are defined externally (by puzzle data, level scripts, etc.)
// and registered by name. CALL instructions resolve the body from this
// registry at creation time.

type t = {
  mutable definitions: dict<array<Instruction.t>>,
}

let make = (): t => {
  definitions: Dict.make(),
}

// Define a named subroutine
let define = (registry: t, name: string, body: array<Instruction.t>): unit => {
  Dict.set(registry.definitions, name, body)
}

// Look up a subroutine by name
let get = (registry: t, name: string): option<array<Instruction.t>> => {
  Dict.get(registry.definitions, name)
}

// Check if a subroutine exists
let has = (registry: t, name: string): bool => {
  Dict.get(registry.definitions, name)->Option.isSome
}

// List all defined subroutine names
let list = (registry: t): array<string> => {
  Dict.keysToArray(registry.definitions)
}

// Remove a subroutine definition
let remove = (registry: t, name: string): unit => {
  let newDefs = Dict.make()
  registry.definitions->Dict.toArray->Array.forEach(((key, value)) => {
    if key != name {
      Dict.set(newDefs, key, value)
    }
  })
  registry.definitions = newDefs
}
