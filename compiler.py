import json
import os
import subprocess
import re
import platform
import sys

def readConfig():
    with open("config.json", "r") as configJSON:
        return json.load(configJSON)

def writeConfig(config):
    with open("config.json", "w") as configJSON:
        json.dump(config, configJSON, indent=4)

def subprocessRun(command):
    return subprocess.run(command, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').rstrip().replace("\n", " ")

def updateConfig(config):
    print("Which config would you edit?")
    print("1. LLVM/bin directory")
    print("2. Add new pipeline")
    mode = int(input("> "))

    #update configuration
    if mode == 1 :
        print("Write the directory of LLVM/bin.")
        print("Current directory : " + config["llvm-bin-dir"])
        path = input("> ")
        while os.path.isdir(path) == False:
            if path[0] == '~':
                path = os.path.expanduser('~') + path[1:]
                if os.path.isdir(path) == True:
                    break
                print("Failed: wrong path (" + path + ")")
                path = input("> ")
        config["llvm-bin-dir"] = path
        writeConfig(config)
    elif mode == 2:
        print("Write the name of the pipeline.")
        pipename = input("> ")
        print("Enter custom sequences of passes")
        print("existing passes: mem2reg indvars ...")
        print("custom passes: (refer to keys of config.json::opt-pass)")
        print("ex: loop-simplify loop-unroll vectorize")
        passes = input("> ").split(" ")
        config["preset-passes"][pipename] = passes
        writeConfig(config)

def build(config):
    if(platform.system() == "Darwin"):
        ISYSROOT = "-isysroot " + subprocessRun("xcrun --show-sdk-path")
        LIBTYPE = ".dylib"
    else:
        ISYSROOT = ""
        LIBTYPE = ".so"

    #Build namespace optim
    print("Building opt pipeline...")
    LLVMCONFIG = config["llvm-bin-dir"]+"/llvm-config"
    CXXFLAGS = subprocessRun(LLVMCONFIG + " --cxxflags")
    LDFLAGS = subprocessRun(LLVMCONFIG + " --ldflags")
    LIBS = subprocessRun(LLVMCONFIG + " --libs core irreader bitreader passes support analysis asmparser --system-libs")
    SRCROOT = subprocessRun(LLVMCONFIG + " --src-root")
    CXX = config["llvm-bin-dir"] + "/clang++"
    LDFLAGS = LDFLAGS + " -W1,-rpath," + subprocessRun(LLVMCONFIG + " --libdir")
    CXXFLAGS= CXXFLAGS + "-std=c++17 -I \"" + SRCROOT + "/include\""
    
    for p in config["opt-pass"].keys():
        print("Compiling " + "./src/"+config["opt-pass"][p]["src"] + " ...\n")
        subprocess.run(CXX + " " + ISYSROOT + " " + CXXFLAGS + " " + LDFLAGS + " " + LIBS + " src/" + config["opt-pass"][p]["src"] + " -o " + "lib/"+config["opt-pass"][p]["lib"] + LIBTYPE + " -shared -fPIC", shell=True)
        print("Complete!\n")
    
    print("Building backend(TO BE DEVELOPED)...")

def opt(config):
    if(platform.system() == "Darwin"):
        LIBTYPE = ".dylib"
    else:
        LIBTYPE = ".so"

    print("Enter the directory for .ll file.")
    llvmir = input("> ")
    
    regex = re.compile(r"[\d\w_/.]+\.ll")
    while True:
        if not re.fullmatch(regex, llvmir):
            print("Invalid input")
            continue
        if not os.path.isfile(llvmir):
            print("File does not exist")
            continue
        break
    print("Current Available Pass pipelines:")
    presets = list(config["preset-passes"].keys())
    for i, pipe in enumerate(presets):
        print(str(i+1) + " : " + pipe)
        passes = " ".join(config["preset-passes"][presets[i]])
        print("  " + passes)
    print("Enter which pipeline you would like to apply")
    print("1 ~ " + str(len(config["preset-passes"].keys())) + ", or enter 0 for custom execution")
    mode = int(input("> "))

    if mode != 0:
        passes = config["preset-passes"][presets[mode-1]]
    else:
        print("Enter custom sequences of passes")
        print("existing passes: mem2reg indvars ...")
        print("custom passes: (refer to keys of config.json::opt-pass)")
        print("ex: loop-simplify loop-unroll vectorize")
        passes = input("> ").split(" ")
    
    outir = llvmir[:-3]+"_out.ll "
    for p in passes:
        arg = ""
        if p in config["opt-pass"].keys():
            arg = "-load-pass-plugin=./lib/"+config["opt-pass"][p]["lib"]+LIBTYPE + " "
        arg += "-passes=\"" + p + "\" "
        print(arg)
        print("now running: <" + p +">", subprocessRun(config["llvm-bin-dir"]+"/opt -S " + arg + " -o " + outir + llvmir))
        llvmir = outir

    print("Complete!")

#def backend()
HELP = r'''
==============================
TEAM 1 COMPILER : DEV mode
==============================
0. Do nothing
1. Update&Rewrite config.json
2. Build all src/XXX.cpp files
3. Run clang/opt with existing/custom passes
4. Run the backend(unimplemented)
5. Run the whole compiler(unimplemented)
==============================
'''
def DEV():
    
    while True:
        print(HELP, end = "")
        mode = -1
        while not 0 <= mode <= 4:
            mode = int(input("Enter the mode number(1~4).\n> "))
        config = readConfig()
        print("==============================")
        if mode == 1:
            updateConfig(config)
        elif mode == 2:
            build(config)
        elif mode == 3:
            opt(config)
        elif mode == 4:
            print("backend() not implemented")
        elif mode == 5:
            inputIR = input("Enter the directory for input .ll file.\n> ")
            outputS = input("Enter the directory for output .s file.\n> ")
            #RUN(inputIR, outputS)
        else:
            break
    

#################################################

# MAIN()

#parse the arguments
try:
    mode = sys.argv[1]
    inputIR = ""
    if len(sys.argv)>=3:
        inputIR = sys.argv[2]
    outputS = inputIR[:-3] + ".s"
    if "-o" in sys.argv:
        outputS = sys.argv[sys.argv.index("-o") + 1]

    #if llvm bin dir is given, check if exists and update config
    config = readConfig()
    binDir = config["llvm-bin-dir"]
    temp = (binDir+".")[:-1]
    if "-bin" in sys.argv:
        temp = (binDir+".")[:-1]
        binDir = sys.argv[sys.argv.index("-bin") + 1]
    if binDir[0] == '~':
        binDir = os.path.expanduser('~') + binDir[1:]
    if not os.path.isdir(binDir):
        print("WRONG INPUT: wrong llvm/bin directory")
        sys.exit()
    config["llvm-bin-dir"] = temp
    writeConfig(config)
except SystemExit:
    sys.exit()
except:
    print("How to use:")
    print("ex) python3 compiler.py -dev")
    print("ex) python3 compiler.py -build -bin (llvm/bin dir)")
    print("ex) python3 compiler.py -run input.ll -bin (llvm/bin dir) -o (output file)")
    sys.exit()

#run the desired mode
if mode == "-dev":
    DEV()
elif mode == "-build":
    print("llvm/bin directory : " + binDir)
    build(config)
elif mode == "-run":
    if inputIR == "":
        print("WRONG INPUT: should enter the input IR file(.ll)")
        print("ex) python3 compiler.py -run input.ll -bin (llvm/bin dir) -o (output file)")
        sys.exit()

    regex = re.compile(r"[\d\w_/.]+\.ll")
    if not re.fullmatch(regex, inputIR):
        print("WRONG INPUT: wrong filename for input IR")
        print("ex) python3 compiler.py -run input.ll -bin (llvm/bin dir) -o (output file)")
        sys.exit()
    regex = re.compile(r"[\d\w_/.]+\.s")
    if not re.fullmatch(regex, outputS):
        print("WRONG INPUT: wrong filename for output Assembly")
        sys.exit()
    #TODO
    print("llvm/bin directory : " + binDir)
    print("input IR : " + inputIR)
    print("output Assembly : " + outputS)
    #RUN(inputIR, outputS)
else:
    print("WRONG INPUT")
    print("ex) python3 compiler.py -dev")
    print("ex) python3 compiler.py -build -bin (llvm/bin dir)")
    print("ex) python3 compiler.py -run input.ll -bin (llvm/bin dir) -o (output file)")