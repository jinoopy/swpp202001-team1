import json
import os
import subprocess
import re
import platform


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
    print("2. List of all passes")
    mode = int(input())

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
                path = input()
        config["llvm-bin-dir"] = path
        writeConfig(config)

    elif mode == 2 :
        print("Current loaded files:")
        for name in config["opt-pass"].keys():
            print("  " + name)
        print("Write the name of the new pass file.")
        print("Format : lowers/numbers")
        print("Example: mem2reg, instcombine")
        while True:
            passName = input("> ")
            if not passName.isalnum() or passName in config["opt-pass"].keys():
                print("Invalid input")
                continue
            break
        
        print("Write the file name(src/*.cpp) of the new pass file.")
        print("Example: src/XXX.cpp -> XXX.cpp")
        fileName = input("> ")
        regex = re.compile(r"[\d\w_]+\.cpp")
        while True:
            if not re.fullmatch(regex, fileName):
                print("Invalid input")
                continue
            break

        outputName = "".join(ch for ch in fileName if ch.isupper() or ch.isdigit())
        outputName = "lib" + outputName

        config["opt-pass"][passName] = {"src" : fileName, "lib" : outputName}
        writeConfig(config)
    

def build(config):
    if(platform.system() == "Darwin"):
        ISYSROOT = "-isysroot " + subprocessRun("xcrun --show-sdk-path")
        LIBTYPE = ".dylib"
    else:
        ISYSROOT = ""
        LIBTYPE = ".so"
    LLVMCONFIG = config["llvm-bin-dir"]+"/llvm-config"
    CXXFLAGS = subprocessRun(LLVMCONFIG + " --cxxflags")
    LDFLAGS = subprocessRun(LLVMCONFIG + " --ldflags")
    LIBS = subprocessRun(LLVMCONFIG + " --libs core irreader bitreader passes support analysis asmparser --system-libs")
    SRCROOT = subprocessRun(LLVMCONFIG + " --src-root")
    CXX = config["llvm-bin-dir"] + "/clang++"
    #LDFLAGS = LDFLAGS + " -W1,-rpath," + subprocessRun(LLVMCONFIG + " --libdir")
    CXXFLAGS= CXXFLAGS + "-std=c++17 -I \"" + SRCROOT + "/include\""
    
    for p in config["opt-pass"].keys():
        print("Compiling " + "./src/"+config["opt-pass"][p]["src"] + " ...\n")
        subprocess.run(CXX + " " + ISYSROOT + " " + CXXFLAGS + " " + LDFLAGS + " " + LIBS + " src/" + config["opt-pass"][p]["src"] + " -o " + "lib/"+config["opt-pass"][p]["lib"] + LIBTYPE + " -shared -fPIC", shell=True)
        print("Complete!")

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
        passes = " ".join([x if x[0]=="-" else "-load lib/lib"+x+LIBTYPE for x in config["preset-passes"][presets[i]]])
        print("  " + passes)
    print("Enter which pipeline you would like to apply")
    print("1 ~ " + str(len(config["preset-passes"].keys())) + ", or enter 0 for custom execution")
    mode = int(input("> "))
    if mode != 0 :
        passes = " ".join([x if x[0]=="-" else "-load-pass-plugin=./lib/lib"+x+LIBTYPE for x in config["preset-passes"][presets[mode-1]]])
    else:
        print("Enter custom sequences of passes")
        print("MacOS Example: -mem2reg -simplifycfg -load XXX.dylib")
        print("Other OS: -mem2reg -simplifycfg -load XXX.so")
        passes = input("> ")
    #print(config["llvm-bin-dir"]+"/opt -S " + passes + " -o " + llvmir[:-3]+"_out.ll " + llvmir)
    subprocessRun(config["llvm-bin-dir"]+"/opt -S " + passes + " -o " + llvmir[:-3]+"_out.ll " + llvmir)
    print("Complete!")

#def backend()

#################################################

HELP = r'''
==============================
TEAM 1 COMPILER
==============================
How the compiler.py works
0. Do nothing
1. Update&Rewrite config.json
2. Build all .cpp files
3. Run clang/opt with existing/custom passes
4. Run the backend(unimplemented)
==============================
'''
while True:
    print(HELP, end = "")
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
    else:
        break