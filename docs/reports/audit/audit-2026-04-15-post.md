# POST-audit status report
Repo: idaptik-rescript13-staging
Actions taken:
- Added TS blocker workflow
- Added NPM/Bun blocker workflow
- Managed lockfiles
- Synced repo (Dependabot, .scm, Justfile)
Remaining findings: {
  "program_path": ".",
  "language": "rescript",
  "frameworks": [
    "WebServer",
    "Phoenix",
    "OTP"
  ],
  "weak_points": [
    {
      "category": "HardcodedSecret",
      "location": "lib/bs/src/app/devices/GlobalNetworkData.res",
      "file": "lib/bs/src/app/devices/GlobalNetworkData.res",
      "severity": "Critical",
      "description": "Possible hardcoded secret in lib/bs/src/app/devices/GlobalNetworkData.res",
      "recommended_attack": [
        "network"
      ]
    },
    {
      "category": "PanicPath",
      "location": "lib/bs/src/app/devices/VMBridge.res",
      "file": "lib/bs/src/app/devices/VMBridge.res",
      "severity": "Medium",
      "description": "2 unsafe get calls in lib/bs/src/app/devices/VMBridge.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "PanicPath",
      "location": "lib/bs/src/app/devices/LaptopGUI.res",
      "file": "lib/bs/src/app/devices/LaptopGUI.res",
      "severity": "Medium",
      "description": "1 unsafe get calls in lib/bs/src/app/devices/LaptopGUI.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "UncheckedError",
      "location": "lib/bs/src/app/multiplayer/VMNetwork.res",
      "file": "lib/bs/src/app/multiplayer/VMNetwork.res",
      "severity": "Medium",
      "description": "12 ignore() calls in lib/bs/src/app/multiplayer/VMNetwork.res (may discard important results)",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "PanicPath",
      "location": "lib/bs/src/app/multiplayer/VMNetwork.res",
      "file": "lib/bs/src/app/multiplayer/VMNetwork.res",
      "severity": "Medium",
      "description": "1 unsafe get calls in lib/bs/src/app/multiplayer/VMNetwork.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "UncheckedError",
      "location": "lib/bs/src/app/ui/HardwareWiring.res",
      "file": "lib/bs/src/app/ui/HardwareWiring.res",
      "severity": "Medium",
      "description": "5 ignore() calls in lib/bs/src/app/ui/HardwareWiring.res (may discard important results)",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "HardcodedSecret",
      "location": "lib/bs/src/app/tools/PasswordCracker.res",
      "file": "lib/bs/src/app/tools/PasswordCracker.res",
      "severity": "Critical",
      "description": "Possible hardcoded secret in lib/bs/src/app/tools/PasswordCracker.res",
      "recommended_attack": [
        "network"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "lib/bs/src/app/proven/SafeJson.res",
      "file": "lib/bs/src/app/proven/SafeJson.res",
      "severity": "High",
      "description": "2 JSON.parseExn calls in lib/bs/src/app/proven/SafeJson.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "lib/bs/src/shared/DLCLoader.res",
      "file": "lib/bs/src/shared/DLCLoader.res",
      "severity": "High",
      "description": "1 JSON.parseExn calls in lib/bs/src/shared/DLCLoader.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "lib/bs/src/engine/utils/Storage.res",
      "file": "lib/bs/src/engine/utils/Storage.res",
      "severity": "High",
      "description": "1 JSON.parseExn calls in lib/bs/src/engine/utils/Storage.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "HardcodedSecret",
      "location": "lib/ocaml/GlobalNetworkData.res",
      "file": "lib/ocaml/GlobalNetworkData.res",
      "severity": "Critical",
      "description": "Possible hardcoded secret in lib/ocaml/GlobalNetworkData.res",
      "recommended_attack": [
        "network"
      ]
    },
    {
      "category": "PanicPath",
      "location": "lib/ocaml/VMBridge.res",
      "file": "lib/ocaml/VMBridge.res",
      "severity": "Medium",
      "description": "2 unsafe get calls in lib/ocaml/VMBridge.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "lib/ocaml/SafeJson.res",
      "file": "lib/ocaml/SafeJson.res",
      "severity": "High",
      "description": "2 JSON.parseExn calls in lib/ocaml/SafeJson.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "lib/ocaml/DLCLoader.res",
      "file": "lib/ocaml/DLCLoader.res",
      "severity": "High",
      "description": "1 JSON.parseExn calls in lib/ocaml/DLCLoader.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "HardcodedSecret",
      "location": "lib/ocaml/PasswordCracker.res",
      "file": "lib/ocaml/PasswordCracker.res",
      "severity": "Critical",
      "description": "Possible hardcoded secret in lib/ocaml/PasswordCracker.res",
      "recommended_attack": [
        "network"
      ]
    },
    {
      "category": "UncheckedError",
      "location": "lib/ocaml/HardwareWiring.res",
      "file": "lib/ocaml/HardwareWiring.res",
      "severity": "Medium",
      "description": "5 ignore() calls in lib/ocaml/HardwareWiring.res (may discard important results)",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "UncheckedError",
      "location": "lib/ocaml/VMNetwork.res",
      "file": "lib/ocaml/VMNetwork.res",
      "severity": "Medium",
      "description": "12 ignore() calls in lib/ocaml/VMNetwork.res (may discard important results)",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "PanicPath",
      "location": "lib/ocaml/VMNetwork.res",
      "file": "lib/ocaml/VMNetwork.res",
      "severity": "Medium",
      "description": "1 unsafe get calls in lib/ocaml/VMNetwork.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "lib/ocaml/Storage.res",
      "file": "lib/ocaml/Storage.res",
      "severity": "High",
      "description": "1 JSON.parseExn calls in lib/ocaml/Storage.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "PanicPath",
      "location": "lib/ocaml/LaptopGUI.res",
      "file": "lib/ocaml/LaptopGUI.res",
      "severity": "Medium",
      "description": "1 unsafe get calls in lib/ocaml/LaptopGUI.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "InsecureProtocol",
      "location": "main-game/dist/assets/SharedSystems-D0x1ThPY.js",
      "file": "main-game/dist/assets/SharedSystems-D0x1ThPY.js",
      "severity": "Medium",
      "description": "2 HTTP (non-HTTPS) URLs in main-game/dist/assets/SharedSystems-D0x1ThPY.js",
      "recommended_attack": [
        "network"
      ]
    },
    {
      "category": "DynamicCodeExecution",
      "location": "main-game/dist/assets/index-Cdt-JTFK.js",
      "file": "main-game/dist/assets/index-Cdt-JTFK.js",
      "severity": "High",
      "description": "DOM manipulation (innerHTML/document.write) in main-game/dist/assets/index-Cdt-JTFK.js",
      "recommended_attack": [
        "memory",
        "network"
      ]
    },
    {
      "category": "HardcodedSecret",
      "location": "main-game/dist/assets/index-Cdt-JTFK.js",
      "file": "main-game/dist/assets/index-Cdt-JTFK.js",
      "severity": "Critical",
      "description": "Possible hardcoded secret in main-game/dist/assets/index-Cdt-JTFK.js",
      "recommended_attack": [
        "network"
      ]
    },
    {
      "category": "DynamicCodeExecution",
      "location": "main-game/dist/assets/webworkerAll-DNs-UuZS.js",
      "file": "main-game/dist/assets/webworkerAll-DNs-UuZS.js",
      "severity": "High",
      "description": "DOM manipulation (innerHTML/document.write) in main-game/dist/assets/webworkerAll-DNs-UuZS.js",
      "recommended_attack": [
        "memory",
        "network"
      ]
    },
    {
      "category": "InsecureProtocol",
      "location": "main-game/dist/assets/webworkerAll-DNs-UuZS.js",
      "file": "main-game/dist/assets/webworkerAll-DNs-UuZS.js",
      "severity": "Medium",
      "description": "2 HTTP (non-HTTPS) URLs in main-game/dist/assets/webworkerAll-DNs-UuZS.js",
      "recommended_attack": [
        "network"
      ]
    },
    {
      "category": "HardcodedSecret",
      "location": "src/app/devices/GlobalNetworkData.res",
      "file": "src/app/devices/GlobalNetworkData.res",
      "severity": "Critical",
      "description": "Possible hardcoded secret in src/app/devices/GlobalNetworkData.res",
      "recommended_attack": [
        "network"
      ]
    },
    {
      "category": "PanicPath",
      "location": "src/app/devices/VMBridge.res",
      "file": "src/app/devices/VMBridge.res",
      "severity": "Medium",
      "description": "2 unsafe get calls in src/app/devices/VMBridge.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "PanicPath",
      "location": "src/app/devices/LaptopGUI.res",
      "file": "src/app/devices/LaptopGUI.res",
      "severity": "Medium",
      "description": "1 unsafe get calls in src/app/devices/LaptopGUI.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "UncheckedError",
      "location": "src/app/multiplayer/VMNetwork.res",
      "file": "src/app/multiplayer/VMNetwork.res",
      "severity": "Medium",
      "description": "12 ignore() calls in src/app/multiplayer/VMNetwork.res (may discard important results)",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "PanicPath",
      "location": "src/app/multiplayer/VMNetwork.res",
      "file": "src/app/multiplayer/VMNetwork.res",
      "severity": "Medium",
      "description": "1 unsafe get calls in src/app/multiplayer/VMNetwork.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "src/app/proven/SafeJson.res",
      "file": "src/app/proven/SafeJson.res",
      "severity": "High",
      "description": "2 JSON.parseExn calls in src/app/proven/SafeJson.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "HardcodedSecret",
      "location": "src/app/tools/PasswordCracker.res",
      "file": "src/app/tools/PasswordCracker.res",
      "severity": "Critical",
      "description": "Possible hardcoded secret in src/app/tools/PasswordCracker.res",
      "recommended_attack": [
        "network"
      ]
    },
    {
      "category": "UncheckedError",
      "location": "src/app/ui/HardwareWiring.res",
      "file": "src/app/ui/HardwareWiring.res",
      "severity": "Medium",
      "description": "5 ignore() calls in src/app/ui/HardwareWiring.res (may discard important results)",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "src/engine/utils/Storage.res",
      "file": "src/engine/utils/Storage.res",
      "severity": "High",
      "description": "1 JSON.parseExn calls in src/engine/utils/Storage.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "src/shared/DLCLoader.res",
      "file": "src/shared/DLCLoader.res",
      "severity": "High",
      "description": "1 JSON.parseExn calls in src/shared/DLCLoader.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "src/shared/UmsLevelLoader.res",
      "file": "src/shared/UmsLevelLoader.res",
      "severity": "High",
      "description": "1 JSON.parseExn calls in src/shared/UmsLevelLoader.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "PanicPath",
      "location": "src/shared/UmsLevelLoader.res",
      "file": "src/shared/UmsLevelLoader.res",
      "severity": "Medium",
      "description": "1 unsafe get calls in src/shared/UmsLevelLoader.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "MutationGap",
      "location": "sync-server/test/application_test.exs",
      "file": "sync-server/test/application_test.exs",
      "severity": "Low",
      "description": "Elixir test file sync-server/test/application_test.exs uses ExUnit.Case but has no ExUnitProperties/StreamData — add property-based tests to improve mutation coverage",
      "recommended_attack": [
        "cpu"
      ]
    },
    {
      "category": "MutationGap",
      "location": "sync-server/test/router_test.exs",
      "file": "sync-server/test/router_test.exs",
      "severity": "Low",
      "description": "Elixir test file sync-server/test/router_test.exs uses ExUnit.Case but has no ExUnitProperties/StreamData — add property-based tests to improve mutation coverage",
      "recommended_attack": [
        "cpu"
      ]
    },
    {
      "category": "PanicPath",
      "location": "vm/lib/ocaml/InstructionParser.res",
      "file": "vm/lib/ocaml/InstructionParser.res",
      "severity": "Medium",
      "description": "2 unsafe get calls in vm/lib/ocaml/InstructionParser.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "UnsafeDeserialization",
      "location": "vm/lib/ocaml/State.res",
      "file": "vm/lib/ocaml/State.res",
      "severity": "High",
      "description": "1 JSON.parseExn calls in vm/lib/ocaml/State.res (use JSON.parse for safe Result)",
      "recommended_attack": [
        "memory",
        "cpu"
      ]
    },
    {
      "category": "PanicPath",
      "location": "vm/lib/ocaml/VM.res",
      "file": "vm/lib/ocaml/VM.res",
      "severity": "Medium",
      "description": "1 unsafe get calls in vm/lib/ocaml/VM.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "PanicPath",
      "location": "vm/lib/ocaml/benchmark.res",
      "file": "vm/lib/ocaml/benchmark.res",
      "severity": "Medium",
      "description": "1 unsafe get calls in vm/lib/ocaml/benchmark.res",
      "recommended_attack": [
        "memory"
      ]
    },
    {
      "category": "PanicPath",
      "location": "vm/lib/ocaml/test_all.res",
      "file": "vm/lib/ocaml/test_all.res",
      "severity": "Medium",
      "description": "2 unsafe get calls in vm/lib/ocaml/test_all.res",
      "recommended_attack": [
        "memory"
      ],
      "suppressed": true
    },
    {
      "category": "UncheckedError",
      "location": "idaptik-ums/src/abi/ProvenBridge.idr",
      "file": "idaptik-ums/src/abi/ProvenBridge.idr",
      "severity": "Low",
      "description": "13 TODO/FIXME/HACK markers in idaptik-ums/src/abi/ProvenBridge.idr",
      "recommended_attack": [
        "cpu"
      ]
    },
    {
      "category": "PanicPath",
      "location": "idaptik-ums/src-gossamer/main.rs",
      "file": "idaptik-ums/src-gossamer/main.rs",
      "severity": "Medium",
      "description": "11 unwrap/expect calls in idaptik-ums/src-gossamer/main.rs",
      "recommended_attack": [
        "memory",
        "disk"
      ],
      "suppressed": true
    },
    {
      "category": "SupplyChain",
      "location": "flake.nix",
      "file": "flake.nix",
      "severity": "High",
      "description": "flake.nix declares inputs without narHash, rev pinning, or sibling flake.lock — dependency revision is unpinned in flake.nix",
      "recommended_attack": []
    }
  ],
  "statistics": {
    "total_lines": 167010,
    "unsafe_blocks": 728,
    "panic_sites": 14,
    "unwrap_calls": 30,
    "allocation_sites": 821,
    "io_operations": 39,
    "threading_constructs": 11
  },
  "file_statistics": [
    {
      "file_path": "lib/bs/src/app/enemies/Distraction.res",
      "lines": 457,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 6,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/enemies/GuardNPC.res",
      "lines": 1820,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/enemies/SecurityAI.res",
      "lines": 318,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/player/KeyboardAiming.res",
      "lines": 62,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/player/PlayerState.res",
      "lines": 358,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/player/TrajectoryPreview.res",
      "lines": 131,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/TrainingRegistry.res",
      "lines": 16,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/TrainingBase.res",
      "lines": 790,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 6,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/DogTraining.res",
      "lines": 71,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/HighwayCrossingTraining.res",
      "lines": 861,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/AssassinTraining.res",
      "lines": 199,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 5,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/DroneTraining.res",
      "lines": 742,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/GuardTraining.res",
      "lines": 72,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/CombatTraining.res",
      "lines": 293,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 8,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/ScavengerTraining.res",
      "lines": 424,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 9,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/MoletaireTraining.res",
      "lines": 1224,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 7,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/training/TrainingMenuScreen.res",
      "lines": 479,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/main/Bouncer.res",
      "lines": 159,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/CreditsScreen.res",
      "lines": 198,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/GameOverScreen.res",
      "lines": 294,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 7,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/VictoryScreen.res",
      "lines": 309,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 5,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/IntroScreen.res",
      "lines": 315,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/WorldBuilder.res",
      "lines": 1569,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 11,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/screens/WorldScreen.res",
      "lines": 931,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/PowerManager.res",
      "lines": 279,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/VMBridge.res",
      "lines": 720,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 2,
      "allocation_sites": 4,
      "io_operations": 1,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/CameraFeed.res",
      "lines": 150,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/DeviceView.res",
      "lines": 564,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/NetworkTransfer.res",
      "lines": 144,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/RouterDevice.res",
      "lines": 567,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/CameraDevice.res",
      "lines": 587,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/CoprocessorBridge.res",
      "lines": 243,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/Terminal.res",
      "lines": 1091,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/DesktopDevice.res",
      "lines": 86,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/GlobalNetworkManager.res",
      "lines": 20,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/LaptopGUI.res",
      "lines": 2081,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 1,
      "allocation_sites": 24,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/devices/NetworkManager.res",
      "lines": 834,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/multiplayer/PhoenixSocket.res",
      "lines": 375,
      "unsafe_blocks": 6,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/multiplayer/MultiplayerGlobal.res",
      "lines": 66,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/multiplayer/VMMessageBus.res",
      "lines": 323,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/multiplayer/VMNetwork.res",
      "lines": 422,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 1,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/utils/PeerDetection.res",
      "lines": 211,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 1,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/utils/LanguageSettings.res",
      "lines": 126,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/utils/AccessibilitySettings.res",
      "lines": 174,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 9,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/utils/FeaturePacks.res",
      "lines": 40,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/utils/GameI18n.res",
      "lines": 67,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/tools/PasswordCracker.res",
      "lines": 136,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/companions/MoletaireMusic.res",
      "lines": 226,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 5,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/proven/SafeJson.res",
      "lines": 202,
      "unsafe_blocks": 0,
      "panic_sites": 2,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/proven/SafeFloat.res",
      "lines": 254,
      "unsafe_blocks": 2,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/popups/ForceLayout.res",
      "lines": 240,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/popups/IntegrationsPopup.res",
      "lines": 243,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/popups/AccessibilityPopup.res",
      "lines": 313,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/popups/SettingsPopup.res",
      "lines": 232,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/popups/NetworkDesktop.res",
      "lines": 1767,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 44,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/popups/PowerView.res",
      "lines": 463,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/GameLoop.res",
      "lines": 1117,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/app/GetEngine.res",
      "lines": 12,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/Coprocessor.res",
      "lines": 149,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/Inventory.res",
      "lines": 453,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/Kernel_Crypto.res",
      "lines": 126,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/Coprocessor_Security.res",
      "lines": 1052,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 17,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/RetryPolicy.res",
      "lines": 150,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/DLCLoader.res",
      "lines": 403,
      "unsafe_blocks": 0,
      "panic_sites": 1,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/Coprocessor_IO.res",
      "lines": 363,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/Coprocessor_Compute.res",
      "lines": 767,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 10,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/Kernel_Quantum.res",
      "lines": 125,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/Kernel_IO.res",
      "lines": 101,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/shared/CoprocessorManager.res",
      "lines": 178,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/engine/resize/Resize.res",
      "lines": 57,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/engine/utils/Random.res",
      "lines": 123,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/engine/utils/Storage.res",
      "lines": 73,
      "unsafe_blocks": 0,
      "panic_sites": 1,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/engine/utils/WaitFor.res",
      "lines": 12,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/bindings/Motion.res",
      "lines": 28,
      "unsafe_blocks": 2,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/bindings/PixiSound.res",
      "lines": 30,
      "unsafe_blocks": 3,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/bindings/Pixi.res",
      "lines": 463,
      "unsafe_blocks": 188,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/bs/src/bindings/PixiUI.res",
      "lines": 101,
      "unsafe_blocks": 34,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Coprocessor.res",
      "lines": 149,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/PowerManager.res",
      "lines": 279,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/PeerDetection.res",
      "lines": 211,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 1,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Inventory.res",
      "lines": 453,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/ForceLayout.res",
      "lines": 240,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/VMBridge.res",
      "lines": 720,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 2,
      "allocation_sites": 4,
      "io_operations": 1,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Distraction.res",
      "lines": 457,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 6,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/LanguageSettings.res",
      "lines": 126,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/AccessibilitySettings.res",
      "lines": 174,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 9,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/SafeJson.res",
      "lines": 202,
      "unsafe_blocks": 0,
      "panic_sites": 2,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Kernel_Crypto.res",
      "lines": 126,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/CameraFeed.res",
      "lines": 150,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Coprocessor_Security.res",
      "lines": 1052,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 17,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/RetryPolicy.res",
      "lines": 150,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/DLCLoader.res",
      "lines": 403,
      "unsafe_blocks": 0,
      "panic_sites": 1,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/GuardNPC.res",
      "lines": 1820,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/FeaturePacks.res",
      "lines": 40,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/SafeFloat.res",
      "lines": 254,
      "unsafe_blocks": 2,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/PasswordCracker.res",
      "lines": 136,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Coprocessor_IO.res",
      "lines": 363,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/DeviceView.res",
      "lines": 564,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Coprocessor_Compute.res",
      "lines": 767,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 10,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/NetworkTransfer.res",
      "lines": 144,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Kernel_Quantum.res",
      "lines": 125,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/MoletaireMusic.res",
      "lines": 226,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 5,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Kernel_IO.res",
      "lines": 101,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/GameI18n.res",
      "lines": 67,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/PhoenixSocket.res",
      "lines": 375,
      "unsafe_blocks": 6,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/KeyboardAiming.res",
      "lines": 62,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/CreditsScreen.res",
      "lines": 198,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/PlayerState.res",
      "lines": 358,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/RouterDevice.res",
      "lines": 567,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/TrajectoryPreview.res",
      "lines": 131,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/CameraDevice.res",
      "lines": 587,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/TrainingRegistry.res",
      "lines": 16,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/MultiplayerGlobal.res",
      "lines": 66,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/CoprocessorManager.res",
      "lines": 178,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/VMMessageBus.res",
      "lines": 323,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/IntegrationsPopup.res",
      "lines": 243,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/CoprocessorBridge.res",
      "lines": 243,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/AccessibilityPopup.res",
      "lines": 313,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/VMNetwork.res",
      "lines": 422,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 1,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/SecurityAI.res",
      "lines": 318,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/SettingsPopup.res",
      "lines": 232,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Terminal.res",
      "lines": 1091,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/DesktopDevice.res",
      "lines": 86,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/GameOverScreen.res",
      "lines": 294,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 7,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/VictoryScreen.res",
      "lines": 309,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 5,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/IntroScreen.res",
      "lines": 315,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/GameLoop.res",
      "lines": 1117,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/GlobalNetworkManager.res",
      "lines": 20,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/NetworkDesktop.res",
      "lines": 1767,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 44,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/WorldBuilder.res",
      "lines": 1569,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 11,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/TrainingBase.res",
      "lines": 790,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 6,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/DogTraining.res",
      "lines": 71,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/HighwayCrossingTraining.res",
      "lines": 861,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/AssassinTraining.res",
      "lines": 199,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 5,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/DroneTraining.res",
      "lines": 742,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/GuardTraining.res",
      "lines": 72,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/CombatTraining.res",
      "lines": 293,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 8,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/ScavengerTraining.res",
      "lines": 424,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 9,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/MoletaireTraining.res",
      "lines": 1224,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 7,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/TrainingMenuScreen.res",
      "lines": 479,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Resize.res",
      "lines": 57,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Random.res",
      "lines": 123,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Storage.res",
      "lines": 73,
      "unsafe_blocks": 0,
      "panic_sites": 1,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Motion.res",
      "lines": 28,
      "unsafe_blocks": 2,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/PixiSound.res",
      "lines": 30,
      "unsafe_blocks": 3,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Pixi.res",
      "lines": 463,
      "unsafe_blocks": 188,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/WaitFor.res",
      "lines": 12,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/PixiUI.res",
      "lines": 101,
      "unsafe_blocks": 34,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/Bouncer.res",
      "lines": 160,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/GetEngine.res",
      "lines": 12,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/LaptopGUI.res",
      "lines": 2081,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 1,
      "allocation_sites": 24,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/NetworkManager.res",
      "lines": 834,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/PowerView.res",
      "lines": 463,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "lib/ocaml/WorldScreen.res",
      "lines": 931,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "main-game/dist/assets/index-Cdt-JTFK.js",
      "lines": 816,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 12,
      "threading_constructs": 8
    },
    {
      "file_path": "main-game/dist/assets/webworkerAll-DNs-UuZS.js",
      "lines": 283,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 1,
      "threading_constructs": 0
    },
    {
      "file_path": "main-game/dist/workbox-8953ae05.js",
      "lines": 1,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 6,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/companions/MoletaireMusic.res",
      "lines": 226,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 5,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/DesktopDevice.res",
      "lines": 86,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/GlobalNetworkManager.res",
      "lines": 20,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/CameraDevice.res",
      "lines": 587,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/CameraFeed.res",
      "lines": 150,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/CoprocessorBridge.res",
      "lines": 243,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/DeviceView.res",
      "lines": 564,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/NetworkTransfer.res",
      "lines": 144,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/PowerManager.res",
      "lines": 279,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/RouterDevice.res",
      "lines": 567,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/Terminal.res",
      "lines": 1091,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/VMBridge.res",
      "lines": 720,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 2,
      "allocation_sites": 4,
      "io_operations": 1,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/LaptopGUI.res",
      "lines": 2081,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 1,
      "allocation_sites": 24,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/devices/NetworkManager.res",
      "lines": 834,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/enemies/Distraction.res",
      "lines": 457,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 6,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/enemies/GuardNPC.res",
      "lines": 1820,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/enemies/SecurityAI.res",
      "lines": 318,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/multiplayer/MultiplayerGlobal.res",
      "lines": 66,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/multiplayer/PhoenixSocket.res",
      "lines": 375,
      "unsafe_blocks": 6,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/multiplayer/VMMessageBus.res",
      "lines": 323,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/multiplayer/VMNetwork.res",
      "lines": 422,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 1,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/player/KeyboardAiming.res",
      "lines": 62,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/player/PlayerState.res",
      "lines": 358,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/player/TrajectoryPreview.res",
      "lines": 131,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/popups/AccessibilityPopup.res",
      "lines": 313,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/popups/ForceLayout.res",
      "lines": 240,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/popups/IntegrationsPopup.res",
      "lines": 243,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/popups/NetworkDesktop.res",
      "lines": 1767,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 44,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/popups/SettingsPopup.res",
      "lines": 232,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/popups/PowerView.res",
      "lines": 463,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/proven/SafeFloat.res",
      "lines": 254,
      "unsafe_blocks": 2,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/proven/SafeJson.res",
      "lines": 202,
      "unsafe_blocks": 0,
      "panic_sites": 2,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/main/Bouncer.res",
      "lines": 160,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/CombatTraining.res",
      "lines": 293,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 8,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/DogTraining.res",
      "lines": 71,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/GuardTraining.res",
      "lines": 72,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/TrainingRegistry.res",
      "lines": 16,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/AssassinTraining.res",
      "lines": 199,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 5,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/DroneTraining.res",
      "lines": 742,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/DroneTrainingGround.res",
      "lines": 1087,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/HighwayCrossingTraining.res",
      "lines": 861,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/MoletaireTraining.res",
      "lines": 1224,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 7,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/ScavengerTraining.res",
      "lines": 424,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 9,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/TrainingBase.res",
      "lines": 790,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 6,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/training/TrainingMenuScreen.res",
      "lines": 479,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/CreditsScreen.res",
      "lines": 198,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/GameOverScreen.res",
      "lines": 294,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 7,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/IntroScreen.res",
      "lines": 315,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/VictoryScreen.res",
      "lines": 309,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 5,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/WorldBuilder.res",
      "lines": 1569,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 11,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/screens/WorldScreen.res",
      "lines": 931,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/tools/PasswordCracker.res",
      "lines": 136,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/utils/GameI18n.res",
      "lines": 67,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/utils/AccessibilitySettings.res",
      "lines": 174,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 9,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/utils/FeaturePacks.res",
      "lines": 40,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/utils/LanguageSettings.res",
      "lines": 126,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/utils/PeerDetection.res",
      "lines": 211,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 1,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/GameLoop.res",
      "lines": 1117,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/app/GetEngine.res",
      "lines": 12,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/bindings/Motion.res",
      "lines": 28,
      "unsafe_blocks": 2,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/bindings/PixiSound.res",
      "lines": 30,
      "unsafe_blocks": 3,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/bindings/PixiUI.res",
      "lines": 101,
      "unsafe_blocks": 34,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/bindings/Pixi.res",
      "lines": 463,
      "unsafe_blocks": 188,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/engine/resize/Resize.res",
      "lines": 57,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/engine/utils/Random.res",
      "lines": 123,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/engine/utils/Storage.res",
      "lines": 73,
      "unsafe_blocks": 0,
      "panic_sites": 1,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/engine/utils/WaitFor.res",
      "lines": 12,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/RetryPolicy.res",
      "lines": 150,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/Coprocessor.res",
      "lines": 149,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/CoprocessorManager.res",
      "lines": 178,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/Coprocessor_Compute.res",
      "lines": 767,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 10,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/Coprocessor_IO.res",
      "lines": 363,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 3,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/Coprocessor_Security.res",
      "lines": 1052,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 17,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/DLCLoader.res",
      "lines": 403,
      "unsafe_blocks": 0,
      "panic_sites": 1,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/Inventory.res",
      "lines": 453,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/Kernel_Crypto.res",
      "lines": 126,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/Kernel_IO.res",
      "lines": 101,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/Kernel_Quantum.res",
      "lines": 125,
      "unsafe_blocks": 1,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "src/shared/UmsLevelLoader.res",
      "lines": 520,
      "unsafe_blocks": 0,
      "panic_sites": 1,
      "unwrap_calls": 1,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "sync-server/lib/idaptik_sync_server/arango_client.ex",
      "lines": 504,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 4,
      "threading_constructs": 0
    },
    {
      "file_path": "sync-server/lib/idaptik_sync_server/cache.ex",
      "lines": 67,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 1
    },
    {
      "file_path": "sync-server/lib/idaptik_sync_server/database_bridge.ex",
      "lines": 628,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 1
    },
    {
      "file_path": "sync-server/lib/idaptik_sync_server/game_session_registry.ex",
      "lines": 244,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 1
    },
    {
      "file_path": "sync-server/lib/idaptik_sync_server/game_store.ex",
      "lines": 50,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "sync-server/lib/idaptik_sync_server/verisim_client.ex",
      "lines": 385,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 4,
      "threading_constructs": 0
    },
    {
      "file_path": "sync-server/test/connectivity_test.mjs",
      "lines": 145,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 1,
      "threading_constructs": 0
    },
    {
      "file_path": "vm/lib/ocaml/InstructionParser.res",
      "lines": 275,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 2,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "vm/lib/ocaml/Loop.res",
      "lines": 76,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 4,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "vm/lib/ocaml/State.res",
      "lines": 64,
      "unsafe_blocks": 0,
      "panic_sites": 1,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "vm/lib/ocaml/VM.res",
      "lines": 152,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 1,
      "allocation_sites": 2,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "vm/lib/ocaml/benchmark.res",
      "lines": 119,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 1,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "vm/lib/ocaml/test_all.res",
      "lines": 899,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 2,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "idaptik-ums/generated/abi/idaptik_ums.h",
      "lines": 211,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 1,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "idaptik-ums/src/App.res",
      "lines": 856,
      "unsafe_blocks": 5,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "idaptik-ums/src-gossamer/main.rs",
      "lines": 928,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 11,
      "allocation_sites": 7,
      "io_operations": 0,
      "threading_constructs": 0
    },
    {
      "file_path": "setup.sh",
      "lines": 278,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 3,
      "threading_constructs": 0
    },
    {
      "file_path": "flake.nix",
      "lines": 116,
      "unsafe_blocks": 0,
      "panic_sites": 0,
      "unwrap_calls": 0,
      "allocation_sites": 0,
      "io_operations": 2,
      "threading_constructs": 0
    }
  ],
  "recommended_attacks": [
    "cpu",
    "memory",
    "concurrency",
    "disk",
    "network"
  ],
  "dependency_graph": {
    "edges": [
      {
        "from": "src/app/screens/CreditsScreen.res",
        "to": "src/app/screens/GameOverScreen.res",
        "relation": "shared_dir:src/app/screens",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/GameOverScreen.res",
        "to": "src/app/screens/IntroScreen.res",
        "relation": "shared_dir:src/app/screens",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/IntroScreen.res",
        "to": "src/app/screens/VictoryScreen.res",
        "relation": "shared_dir:src/app/screens",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/VictoryScreen.res",
        "to": "src/app/screens/WorldBuilder.res",
        "relation": "shared_dir:src/app/screens",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/WorldBuilder.res",
        "to": "src/app/screens/WorldScreen.res",
        "relation": "shared_dir:src/app/screens",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/engine/utils/Random.res",
        "to": "lib/bs/src/engine/utils/Storage.res",
        "relation": "shared_dir:lib/bs/src/engine/utils",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/engine/utils/Storage.res",
        "to": "lib/bs/src/engine/utils/WaitFor.res",
        "relation": "shared_dir:lib/bs/src/engine/utils",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/GameI18n.res",
        "to": "src/app/utils/AccessibilitySettings.res",
        "relation": "shared_dir:src/app/utils",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/AccessibilitySettings.res",
        "to": "src/app/utils/FeaturePacks.res",
        "relation": "shared_dir:src/app/utils",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/FeaturePacks.res",
        "to": "src/app/utils/LanguageSettings.res",
        "relation": "shared_dir:src/app/utils",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/LanguageSettings.res",
        "to": "src/app/utils/PeerDetection.res",
        "relation": "shared_dir:src/app/utils",
        "weight": 1.0
      },
      {
        "from": "setup.sh",
        "to": "flake.nix",
        "relation": "shared_dir:",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/PowerManager.res",
        "to": "lib/bs/src/app/devices/VMBridge.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/VMBridge.res",
        "to": "lib/bs/src/app/devices/CameraFeed.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CameraFeed.res",
        "to": "lib/bs/src/app/devices/DeviceView.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/DeviceView.res",
        "to": "lib/bs/src/app/devices/NetworkTransfer.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/NetworkTransfer.res",
        "to": "lib/bs/src/app/devices/RouterDevice.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/RouterDevice.res",
        "to": "lib/bs/src/app/devices/CameraDevice.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CameraDevice.res",
        "to": "lib/bs/src/app/devices/CoprocessorBridge.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CoprocessorBridge.res",
        "to": "lib/bs/src/app/devices/Terminal.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/Terminal.res",
        "to": "lib/bs/src/app/devices/DesktopDevice.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/DesktopDevice.res",
        "to": "lib/bs/src/app/devices/GlobalNetworkManager.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/GlobalNetworkManager.res",
        "to": "lib/bs/src/app/devices/LaptopGUI.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/LaptopGUI.res",
        "to": "lib/bs/src/app/devices/NetworkManager.res",
        "relation": "shared_dir:lib/bs/src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/CombatTraining.res",
        "to": "src/app/screens/training/DogTraining.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DogTraining.res",
        "to": "src/app/screens/training/GuardTraining.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/GuardTraining.res",
        "to": "src/app/screens/training/TrainingRegistry.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingRegistry.res",
        "to": "src/app/screens/training/AssassinTraining.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/AssassinTraining.res",
        "to": "src/app/screens/training/DroneTraining.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DroneTraining.res",
        "to": "src/app/screens/training/DroneTrainingGround.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DroneTrainingGround.res",
        "to": "src/app/screens/training/HighwayCrossingTraining.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/HighwayCrossingTraining.res",
        "to": "src/app/screens/training/MoletaireTraining.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/MoletaireTraining.res",
        "to": "src/app/screens/training/ScavengerTraining.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/ScavengerTraining.res",
        "to": "src/app/screens/training/TrainingBase.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingBase.res",
        "to": "src/app/screens/training/TrainingMenuScreen.res",
        "relation": "shared_dir:src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/DesktopDevice.res",
        "to": "src/app/devices/GlobalNetworkManager.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/GlobalNetworkManager.res",
        "to": "src/app/devices/CameraDevice.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CameraDevice.res",
        "to": "src/app/devices/CameraFeed.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CameraFeed.res",
        "to": "src/app/devices/CoprocessorBridge.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CoprocessorBridge.res",
        "to": "src/app/devices/DeviceView.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/DeviceView.res",
        "to": "src/app/devices/NetworkTransfer.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/NetworkTransfer.res",
        "to": "src/app/devices/PowerManager.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/PowerManager.res",
        "to": "src/app/devices/RouterDevice.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/RouterDevice.res",
        "to": "src/app/devices/Terminal.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/Terminal.res",
        "to": "src/app/devices/VMBridge.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/VMBridge.res",
        "to": "src/app/devices/LaptopGUI.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/LaptopGUI.res",
        "to": "src/app/devices/NetworkManager.res",
        "relation": "shared_dir:src/app/devices",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/GameLoop.res",
        "to": "lib/bs/src/app/GetEngine.res",
        "relation": "shared_dir:lib/bs/src/app",
        "weight": 1.0
      },
      {
        "from": "src/bindings/Motion.res",
        "to": "src/bindings/PixiSound.res",
        "relation": "shared_dir:src/bindings",
        "weight": 1.0
      },
      {
        "from": "src/bindings/PixiSound.res",
        "to": "src/bindings/PixiUI.res",
        "relation": "shared_dir:src/bindings",
        "weight": 1.0
      },
      {
        "from": "src/bindings/PixiUI.res",
        "to": "src/bindings/Pixi.res",
        "relation": "shared_dir:src/bindings",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/arango_client.ex",
        "to": "sync-server/lib/idaptik_sync_server/cache.ex",
        "relation": "shared_dir:sync-server/lib/idaptik_sync_server",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/cache.ex",
        "to": "sync-server/lib/idaptik_sync_server/database_bridge.ex",
        "relation": "shared_dir:sync-server/lib/idaptik_sync_server",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/database_bridge.ex",
        "to": "sync-server/lib/idaptik_sync_server/game_session_registry.ex",
        "relation": "shared_dir:sync-server/lib/idaptik_sync_server",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/game_session_registry.ex",
        "to": "sync-server/lib/idaptik_sync_server/game_store.ex",
        "relation": "shared_dir:sync-server/lib/idaptik_sync_server",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/game_store.ex",
        "to": "sync-server/lib/idaptik_sync_server/verisim_client.ex",
        "relation": "shared_dir:sync-server/lib/idaptik_sync_server",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/InstructionParser.res",
        "to": "vm/lib/ocaml/Loop.res",
        "relation": "shared_dir:vm/lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/Loop.res",
        "to": "vm/lib/ocaml/State.res",
        "relation": "shared_dir:vm/lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/State.res",
        "to": "vm/lib/ocaml/VM.res",
        "relation": "shared_dir:vm/lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/VM.res",
        "to": "vm/lib/ocaml/benchmark.res",
        "relation": "shared_dir:vm/lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/benchmark.res",
        "to": "vm/lib/ocaml/test_all.res",
        "relation": "shared_dir:vm/lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/CreditsScreen.res",
        "to": "lib/bs/src/app/screens/GameOverScreen.res",
        "relation": "shared_dir:lib/bs/src/app/screens",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/GameOverScreen.res",
        "to": "lib/bs/src/app/screens/VictoryScreen.res",
        "relation": "shared_dir:lib/bs/src/app/screens",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/VictoryScreen.res",
        "to": "lib/bs/src/app/screens/IntroScreen.res",
        "relation": "shared_dir:lib/bs/src/app/screens",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/IntroScreen.res",
        "to": "lib/bs/src/app/screens/WorldBuilder.res",
        "relation": "shared_dir:lib/bs/src/app/screens",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/WorldBuilder.res",
        "to": "lib/bs/src/app/screens/WorldScreen.res",
        "relation": "shared_dir:lib/bs/src/app/screens",
        "weight": 1.0
      },
      {
        "from": "src/engine/utils/Random.res",
        "to": "src/engine/utils/Storage.res",
        "relation": "shared_dir:src/engine/utils",
        "weight": 1.0
      },
      {
        "from": "src/engine/utils/Storage.res",
        "to": "src/engine/utils/WaitFor.res",
        "relation": "shared_dir:src/engine/utils",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/Distraction.res",
        "to": "lib/bs/src/app/enemies/GuardNPC.res",
        "relation": "shared_dir:lib/bs/src/app/enemies",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/GuardNPC.res",
        "to": "lib/bs/src/app/enemies/SecurityAI.res",
        "relation": "shared_dir:lib/bs/src/app/enemies",
        "weight": 1.0
      },
      {
        "from": "src/app/player/KeyboardAiming.res",
        "to": "src/app/player/PlayerState.res",
        "relation": "shared_dir:src/app/player",
        "weight": 1.0
      },
      {
        "from": "src/app/player/PlayerState.res",
        "to": "src/app/player/TrajectoryPreview.res",
        "relation": "shared_dir:src/app/player",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingRegistry.res",
        "to": "lib/bs/src/app/screens/training/TrainingBase.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingBase.res",
        "to": "lib/bs/src/app/screens/training/DogTraining.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/DogTraining.res",
        "to": "lib/bs/src/app/screens/training/HighwayCrossingTraining.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/HighwayCrossingTraining.res",
        "to": "lib/bs/src/app/screens/training/AssassinTraining.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/AssassinTraining.res",
        "to": "lib/bs/src/app/screens/training/DroneTraining.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/DroneTraining.res",
        "to": "lib/bs/src/app/screens/training/GuardTraining.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/GuardTraining.res",
        "to": "lib/bs/src/app/screens/training/CombatTraining.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/CombatTraining.res",
        "to": "lib/bs/src/app/screens/training/ScavengerTraining.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/ScavengerTraining.res",
        "to": "lib/bs/src/app/screens/training/MoletaireTraining.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/MoletaireTraining.res",
        "to": "lib/bs/src/app/screens/training/TrainingMenuScreen.res",
        "relation": "shared_dir:lib/bs/src/app/screens/training",
        "weight": 1.0
      },
      {
        "from": "src/app/GameLoop.res",
        "to": "src/app/GetEngine.res",
        "relation": "shared_dir:src/app",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/proven/SafeJson.res",
        "to": "lib/bs/src/app/proven/SafeFloat.res",
        "relation": "shared_dir:lib/bs/src/app/proven",
        "weight": 1.0
      },
      {
        "from": "src/app/proven/SafeFloat.res",
        "to": "src/app/proven/SafeJson.res",
        "relation": "shared_dir:src/app/proven",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/KeyboardAiming.res",
        "to": "lib/bs/src/app/player/PlayerState.res",
        "relation": "shared_dir:lib/bs/src/app/player",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/PlayerState.res",
        "to": "lib/bs/src/app/player/TrajectoryPreview.res",
        "relation": "shared_dir:lib/bs/src/app/player",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/MultiplayerGlobal.res",
        "to": "src/app/multiplayer/PhoenixSocket.res",
        "relation": "shared_dir:src/app/multiplayer",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/PhoenixSocket.res",
        "to": "src/app/multiplayer/VMMessageBus.res",
        "relation": "shared_dir:src/app/multiplayer",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/VMMessageBus.res",
        "to": "src/app/multiplayer/VMNetwork.res",
        "relation": "shared_dir:src/app/multiplayer",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/PeerDetection.res",
        "to": "lib/bs/src/app/utils/LanguageSettings.res",
        "relation": "shared_dir:lib/bs/src/app/utils",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/LanguageSettings.res",
        "to": "lib/bs/src/app/utils/AccessibilitySettings.res",
        "relation": "shared_dir:lib/bs/src/app/utils",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/AccessibilitySettings.res",
        "to": "lib/bs/src/app/utils/FeaturePacks.res",
        "relation": "shared_dir:lib/bs/src/app/utils",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/FeaturePacks.res",
        "to": "lib/bs/src/app/utils/GameI18n.res",
        "relation": "shared_dir:lib/bs/src/app/utils",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/PhoenixSocket.res",
        "to": "lib/bs/src/app/multiplayer/MultiplayerGlobal.res",
        "relation": "shared_dir:lib/bs/src/app/multiplayer",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/MultiplayerGlobal.res",
        "to": "lib/bs/src/app/multiplayer/VMMessageBus.res",
        "relation": "shared_dir:lib/bs/src/app/multiplayer",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/VMMessageBus.res",
        "to": "lib/bs/src/app/multiplayer/VMNetwork.res",
        "relation": "shared_dir:lib/bs/src/app/multiplayer",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/ForceLayout.res",
        "to": "lib/bs/src/app/popups/IntegrationsPopup.res",
        "relation": "shared_dir:lib/bs/src/app/popups",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/IntegrationsPopup.res",
        "to": "lib/bs/src/app/popups/AccessibilityPopup.res",
        "relation": "shared_dir:lib/bs/src/app/popups",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/AccessibilityPopup.res",
        "to": "lib/bs/src/app/popups/SettingsPopup.res",
        "relation": "shared_dir:lib/bs/src/app/popups",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/SettingsPopup.res",
        "to": "lib/bs/src/app/popups/NetworkDesktop.res",
        "relation": "shared_dir:lib/bs/src/app/popups",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/NetworkDesktop.res",
        "to": "lib/bs/src/app/popups/PowerView.res",
        "relation": "shared_dir:lib/bs/src/app/popups",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor.res",
        "to": "lib/ocaml/PowerManager.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PowerManager.res",
        "to": "lib/ocaml/PeerDetection.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PeerDetection.res",
        "to": "lib/ocaml/Inventory.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Inventory.res",
        "to": "lib/ocaml/ForceLayout.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/ForceLayout.res",
        "to": "lib/ocaml/VMBridge.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VMBridge.res",
        "to": "lib/ocaml/Distraction.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Distraction.res",
        "to": "lib/ocaml/LanguageSettings.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/LanguageSettings.res",
        "to": "lib/ocaml/AccessibilitySettings.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AccessibilitySettings.res",
        "to": "lib/ocaml/SafeJson.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SafeJson.res",
        "to": "lib/ocaml/Kernel_Crypto.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Kernel_Crypto.res",
        "to": "lib/ocaml/CameraFeed.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CameraFeed.res",
        "to": "lib/ocaml/Coprocessor_Security.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_Security.res",
        "to": "lib/ocaml/RetryPolicy.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/RetryPolicy.res",
        "to": "lib/ocaml/DLCLoader.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DLCLoader.res",
        "to": "lib/ocaml/GuardNPC.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GuardNPC.res",
        "to": "lib/ocaml/FeaturePacks.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/FeaturePacks.res",
        "to": "lib/ocaml/SafeFloat.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SafeFloat.res",
        "to": "lib/ocaml/PasswordCracker.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PasswordCracker.res",
        "to": "lib/ocaml/Coprocessor_IO.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_IO.res",
        "to": "lib/ocaml/DeviceView.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DeviceView.res",
        "to": "lib/ocaml/Coprocessor_Compute.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_Compute.res",
        "to": "lib/ocaml/NetworkTransfer.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkTransfer.res",
        "to": "lib/ocaml/Kernel_Quantum.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Kernel_Quantum.res",
        "to": "lib/ocaml/MoletaireMusic.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MoletaireMusic.res",
        "to": "lib/ocaml/Kernel_IO.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Kernel_IO.res",
        "to": "lib/ocaml/GameI18n.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameI18n.res",
        "to": "lib/ocaml/PhoenixSocket.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PhoenixSocket.res",
        "to": "lib/ocaml/KeyboardAiming.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/KeyboardAiming.res",
        "to": "lib/ocaml/CreditsScreen.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CreditsScreen.res",
        "to": "lib/ocaml/PlayerState.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PlayerState.res",
        "to": "lib/ocaml/RouterDevice.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/RouterDevice.res",
        "to": "lib/ocaml/TrajectoryPreview.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrajectoryPreview.res",
        "to": "lib/ocaml/CameraDevice.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CameraDevice.res",
        "to": "lib/ocaml/TrainingRegistry.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingRegistry.res",
        "to": "lib/ocaml/MultiplayerGlobal.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MultiplayerGlobal.res",
        "to": "lib/ocaml/CoprocessorManager.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CoprocessorManager.res",
        "to": "lib/ocaml/VMMessageBus.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VMMessageBus.res",
        "to": "lib/ocaml/IntegrationsPopup.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/IntegrationsPopup.res",
        "to": "lib/ocaml/CoprocessorBridge.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CoprocessorBridge.res",
        "to": "lib/ocaml/AccessibilityPopup.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AccessibilityPopup.res",
        "to": "lib/ocaml/VMNetwork.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VMNetwork.res",
        "to": "lib/ocaml/SecurityAI.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SecurityAI.res",
        "to": "lib/ocaml/SettingsPopup.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SettingsPopup.res",
        "to": "lib/ocaml/Terminal.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Terminal.res",
        "to": "lib/ocaml/DesktopDevice.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DesktopDevice.res",
        "to": "lib/ocaml/GameOverScreen.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameOverScreen.res",
        "to": "lib/ocaml/VictoryScreen.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VictoryScreen.res",
        "to": "lib/ocaml/IntroScreen.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/IntroScreen.res",
        "to": "lib/ocaml/GameLoop.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameLoop.res",
        "to": "lib/ocaml/GlobalNetworkManager.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GlobalNetworkManager.res",
        "to": "lib/ocaml/NetworkDesktop.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkDesktop.res",
        "to": "lib/ocaml/WorldBuilder.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/WorldBuilder.res",
        "to": "lib/ocaml/TrainingBase.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingBase.res",
        "to": "lib/ocaml/DogTraining.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DogTraining.res",
        "to": "lib/ocaml/HighwayCrossingTraining.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/HighwayCrossingTraining.res",
        "to": "lib/ocaml/AssassinTraining.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AssassinTraining.res",
        "to": "lib/ocaml/DroneTraining.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DroneTraining.res",
        "to": "lib/ocaml/GuardTraining.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GuardTraining.res",
        "to": "lib/ocaml/CombatTraining.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CombatTraining.res",
        "to": "lib/ocaml/ScavengerTraining.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/ScavengerTraining.res",
        "to": "lib/ocaml/MoletaireTraining.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MoletaireTraining.res",
        "to": "lib/ocaml/TrainingMenuScreen.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingMenuScreen.res",
        "to": "lib/ocaml/Resize.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Resize.res",
        "to": "lib/ocaml/Random.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Random.res",
        "to": "lib/ocaml/Storage.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Storage.res",
        "to": "lib/ocaml/Motion.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Motion.res",
        "to": "lib/ocaml/PixiSound.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PixiSound.res",
        "to": "lib/ocaml/Pixi.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Pixi.res",
        "to": "lib/ocaml/WaitFor.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/WaitFor.res",
        "to": "lib/ocaml/PixiUI.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PixiUI.res",
        "to": "lib/ocaml/Bouncer.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Bouncer.res",
        "to": "lib/ocaml/GetEngine.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GetEngine.res",
        "to": "lib/ocaml/LaptopGUI.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/LaptopGUI.res",
        "to": "lib/ocaml/NetworkManager.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkManager.res",
        "to": "lib/ocaml/PowerView.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PowerView.res",
        "to": "lib/ocaml/WorldScreen.res",
        "relation": "shared_dir:lib/ocaml",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/AccessibilityPopup.res",
        "to": "src/app/popups/ForceLayout.res",
        "relation": "shared_dir:src/app/popups",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/ForceLayout.res",
        "to": "src/app/popups/IntegrationsPopup.res",
        "relation": "shared_dir:src/app/popups",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/IntegrationsPopup.res",
        "to": "src/app/popups/NetworkDesktop.res",
        "relation": "shared_dir:src/app/popups",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/NetworkDesktop.res",
        "to": "src/app/popups/SettingsPopup.res",
        "relation": "shared_dir:src/app/popups",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/SettingsPopup.res",
        "to": "src/app/popups/PowerView.res",
        "relation": "shared_dir:src/app/popups",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor.res",
        "to": "lib/bs/src/shared/Inventory.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Inventory.res",
        "to": "lib/bs/src/shared/Kernel_Crypto.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_Crypto.res",
        "to": "lib/bs/src/shared/Coprocessor_Security.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_Security.res",
        "to": "lib/bs/src/shared/RetryPolicy.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/RetryPolicy.res",
        "to": "lib/bs/src/shared/DLCLoader.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/DLCLoader.res",
        "to": "lib/bs/src/shared/Coprocessor_IO.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_IO.res",
        "to": "lib/bs/src/shared/Coprocessor_Compute.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_Compute.res",
        "to": "lib/bs/src/shared/Kernel_Quantum.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_Quantum.res",
        "to": "lib/bs/src/shared/Kernel_IO.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_IO.res",
        "to": "lib/bs/src/shared/CoprocessorManager.res",
        "relation": "shared_dir:lib/bs/src/shared",
        "weight": 1.0
      },
      {
        "from": "main-game/dist/assets/index-Cdt-JTFK.js",
        "to": "main-game/dist/assets/webworkerAll-DNs-UuZS.js",
        "relation": "shared_dir:main-game/dist/assets",
        "weight": 1.0
      },
      {
        "from": "src/shared/RetryPolicy.res",
        "to": "src/shared/Coprocessor.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor.res",
        "to": "src/shared/CoprocessorManager.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/CoprocessorManager.res",
        "to": "src/shared/Coprocessor_Compute.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_Compute.res",
        "to": "src/shared/Coprocessor_IO.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_IO.res",
        "to": "src/shared/Coprocessor_Security.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_Security.res",
        "to": "src/shared/DLCLoader.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/DLCLoader.res",
        "to": "src/shared/Inventory.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/Inventory.res",
        "to": "src/shared/Kernel_Crypto.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_Crypto.res",
        "to": "src/shared/Kernel_IO.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_IO.res",
        "to": "src/shared/Kernel_Quantum.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_Quantum.res",
        "to": "src/shared/UmsLevelLoader.res",
        "relation": "shared_dir:src/shared",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/Distraction.res",
        "to": "src/app/enemies/GuardNPC.res",
        "relation": "shared_dir:src/app/enemies",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/GuardNPC.res",
        "to": "src/app/enemies/SecurityAI.res",
        "relation": "shared_dir:src/app/enemies",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/bindings/Motion.res",
        "to": "lib/bs/src/bindings/PixiSound.res",
        "relation": "shared_dir:lib/bs/src/bindings",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/bindings/PixiSound.res",
        "to": "lib/bs/src/bindings/Pixi.res",
        "relation": "shared_dir:lib/bs/src/bindings",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/bindings/Pixi.res",
        "to": "lib/bs/src/bindings/PixiUI.res",
        "relation": "shared_dir:lib/bs/src/bindings",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/Distraction.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/Distraction.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/Distraction.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/GuardNPC.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/GuardNPC.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/GuardNPC.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/SecurityAI.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/SecurityAI.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/enemies/SecurityAI.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/KeyboardAiming.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/KeyboardAiming.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/KeyboardAiming.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/PlayerState.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/PlayerState.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/PlayerState.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/TrajectoryPreview.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/TrajectoryPreview.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/player/TrajectoryPreview.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingRegistry.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingRegistry.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingRegistry.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingBase.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingBase.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingBase.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/DogTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/DogTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/DogTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/HighwayCrossingTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/HighwayCrossingTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/HighwayCrossingTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/AssassinTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/AssassinTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/AssassinTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/DroneTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/DroneTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/DroneTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/GuardTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/GuardTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/GuardTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/CombatTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/CombatTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/CombatTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/ScavengerTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/ScavengerTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/ScavengerTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/MoletaireTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/MoletaireTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/MoletaireTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingMenuScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingMenuScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/training/TrainingMenuScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/main/Bouncer.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/main/Bouncer.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/main/Bouncer.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/CreditsScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/CreditsScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/CreditsScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/GameOverScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/GameOverScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/GameOverScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/VictoryScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/VictoryScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/VictoryScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/IntroScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/IntroScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/IntroScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/WorldBuilder.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/WorldBuilder.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/WorldBuilder.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/WorldScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/WorldScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/screens/WorldScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/PowerManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/PowerManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/PowerManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/VMBridge.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/bs/src/app/devices/VMBridge.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/bs/src/app/devices/VMBridge.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/bs/src/app/devices/CameraFeed.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CameraFeed.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CameraFeed.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/DeviceView.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/DeviceView.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/DeviceView.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/NetworkTransfer.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/NetworkTransfer.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/NetworkTransfer.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/RouterDevice.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/RouterDevice.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/RouterDevice.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CameraDevice.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CameraDevice.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CameraDevice.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CoprocessorBridge.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CoprocessorBridge.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/CoprocessorBridge.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/Terminal.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/Terminal.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/Terminal.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/DesktopDevice.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/DesktopDevice.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/DesktopDevice.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/GlobalNetworkManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/GlobalNetworkManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/GlobalNetworkManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/LaptopGUI.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/LaptopGUI.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/LaptopGUI.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/NetworkManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/NetworkManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/devices/NetworkManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/PhoenixSocket.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 18.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/PhoenixSocket.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 18.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/PhoenixSocket.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 18.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/MultiplayerGlobal.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/MultiplayerGlobal.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/MultiplayerGlobal.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/VMMessageBus.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/VMMessageBus.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/VMMessageBus.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/VMNetwork.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/VMNetwork.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/multiplayer/VMNetwork.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/PeerDetection.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/PeerDetection.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/PeerDetection.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/LanguageSettings.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/LanguageSettings.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/LanguageSettings.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/AccessibilitySettings.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/AccessibilitySettings.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/AccessibilitySettings.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/FeaturePacks.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/FeaturePacks.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/FeaturePacks.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/GameI18n.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/GameI18n.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/utils/GameI18n.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/tools/PasswordCracker.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/tools/PasswordCracker.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/tools/PasswordCracker.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/companions/MoletaireMusic.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/companions/MoletaireMusic.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/companions/MoletaireMusic.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/proven/SafeJson.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 4.0
      },
      {
        "from": "lib/bs/src/app/proven/SafeJson.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 4.0
      },
      {
        "from": "lib/bs/src/app/proven/SafeJson.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 4.0
      },
      {
        "from": "lib/bs/src/app/proven/SafeFloat.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/bs/src/app/proven/SafeFloat.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/bs/src/app/proven/SafeFloat.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/bs/src/app/popups/ForceLayout.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/app/popups/ForceLayout.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/app/popups/ForceLayout.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/app/popups/IntegrationsPopup.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/IntegrationsPopup.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/IntegrationsPopup.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/AccessibilityPopup.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/AccessibilityPopup.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/AccessibilityPopup.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/SettingsPopup.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/app/popups/SettingsPopup.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/app/popups/SettingsPopup.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/app/popups/NetworkDesktop.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/app/popups/NetworkDesktop.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/app/popups/NetworkDesktop.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/app/popups/PowerView.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/PowerView.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/popups/PowerView.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/GameLoop.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/GameLoop.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/GameLoop.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/GetEngine.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/GetEngine.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/app/GetEngine.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Inventory.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Inventory.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Inventory.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_Crypto.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_Crypto.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_Crypto.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_Security.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_Security.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_Security.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/RetryPolicy.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/shared/RetryPolicy.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/shared/RetryPolicy.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/shared/DLCLoader.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/bs/src/shared/DLCLoader.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/bs/src/shared/DLCLoader.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_IO.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_IO.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_IO.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_Compute.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_Compute.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Coprocessor_Compute.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_Quantum.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_Quantum.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_Quantum.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_IO.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_IO.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/Kernel_IO.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/CoprocessorManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/CoprocessorManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/shared/CoprocessorManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/engine/resize/Resize.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/engine/resize/Resize.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/engine/resize/Resize.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/engine/utils/Random.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/engine/utils/Random.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/engine/utils/Random.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/bs/src/engine/utils/Storage.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/bs/src/engine/utils/Storage.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/bs/src/engine/utils/Storage.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/bs/src/engine/utils/WaitFor.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/engine/utils/WaitFor.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/engine/utils/WaitFor.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/bs/src/bindings/Motion.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/bs/src/bindings/Motion.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/bs/src/bindings/Motion.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/bs/src/bindings/PixiSound.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 9.0
      },
      {
        "from": "lib/bs/src/bindings/PixiSound.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 9.0
      },
      {
        "from": "lib/bs/src/bindings/PixiSound.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 9.0
      },
      {
        "from": "lib/bs/src/bindings/Pixi.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 564.0
      },
      {
        "from": "lib/bs/src/bindings/Pixi.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 564.0
      },
      {
        "from": "lib/bs/src/bindings/Pixi.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 564.0
      },
      {
        "from": "lib/bs/src/bindings/PixiUI.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 102.0
      },
      {
        "from": "lib/bs/src/bindings/PixiUI.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 102.0
      },
      {
        "from": "lib/bs/src/bindings/PixiUI.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 102.0
      },
      {
        "from": "lib/ocaml/Coprocessor.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PowerManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PowerManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PowerManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PeerDetection.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PeerDetection.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PeerDetection.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Inventory.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Inventory.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Inventory.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/ForceLayout.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/ForceLayout.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/ForceLayout.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/VMBridge.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/ocaml/VMBridge.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/ocaml/VMBridge.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/ocaml/Distraction.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Distraction.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Distraction.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/LanguageSettings.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/LanguageSettings.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/LanguageSettings.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AccessibilitySettings.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AccessibilitySettings.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AccessibilitySettings.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SafeJson.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 4.0
      },
      {
        "from": "lib/ocaml/SafeJson.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 4.0
      },
      {
        "from": "lib/ocaml/SafeJson.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 4.0
      },
      {
        "from": "lib/ocaml/Kernel_Crypto.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Kernel_Crypto.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Kernel_Crypto.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CameraFeed.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CameraFeed.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CameraFeed.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_Security.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_Security.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_Security.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/RetryPolicy.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/RetryPolicy.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/RetryPolicy.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/DLCLoader.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/ocaml/DLCLoader.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/ocaml/DLCLoader.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/ocaml/GuardNPC.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GuardNPC.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GuardNPC.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/FeaturePacks.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/FeaturePacks.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/FeaturePacks.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SafeFloat.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/ocaml/SafeFloat.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/ocaml/SafeFloat.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/ocaml/PasswordCracker.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PasswordCracker.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PasswordCracker.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_IO.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_IO.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_IO.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DeviceView.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DeviceView.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DeviceView.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_Compute.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_Compute.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Coprocessor_Compute.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkTransfer.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkTransfer.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkTransfer.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Kernel_Quantum.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/Kernel_Quantum.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/Kernel_Quantum.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/MoletaireMusic.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MoletaireMusic.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MoletaireMusic.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Kernel_IO.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Kernel_IO.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Kernel_IO.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameI18n.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameI18n.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameI18n.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PhoenixSocket.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 18.0
      },
      {
        "from": "lib/ocaml/PhoenixSocket.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 18.0
      },
      {
        "from": "lib/ocaml/PhoenixSocket.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 18.0
      },
      {
        "from": "lib/ocaml/KeyboardAiming.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/KeyboardAiming.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/KeyboardAiming.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CreditsScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CreditsScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CreditsScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PlayerState.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PlayerState.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PlayerState.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/RouterDevice.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/RouterDevice.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/RouterDevice.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrajectoryPreview.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrajectoryPreview.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrajectoryPreview.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CameraDevice.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CameraDevice.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CameraDevice.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingRegistry.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingRegistry.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingRegistry.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MultiplayerGlobal.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MultiplayerGlobal.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MultiplayerGlobal.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CoprocessorManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CoprocessorManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CoprocessorManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VMMessageBus.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VMMessageBus.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VMMessageBus.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/IntegrationsPopup.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/IntegrationsPopup.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/IntegrationsPopup.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CoprocessorBridge.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CoprocessorBridge.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CoprocessorBridge.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AccessibilityPopup.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AccessibilityPopup.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AccessibilityPopup.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VMNetwork.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VMNetwork.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VMNetwork.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SecurityAI.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SecurityAI.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SecurityAI.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/SettingsPopup.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/SettingsPopup.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/SettingsPopup.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/Terminal.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Terminal.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Terminal.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DesktopDevice.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DesktopDevice.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DesktopDevice.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameOverScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameOverScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameOverScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VictoryScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VictoryScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/VictoryScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/IntroScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/IntroScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/IntroScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameLoop.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameLoop.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GameLoop.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GlobalNetworkManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GlobalNetworkManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GlobalNetworkManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkDesktop.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/NetworkDesktop.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/NetworkDesktop.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/WorldBuilder.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/WorldBuilder.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/WorldBuilder.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingBase.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingBase.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingBase.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DogTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DogTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DogTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/HighwayCrossingTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/HighwayCrossingTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/HighwayCrossingTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AssassinTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AssassinTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/AssassinTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DroneTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DroneTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/DroneTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GuardTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GuardTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GuardTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CombatTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CombatTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/CombatTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/ScavengerTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/ScavengerTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/ScavengerTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MoletaireTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MoletaireTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/MoletaireTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingMenuScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingMenuScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/TrainingMenuScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Resize.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Resize.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Resize.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Random.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Random.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Random.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Storage.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/ocaml/Storage.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/ocaml/Storage.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "lib/ocaml/Motion.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/ocaml/Motion.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/ocaml/Motion.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "lib/ocaml/PixiSound.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 9.0
      },
      {
        "from": "lib/ocaml/PixiSound.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 9.0
      },
      {
        "from": "lib/ocaml/PixiSound.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 9.0
      },
      {
        "from": "lib/ocaml/Pixi.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 564.0
      },
      {
        "from": "lib/ocaml/Pixi.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 564.0
      },
      {
        "from": "lib/ocaml/Pixi.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 564.0
      },
      {
        "from": "lib/ocaml/WaitFor.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/WaitFor.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/WaitFor.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "lib/ocaml/PixiUI.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 102.0
      },
      {
        "from": "lib/ocaml/PixiUI.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 102.0
      },
      {
        "from": "lib/ocaml/PixiUI.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 102.0
      },
      {
        "from": "lib/ocaml/Bouncer.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Bouncer.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/Bouncer.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GetEngine.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GetEngine.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/GetEngine.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/LaptopGUI.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/LaptopGUI.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/LaptopGUI.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/NetworkManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PowerView.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PowerView.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/PowerView.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/WorldScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/WorldScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "lib/ocaml/WorldScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "main-game/dist/assets/index-Cdt-JTFK.js",
        "to": "WebServer",
        "relation": "framework",
        "weight": 16.0
      },
      {
        "from": "main-game/dist/assets/index-Cdt-JTFK.js",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 16.0
      },
      {
        "from": "main-game/dist/assets/index-Cdt-JTFK.js",
        "to": "OTP",
        "relation": "framework",
        "weight": 16.0
      },
      {
        "from": "main-game/dist/assets/webworkerAll-DNs-UuZS.js",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "main-game/dist/assets/webworkerAll-DNs-UuZS.js",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "main-game/dist/assets/webworkerAll-DNs-UuZS.js",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "main-game/dist/workbox-8953ae05.js",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "main-game/dist/workbox-8953ae05.js",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "main-game/dist/workbox-8953ae05.js",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/companions/MoletaireMusic.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/companions/MoletaireMusic.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/companions/MoletaireMusic.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/DesktopDevice.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/DesktopDevice.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/DesktopDevice.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/GlobalNetworkManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/GlobalNetworkManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/GlobalNetworkManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CameraDevice.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CameraDevice.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CameraDevice.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CameraFeed.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CameraFeed.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CameraFeed.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CoprocessorBridge.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CoprocessorBridge.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/CoprocessorBridge.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/DeviceView.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/DeviceView.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/DeviceView.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/NetworkTransfer.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/NetworkTransfer.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/NetworkTransfer.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/PowerManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/PowerManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/PowerManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/RouterDevice.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/RouterDevice.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/RouterDevice.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/Terminal.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/Terminal.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/Terminal.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/VMBridge.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "src/app/devices/VMBridge.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "src/app/devices/VMBridge.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "src/app/devices/LaptopGUI.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/LaptopGUI.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/LaptopGUI.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/NetworkManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/NetworkManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/devices/NetworkManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/Distraction.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/Distraction.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/Distraction.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/GuardNPC.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/GuardNPC.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/GuardNPC.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/SecurityAI.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/SecurityAI.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/enemies/SecurityAI.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/MultiplayerGlobal.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/MultiplayerGlobal.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/MultiplayerGlobal.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/PhoenixSocket.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 18.0
      },
      {
        "from": "src/app/multiplayer/PhoenixSocket.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 18.0
      },
      {
        "from": "src/app/multiplayer/PhoenixSocket.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 18.0
      },
      {
        "from": "src/app/multiplayer/VMMessageBus.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/VMMessageBus.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/VMMessageBus.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/VMNetwork.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/VMNetwork.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/multiplayer/VMNetwork.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/player/KeyboardAiming.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/player/KeyboardAiming.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/player/KeyboardAiming.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/player/PlayerState.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/player/PlayerState.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/player/PlayerState.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/player/TrajectoryPreview.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/player/TrajectoryPreview.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/player/TrajectoryPreview.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/AccessibilityPopup.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/AccessibilityPopup.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/AccessibilityPopup.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/ForceLayout.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/app/popups/ForceLayout.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/app/popups/ForceLayout.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/app/popups/IntegrationsPopup.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/IntegrationsPopup.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/IntegrationsPopup.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/NetworkDesktop.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/app/popups/NetworkDesktop.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/app/popups/NetworkDesktop.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/app/popups/SettingsPopup.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/app/popups/SettingsPopup.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/app/popups/SettingsPopup.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/app/popups/PowerView.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/PowerView.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/popups/PowerView.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/proven/SafeFloat.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "src/app/proven/SafeFloat.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "src/app/proven/SafeFloat.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "src/app/proven/SafeJson.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 4.0
      },
      {
        "from": "src/app/proven/SafeJson.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 4.0
      },
      {
        "from": "src/app/proven/SafeJson.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 4.0
      },
      {
        "from": "src/app/screens/main/Bouncer.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/main/Bouncer.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/main/Bouncer.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/CombatTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/CombatTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/CombatTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DogTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DogTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DogTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/GuardTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/GuardTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/GuardTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingRegistry.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingRegistry.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingRegistry.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/AssassinTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/AssassinTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/AssassinTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DroneTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DroneTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DroneTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DroneTrainingGround.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DroneTrainingGround.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/DroneTrainingGround.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/HighwayCrossingTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/HighwayCrossingTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/HighwayCrossingTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/MoletaireTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/MoletaireTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/MoletaireTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/ScavengerTraining.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/ScavengerTraining.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/ScavengerTraining.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingBase.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingBase.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingBase.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingMenuScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingMenuScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/training/TrainingMenuScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/CreditsScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/CreditsScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/CreditsScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/GameOverScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/GameOverScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/GameOverScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/IntroScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/IntroScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/IntroScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/VictoryScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/VictoryScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/VictoryScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/WorldBuilder.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/WorldBuilder.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/WorldBuilder.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/WorldScreen.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/WorldScreen.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/screens/WorldScreen.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/tools/PasswordCracker.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/tools/PasswordCracker.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/tools/PasswordCracker.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/GameI18n.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/GameI18n.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/GameI18n.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/AccessibilitySettings.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/AccessibilitySettings.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/AccessibilitySettings.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/FeaturePacks.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/FeaturePacks.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/FeaturePacks.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/LanguageSettings.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/LanguageSettings.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/LanguageSettings.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/PeerDetection.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/PeerDetection.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/utils/PeerDetection.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/GameLoop.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/GameLoop.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/GameLoop.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/GetEngine.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/GetEngine.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/app/GetEngine.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/bindings/Motion.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "src/bindings/Motion.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "src/bindings/Motion.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 6.0
      },
      {
        "from": "src/bindings/PixiSound.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 9.0
      },
      {
        "from": "src/bindings/PixiSound.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 9.0
      },
      {
        "from": "src/bindings/PixiSound.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 9.0
      },
      {
        "from": "src/bindings/PixiUI.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 102.0
      },
      {
        "from": "src/bindings/PixiUI.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 102.0
      },
      {
        "from": "src/bindings/PixiUI.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 102.0
      },
      {
        "from": "src/bindings/Pixi.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 564.0
      },
      {
        "from": "src/bindings/Pixi.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 564.0
      },
      {
        "from": "src/bindings/Pixi.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 564.0
      },
      {
        "from": "src/engine/resize/Resize.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/engine/resize/Resize.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/engine/resize/Resize.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/engine/utils/Random.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/engine/utils/Random.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/engine/utils/Random.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/engine/utils/Storage.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "src/engine/utils/Storage.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "src/engine/utils/Storage.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "src/engine/utils/WaitFor.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/engine/utils/WaitFor.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/engine/utils/WaitFor.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/shared/RetryPolicy.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/shared/RetryPolicy.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/shared/RetryPolicy.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/shared/Coprocessor.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/CoprocessorManager.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/CoprocessorManager.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/CoprocessorManager.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_Compute.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_Compute.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_Compute.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_IO.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_IO.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_IO.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_Security.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_Security.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Coprocessor_Security.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/DLCLoader.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "src/shared/DLCLoader.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "src/shared/DLCLoader.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "src/shared/Inventory.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Inventory.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Inventory.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_Crypto.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_Crypto.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_Crypto.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_IO.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_IO.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_IO.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "src/shared/Kernel_Quantum.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/shared/Kernel_Quantum.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/shared/Kernel_Quantum.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/shared/UmsLevelLoader.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/shared/UmsLevelLoader.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "src/shared/UmsLevelLoader.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 3.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/arango_client.ex",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/arango_client.ex",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/arango_client.ex",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/cache.ex",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/cache.ex",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/cache.ex",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/database_bridge.ex",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/database_bridge.ex",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/database_bridge.ex",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/game_session_registry.ex",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/game_session_registry.ex",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/game_session_registry.ex",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/game_store.ex",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/game_store.ex",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/game_store.ex",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/verisim_client.ex",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/verisim_client.ex",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/lib/idaptik_sync_server/verisim_client.ex",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/test/connectivity_test.mjs",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/test/connectivity_test.mjs",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "sync-server/test/connectivity_test.mjs",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/InstructionParser.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "vm/lib/ocaml/InstructionParser.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "vm/lib/ocaml/InstructionParser.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "vm/lib/ocaml/Loop.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/Loop.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/Loop.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/State.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "vm/lib/ocaml/State.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "vm/lib/ocaml/State.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "vm/lib/ocaml/VM.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/VM.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/VM.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/benchmark.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/benchmark.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/benchmark.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "vm/lib/ocaml/test_all.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "vm/lib/ocaml/test_all.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "vm/lib/ocaml/test_all.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 2.0
      },
      {
        "from": "idaptik-ums/generated/abi/idaptik_ums.h",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "idaptik-ums/generated/abi/idaptik_ums.h",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "idaptik-ums/generated/abi/idaptik_ums.h",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "idaptik-ums/src/App.res",
        "to": "WebServer",
        "relation": "framework",
        "weight": 15.0
      },
      {
        "from": "idaptik-ums/src/App.res",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 15.0
      },
      {
        "from": "idaptik-ums/src/App.res",
        "to": "OTP",
        "relation": "framework",
        "weight": 15.0
      },
      {
        "from": "idaptik-ums/src-gossamer/main.rs",
        "to": "WebServer",
        "relation": "framework",
        "weight": 11.0
      },
      {
        "from": "idaptik-ums/src-gossamer/main.rs",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 11.0
      },
      {
        "from": "idaptik-ums/src-gossamer/main.rs",
        "to": "OTP",
        "relation": "framework",
        "weight": 11.0
      },
      {
        "from": "setup.sh",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "setup.sh",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "setup.sh",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "flake.nix",
        "to": "WebServer",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "flake.nix",
        "to": "Phoenix",
        "relation": "framework",
        "weight": 1.0
      },
      {
        "from": "flake.nix",
        "to": "OTP",
        "relation": "framework",
        "weight": 1.0
      }
    ]
  },
  "taint_matrix": {
    "rows": [
      {
        "source_category": "MutationGap",
        "sink_axis": "cpu",
        "severity_value": 1.0,
        "files": [
          "sync-server/test/application_test.exs",
          "sync-server/test/router_test.exs"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "MutationGap->Cpu"
      },
      {
        "source_category": "UncheckedError",
        "sink_axis": "memory",
        "severity_value": 2.5,
        "files": [
          "lib/bs/src/app/multiplayer/VMNetwork.res",
          "lib/bs/src/app/ui/HardwareWiring.res",
          "lib/ocaml/HardwareWiring.res",
          "lib/ocaml/VMNetwork.res",
          "src/app/multiplayer/VMNetwork.res",
          "src/app/ui/HardwareWiring.res"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "UncheckedError->Memory"
      },
      {
        "source_category": "InsecureProtocol",
        "sink_axis": "network",
        "severity_value": 2.5,
        "files": [
          "main-game/dist/assets/SharedSystems-D0x1ThPY.js",
          "main-game/dist/assets/webworkerAll-DNs-UuZS.js"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "InsecureProtocol->Network"
      },
      {
        "source_category": "UnsafeDeserialization",
        "sink_axis": "memory",
        "severity_value": 3.5,
        "files": [
          "lib/bs/src/app/proven/SafeJson.res",
          "lib/bs/src/shared/DLCLoader.res",
          "lib/bs/src/engine/utils/Storage.res",
          "lib/ocaml/SafeJson.res",
          "lib/ocaml/DLCLoader.res",
          "lib/ocaml/Storage.res",
          "src/app/proven/SafeJson.res",
          "src/engine/utils/Storage.res",
          "src/shared/DLCLoader.res",
          "src/shared/UmsLevelLoader.res",
          "vm/lib/ocaml/State.res"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "UnsafeDeserialization->Memory"
      },
      {
        "source_category": "DynamicCodeExecution",
        "sink_axis": "network",
        "severity_value": 3.5,
        "files": [
          "main-game/dist/assets/index-Cdt-JTFK.js",
          "main-game/dist/assets/webworkerAll-DNs-UuZS.js"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "DynamicCodeExecution->Network"
      },
      {
        "source_category": "DynamicCodeExecution",
        "sink_axis": "memory",
        "severity_value": 3.5,
        "files": [
          "main-game/dist/assets/index-Cdt-JTFK.js",
          "main-game/dist/assets/webworkerAll-DNs-UuZS.js"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "DynamicCodeExecution->Memory"
      },
      {
        "source_category": "UncheckedError",
        "sink_axis": "cpu",
        "severity_value": 1.0,
        "files": [
          "idaptik-ums/src/abi/ProvenBridge.idr"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "UncheckedError->Cpu"
      },
      {
        "source_category": "PanicPath",
        "sink_axis": "disk",
        "severity_value": 2.5,
        "files": [
          "idaptik-ums/src-gossamer/main.rs"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "PanicPath->Disk"
      },
      {
        "source_category": "HardcodedSecret",
        "sink_axis": "network",
        "severity_value": 5.0,
        "files": [
          "lib/bs/src/app/devices/GlobalNetworkData.res",
          "lib/bs/src/app/tools/PasswordCracker.res",
          "lib/ocaml/GlobalNetworkData.res",
          "lib/ocaml/PasswordCracker.res",
          "main-game/dist/assets/index-Cdt-JTFK.js",
          "src/app/devices/GlobalNetworkData.res",
          "src/app/tools/PasswordCracker.res"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "HardcodedSecret->Network"
      },
      {
        "source_category": "UnsafeDeserialization",
        "sink_axis": "cpu",
        "severity_value": 3.5,
        "files": [
          "lib/bs/src/app/proven/SafeJson.res",
          "lib/bs/src/shared/DLCLoader.res",
          "lib/bs/src/engine/utils/Storage.res",
          "lib/ocaml/SafeJson.res",
          "lib/ocaml/DLCLoader.res",
          "lib/ocaml/Storage.res",
          "src/app/proven/SafeJson.res",
          "src/engine/utils/Storage.res",
          "src/shared/DLCLoader.res",
          "src/shared/UmsLevelLoader.res",
          "vm/lib/ocaml/State.res"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "UnsafeDeserialization->Cpu"
      },
      {
        "source_category": "PanicPath",
        "sink_axis": "memory",
        "severity_value": 2.5,
        "files": [
          "lib/bs/src/app/devices/VMBridge.res",
          "lib/bs/src/app/devices/LaptopGUI.res",
          "lib/bs/src/app/multiplayer/VMNetwork.res",
          "lib/ocaml/VMBridge.res",
          "lib/ocaml/VMNetwork.res",
          "lib/ocaml/LaptopGUI.res",
          "src/app/devices/VMBridge.res",
          "src/app/devices/LaptopGUI.res",
          "src/app/multiplayer/VMNetwork.res",
          "src/shared/UmsLevelLoader.res",
          "vm/lib/ocaml/InstructionParser.res",
          "vm/lib/ocaml/VM.res",
          "vm/lib/ocaml/benchmark.res",
          "vm/lib/ocaml/test_all.res",
          "idaptik-ums/src-gossamer/main.rs"
        ],
        "frameworks": [
          "WebServer",
          "Phoenix",
          "OTP"
        ],
        "relation": "PanicPath->Memory"
      }
    ]
  },
  "migration_metrics": {
    "deprecated_api_count": 16,
    "modern_api_count": 10639,
    "api_migration_ratio": 0.9984983575786016,
    "health_score": 0.82,
    "config_format": "RescriptJson",
    "version_bracket": "V12Current",
    "file_count": 553,
    "rescript_lines": 153883,
    "deprecated_patterns": [
      {
        "pattern": "Js.log",
        "replacement": "Console.log",
        "file_path": "lib/bs/src/app/companions/Moletaire.res",
        "line_number": 0,
        "category": "OldConsole",
        "count": 1
      },
      {
        "pattern": "Js.log",
        "replacement": "Console.log",
        "file_path": "lib/ocaml/Moletaire.res",
        "line_number": 0,
        "category": "OldConsole",
        "count": 1
      },
      {
        "pattern": "Js.log",
        "replacement": "Console.log",
        "file_path": "src/app/companions/Moletaire.res",
        "line_number": 0,
        "category": "OldConsole",
        "count": 1
      },
      {
        "pattern": "Js.Promise.",
        "replacement": "Promise",
        "file_path": "idaptik-ums/src/App.res",
        "line_number": 0,
        "category": "OldPromise",
        "count": 9
      },
      {
        "pattern": "Js.Nullable.",
        "replacement": "Nullable",
        "file_path": "idaptik-ums/src/App.res",
        "line_number": 0,
        "category": "OldNullable",
        "count": 2
      },
      {
        "pattern": "Js.Json.",
        "replacement": "JSON",
        "file_path": "idaptik-ums/src/App.res",
        "line_number": 0,
        "category": "OldJson",
        "count": 2
      }
    ],
    "uncurried": false,
    "module_format": "esmodule"
  }
}
CRG Grade: D
