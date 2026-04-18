// SPDX-License-Identifier: PMPL-1.0-or-later
// Benchmark suite for Idaptik VM

@val @scope("Date") external now: unit => float = "now"

// Benchmark helper
let benchmark = (name: string, iterations: int, fn: unit => unit): unit => {
  // Warm up
  for _ in 1 to 100 {
    fn()
  }

  // Actual benchmark
  let startTime = now()

  for _ in 1 to iterations {
    fn()
  }

  let endTime = now()
  let totalTime = endTime -. startTime
  let avgTime = totalTime /. float_of_int(iterations)

  Console.log(`${name}:`)
  Console.log(`  Total: ${Float.toString(totalTime)} ms`)
  Console.log(`  Iterations: ${Int.toString(iterations)}`)
  Console.log(`  Average: ${Float.toString(avgTime)} ms per iteration`)
  Console.log(`  Throughput: ${Float.toString(1000.0 /. avgTime)} ops/sec`)
  Console.log("")
}

// Benchmark ADD instruction
let benchmarkAdd = (): unit => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 10)
  Dict.set(state, "y", 5)

  let instr = Add.make("x", "y")

  benchmark("ADD execute", 100000, () => {
    instr.execute(state)
  })
}

// Benchmark SWAP instruction
let benchmarkSwap = (): unit => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  Dict.set(state, "x", 10)
  Dict.set(state, "y", 20)

  let instr = Swap.make("x", "y")

  benchmark("SWAP execute", 100000, () => {
    instr.execute(state)
  })
}

// Benchmark VM execution
let benchmarkVM = (): unit => {
  let state = State.createState(~variables=["x", "y", "z"], ~initialValue=0)
  Dict.set(state, "x", 10)
  Dict.set(state, "y", 5)

  let vm = VM.make(state)

  benchmark("VM run (ADD)", 50000, () => {
    VM.run(vm, Add.make("x", "y"))
  })
}

// Benchmark state cloning
let benchmarkStateClone = (): unit => {
  let state = State.createState(~variables=["a", "b", "c", "d", "e", "f", "g", "h"], ~initialValue=0)
  for i in 0 to 7 {
    let vars = ["a", "b", "c", "d", "e", "f", "g", "h"]
    Dict.set(state, Array.getUnsafe(vars, i), i * 10)
  }

  benchmark("State clone (8 vars)", 50000, () => {
    let _ = State.cloneState(state)
  })
}

// Benchmark undo operation
let benchmarkUndo = (): unit => {
  let state = State.createState(~variables=["x", "y"], ~initialValue=0)
  let vm = VM.make(state)

  // Build up history
  for i in 1 to 100 {
    VM.run(vm, Add.make("x", "y"))
  }

  benchmark("VM undo", 50000, () => {
    VM.run(vm, Add.make("x", "y"))
    VM.undo(vm)->ignore
  })
}

// Run all benchmarks
let runAll = (): unit => {
  Console.log("")
  Console.log("  Idaptik VM Benchmarks")
  Console.log("")
  Console.log("")

  benchmarkAdd()
  benchmarkSwap()
  benchmarkVM()
  benchmarkStateClone()
  benchmarkUndo()

  Console.log("")
  Console.log("  Benchmarks Complete")
  Console.log("")
}

// Run benchmarks
runAll()
