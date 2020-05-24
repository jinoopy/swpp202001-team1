# TEAM 1 Compiler

## How to use

NOT_IMPLEMENTED
`python3 compiler.py (input file .ll)`

emits the result in .s format of our target machine.

`python3 compiler.py -dev`

enters the dev mode, which we can load custom passes.

## About config.json

You may change settings of config.json.

`"llvm-bin-dir": "...."`

Value of this field should be the llvm bin directory, i.e. llvmscript/llvm-10.0-release/bin.

`"opt-pass": ....
`
This field is recommended to fix with `-dev` mode. Do not touch if necessary.

`"preset-passes": ....`

You may freely touch the list of presets included.
If you add a custom pipeline, this will appear in the 3rd option in the `-dev` mode.

`"run": ...`

This is for the run mode later on. Do not touch or modify now.
