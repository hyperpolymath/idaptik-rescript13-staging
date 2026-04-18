// SPDX-License-Identifier: PMPL-1.0-or-later
// State management for reversible VM

// Create a register state from a list of variable names
let createState = (~variables: array<string>, ~initialValue=0): dict<int> => {
  let state = Dict.make()
  variables->Array.forEach(v => {
    Dict.set(state, v, initialValue)
  })
  state
}

// Deep clone the current state (for logging, snapshots, etc.)
let cloneState = (state: dict<int>): dict<int> => {
  let newState = Dict.make()
  state
  ->Dict.toArray
  ->Array.forEach(((key, value)) => {
    Dict.set(newState, key, value)
  })
  newState
}

// Check if two states are equal (used in puzzle goals)
let statesMatch = (a: dict<int>, b: dict<int>): bool => {
  let keysA = Dict.keysToArray(a)
  let keysB = Dict.keysToArray(b)

  let allKeys = Set.fromArray(
    Array.concat(keysA, keysB)
  )

  allKeys
  ->Set.toArray
  ->Array.every(key => {
    Dict.get(a, key) == Dict.get(b, key)
  })
}

// Serialize state to JSON string
let serializeState = (state: dict<int>): string => {
  JSON.stringifyAny(state)->Option.getOr("{}")
}

// Deserialize state from JSON string
let deserializeState = (json: string): dict<int> => {
  try {
    let parsed = JSON.parseExn(json)
    let result = Dict.make()
    switch JSON.Classify.classify(parsed) {
    | Object(obj) =>
      obj->Dict.toArray->Array.forEach(((key, value)) => {
        switch JSON.Classify.classify(value) {
        | Number(n) => Dict.set(result, key, Float.toInt(n))
        | _ => ()
        }
      })
    | _ => ()
    }
    result
  } catch {
  | _ => Dict.make()
  }
}
