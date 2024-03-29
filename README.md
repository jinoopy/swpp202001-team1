# TEAM 1 Compiler

## Results

- 1st Prize out of all teams in 2020-01

- Best speedup in 15 tasks out of 23

- Highly efficient assembly by Graph coloring-based Register Allocation

- Check out by counting LOAD and STORE ops! They are reduced to the limit 

- Relatively bad performance on loop optimization.

## How to use

### Dev mode

`python3 compiler.py -dev`

Enters the dev mode, which we can load custom passes.

### Build mode

`python3 compiler.py -build (-bin (llvm/bin dir))`

Builds the cpp sources from /src.

- `-bin` is set to what is in config.json for default.

### Run mode

`python3 compiler.py -run (input file .ll) (-bin (llvm/bin directory)) (-o (output file .s))`

Emits the result in .s format of our target machine.

- `-bin` is set to what is in config.json for default.
- `-o`, for default, is set to a file which has the same name with the input, but only the extension is different.</br>
 `./test/input.ll` → `./test/input.s`


## About config.json

You may change settings of config.json. This file will be hidden in further commits.

> `"llvm-bin-dir": "...."`

Value of this field should be the llvm bin directory, i.e. `llvmscript/llvm-10.0-release/bin.`
This field can be updated manually, or in the `-dev` mode, or with giving the right argument to `-build` or `-run` mode.
We recommend to use `release` build for the compatibility.

> `"opt-pass": ....`

This field is recommended to fix with `-dev` mode. Do not touch if necessary.

> `"preset-passes": ....`

It is recommended not to modify or delete existing component.
If you add a custom pipeline, this will appear in the 3rd option in the `-dev` mode.

> `"run": ...`

This is for the run mode. This contains the information about the order of optimizations and backend sequence.
