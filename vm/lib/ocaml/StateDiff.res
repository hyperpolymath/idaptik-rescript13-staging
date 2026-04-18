// SPDX-License-Identifier: PMPL-1.0-or-later
// StateDiff.res - Visual state comparison and diff utilities

type diff = {
  variable: string,
  before: option<int>,
  after: option<int>,
  changed: bool,
}

// Compare two states and generate diff
let computeDiff = (before: dict<int>, after: dict<int>): array<diff> => {
  // Get all unique variable names from both states
  let beforeKeys = Dict.keysToArray(before)
  let afterKeys = Dict.keysToArray(after)
  let allKeys = Array.flat([beforeKeys, afterKeys])
    ->Set.fromArray
    ->Set.toArray

  // Create diff for each variable
  allKeys->Array.map(variable => {
    let beforeVal = Dict.get(before, variable)
    let afterVal = Dict.get(after, variable)

    let changed = switch (beforeVal, afterVal) {
    | (Some(v1), Some(v2)) => v1 != v2
    | (None, Some(_)) => true
    | (Some(_), None) => true
    | (None, None) => false
    }

    {
      variable,
      before: beforeVal,
      after: afterVal,
      changed,
    }
  })
}

// Pretty print a single diff entry
let printDiffEntry = (d: diff): unit => {
  if d.changed {
    let beforeStr = switch d.before {
    | Some(v) => Int.toString(v)
    | None => ""
    }
    let afterStr = switch d.after {
    | Some(v) => Int.toString(v)
    | None => ""
    }
    Console.log(`  ${d.variable}: ${beforeStr}  ${afterStr} `)
  } else {
    switch d.before {
    | Some(v) => Console.log(`  ${d.variable}: ${Int.toString(v)} (unchanged)`)
    | None => ()
    }
  }
}

// Pretty print entire diff
let printDiff = (before: dict<int>, after: dict<int>): unit => {
  let diffs = computeDiff(before, after)
  let hasChanges = diffs->Array.some(d => d.changed)

  if hasChanges {
    Console.log(" State Changes:")
    diffs->Array.forEach(printDiffEntry)
  } else {
    Console.log(" No state changes")
  }
}

// Count number of differences
let countChanges = (before: dict<int>, after: dict<int>): int => {
  let diffs = computeDiff(before, after)
  diffs->Array.filter(d => d.changed)->Array.length
}

// Helper to pad string to length
let padLeft = (s: string, len: int): string => {
  let current = String.length(s)
  if current >= len {
    s
  } else {
    let padding = String.repeat(" ", len - current)
    padding ++ s
  }
}

let padRight = (s: string, len: int): string => {
  let current = String.length(s)
  if current >= len {
    s
  } else {
    let padding = String.repeat(" ", len - current)
    s ++ padding
  }
}

// Side-by-side comparison
let printSideBySide = (before: dict<int>, after: dict<int>): unit => {
  let diffs = computeDiff(before, after)

  Console.log("")
  Console.log(" Variable   Before   After   ")
  Console.log("")

  diffs->Array.forEach(d => {
    let beforeStr = switch d.before {
    | Some(v) => padLeft(Int.toString(v), 7)
    | None => "      "
    }
    let afterStr = switch d.after {
    | Some(v) => padLeft(Int.toString(v), 7)
    | None => "      "
    }
    let varPadded = padRight(d.variable, 9)
    let changeIndicator = if d.changed { "" } else { " " }

    Console.log(` ${varPadded}  ${beforeStr}  ${afterStr}  ${changeIndicator}`)
  })

  Console.log("")
}

// Check if all specified variables match target values
let matchesTarget = (
  current: dict<int>,
  target: dict<int>,
): bool => {
  State.statesMatch(current, target)
}

// Get variables that don't match target
let getMismatches = (
  current: dict<int>,
  target: dict<int>,
): array<string> => {
  let targetKeys = Dict.keysToArray(target)

  targetKeys->Array.filter(key => {
    let currentVal = Dict.get(current, key)
    let targetVal = Dict.get(target, key)

    switch (currentVal, targetVal) {
    | (Some(v1), Some(v2)) => v1 != v2
    | _ => true
    }
  })
}

// Print mismatches between current and target
let printMismatches = (
  current: dict<int>,
  target: dict<int>,
): unit => {
  let mismatches = getMismatches(current, target)

  if Array.length(mismatches) == 0 {
    Console.log(" All target values matched!")
  } else {
    Console.log(` ${Int.toString(Array.length(mismatches))} mismatches:`)
    mismatches->Array.forEach(key => {
      let currentVal = Dict.get(current, key)->Option.getOr(0)
      let targetVal = Dict.get(target, key)->Option.getOr(0)
      Console.log(`  ${key}: ${Int.toString(currentVal)} (expected ${Int.toString(targetVal)})`)
    })
  }
}
