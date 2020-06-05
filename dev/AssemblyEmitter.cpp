#include "Backend.h"

using namespace std;
using namespace llvm;
using namespace backend;

namespace backend {

//static functions for emitting common formats.
string emitInst(vector<string> printlist) {
    string str = "  ";
    for(string s : printlist) {
        str += s + " ";
    }
    str += "\n";
    return str;
}
string emitBinary(Instruction& v, string opcode, string op1, string op2) {
    return emitInst({name(v), "=", opcode, op1, op2, getBitWidth(v.getType())});
}
string emitCopy(Instruction& v, Value& op) {
    return emitBinary(v, "mul", name(op), "1");
}

string AssemblyEmitter::name(Value& v) {
    if(isa<ConstantInt>(v)) {
        //return the value itself.
        return to_string(dyn_cast<ConstantInt>(v).getZExtValue());
    }
    return SM.get(&v)->getName();
}

string AssemblyEmitter::updateBandWidth(Value& v) {
    bandwidth[SM.get(v)] = getBitWidth(v.getType());
    return to_string(bandwidth[SM.get(v)]);
}

AssemblyEmitter(raw_ostream *fout, TargetMachine& TM, SymbolMap& SM, map<Function*, unsigned& spOffset) :
            fout(fout), TM(&TM), SM(&SM), spOffset(&spOffset) {

    for(unsigned i = 0 ; i < 16; i++) {
        bandwidth[TM.reg(i)] = 0;
        bandwidth[TM.arg(i)] = 0;
    }

}

void AssemblyEmitter::visit(Function& F) {
    //print the starting code.
    //finishing code will be printed outside the AssemblyEmitter.
    *fout << "start " << name(F) << " " << F.arg_size() << ":\n";
    *fout << emitInst({"sp = sub sp",to_string(spOffset[&F]),"64"});

    //if main, import GV within.
    //this code should happen only if GV array was in the initial program.
    //GV values are all lowered into alloca + calls
    //TODO: 좀 나중에 하겠습니다...
}
void AssemblyEmitter::visit(BasicBlock& BB) {
    *fout << "." << name(BB) << ":\n";
}

//Compare insts.
void AssemblyEmitter::visitIcmpInst(ICmpInst& I) {
    *fout << emitInst({name(I),"= icmp", I.getPredicateName(), name(I.getOperand(0)), name(I.getOperand(1)), updateBandWidth(I)});
}

//Alloca inst.
void AssemblyEmitter::visitAllocaInst(AllocaInst& I) {
    //Do nothing.
}

//Memory Access insts.
void AssemblyEmitter::visitLoadInst(LoadInst& I) {
    Value& ptr = I.getPointerOperand();
    //bytes to load
    string size = to_string(getAccessSize(dyn_cast<PointerType>(ptr.getType())->getElementType()));
    Symbol* symbol = SM.get(&ptr);
    //if pointer operand is a memory value(GV or alloca),
    if(Memory* mem = static_cast<Memory>(symbol)) {
        if(mem->getBase() == TM.sp()) {
            *fout << emitInst({name(I), "= load", size ,"sp", mem->getOffset()});
        }
        else if(mem->getBase() == TM.gvp()) {
            *fout << emitInst({name(I), "= load", size, "20480", mem->getOffset()});
        }
        else assert(false && "base of memory pointers should be sp or gvp");
    }
    //else a pointer stored in register,
    else if(Register* reg = static_cast<Register>(Symbol)) {
        *fout << emitInst({name(I), "= load", size, reg->getName(), "0"});
    }
    else assert(false && "pointer of a memory operation should have an appropriate symbol assigned");
    updateBandWidth(I);
}
void AssemblyEmitter::visitStoreInst(StoreInst& I) {
    Value& ptr = I.getPointerOperand();
    //bytes to load
    string size = to_string(getAccessSize(dyn_cast<PointerType>(ptr.getType())->getElementType()));
    Value& val = I.getValueOperand();
    Symbol* symbol = SM.get(&ptr);
    //if pointer operand is a memory value(GV or alloca),
    if(Memory* mem = static_cast<Memory>(symbol)) {
        if(mem->getBase() == TM.sp()) {
            *fout << emitInst({"store", name(val), size ,"sp", mem->getOffset()});
        }
        else if(mem->getBase() == TM.gvp()) {
            *fout << emitInst({"store", name(val), size, "20480", mem->getOffset()});
        }
        else assert(false && "base of memory pointers should be sp or gvp");
    }
    //else a pointer stored in register,
    else if(Register* reg = static_cast<Register>(Symbol)) {
        *fout << emitInst({"store", name(val), size, reg->getName(), "0"});
    }
    else assert(false && "pointer of a memory operation should have an appropriate symbol assigned");
    updateBandWidth(I);
}

//PHI Node inst.
void AssemblyEmitter::visitPHINode(PHINode& I) {
    //Do nothing.
}

//Reformatting(no value changes) insts.
void AssemblyEmitter::visitTruncInst(TruncInst& I) {
    //If coallocated to the same registers, do nothing.
    //Else, copy the value.
    if(SM.get(I) != SM.get(I.getOperand(0))) {
        *fout << emitCopy(I, I.getOperand(0));
    }
    updateBandWidth(I);
}
void AssemblyEmitter::visitZExtInst(ZExtInst& I) {
    //If coallocated to the same registers, do nothing.
    //Else, copy the value.
    if(SM.get(I) != SM.get(I.getOperand(0))) {
        *fout << emitCopy(I, I.getOperand(0));
    }
    updateBandWidth(I);
}
void AssemblyEmitter::visitSExtInst(SExtInst& I) {
    //Do nothing.
    //FIXME
    //swpp202001-compiler: treated as no-op => is this a correct implementation?
}
void AssemblyEmitter::visitPtrToIntInst(PtrToIntInst& I) {
    Value& ptr = I.getPointerOperand();
    Symbol* symbol = SM.get(&ptr);
    //if pointer operand is a memory value(GV or alloca),
    if(Memory* mem = static_cast<Memory>(symbol)) {
        if(mem->getBase() == TM.sp()) {
            *fout << emitBinary(I, "add", "sp", to_string(mem->getoffset()));
        }
        else if(mem->getBase() == TM.gvp()) {
            *fout << emitBinary(I, "add", "20480", to_string(mem->getoffset()));
        }
        else assert(false && "base of memory pointers should be sp or gvp");
    }
    //else a pointer stored in register,
    else if(Register* reg = static_cast<Register>(Symbol)) {
        //if from and to values are stored in a different source, copy.
        if(SM.get(I) != SM.get(I.getOperand(0))) {
            *fout << emitCopy(I, I.getOperand(0));
        }
    }
    else assert(false && "pointer of a memory operation should have an appropriate symbol assigned");
    updateBandWidth(I);
}
void AssemblyEmitter::visitIntToPtrInst(IntToPtrInst& I) {
    //If coallocated to the same registers, do nothing.
    //Else, copy the value.
    if(SM.get(I) != SM.get(I.getOperand(0))) {
        *fout << emitCopy(I, I.getOperand(0));
    }
    updateBandWidth(I);
}
void AssemblyEmitter::visitBitCastInst(BitCastInst& I) {
    //If coallocated to the same registers, do nothing.
    //Else, copy the value.
    if(SM.get(I) != SM.get(I.getOperand(0))) {
        *fout << emitCopy(I, I.getOperand(0));
    }
    updateBandWidth(I);
}

//Select inst.
void AssemblyEmitter::visitSelectInst(SelectInst& I) {
    *fout << emitInst({name(I), "= select", name(I.getCondition()), name(I.getTrueValue()), name(I.getFalseValue()), updateBandWidth(I)})
}

void AssemblyEmitter::visitCallInst(CallInst& I) {
    //Process malloc()&free() from other plain call insts.
    Function* F = I.getFunction();
    string Fname = F->getName();
    
    //Collect all arguments
    vector<string> args;
    for(Value& arg : I.args()) {
        args.push_back(name(arg));
    }
    if(name == "malloc") {
        assert(args.size()==1 && "argument of malloc() should be 1");
        *fout << emitInst({name(I), "= malloc", name(arg[0])});
    }
    else if(name == "free") {
        assert(args.size()==1 && "argument of free() should be 1");
        *fout << emitInst({name(I), "= free", name(arg[0])});
    }
    //ordinary function calls.
    else {
        vector<string> printlist = {name(I), "= malloc", name(arg[0])};
        printlist.insert(printlist.end(), args.begin(), args.end());
        *fout << emitInst(printlist);
    }
}

//Terminator insts.
void AssemblyEmitter::visitReturnInst(ReturnInst& I) {
    //increase sp(which was decreased in the beginning of the function.)
    Function* F = I.getFunction();
    *fout << emitInst({"sp = add sp",to_string(spOffset[F]),"64"});
    *fout << emitInst({"ret", name(I.getReturnValue())});
}
void AssemblyEmitter::visitBranchInst(BranchInst& I) {
    if(I.isConditional()) {
        assert(I.getNumSuccessors() == 2 && "conditional branches must have 2 successors");
        *fout << emitInst("br", name(I.getCondition()), name(I.getSuccessor(0)), name(I.getSuccessor(1)));
    }
    else {
        assert(I.getNumSuccessors() == 1 && "unconditional branches must have 1 successor");
        *fout << emitInst("br", name(I.getSuccessor(0)));
    }
}
void AssemblyEmitter::visitSwitchInst(SwitchInst& I) {

}
void AssemblyEmitter::visitBinaryOperator(BinaryOperator& I) {
    string opcode = "";
    switch(BO.getOpcode()) {
    case Instruction::UDiv: opcode = "udiv"; break;
    case Instruction::SDiv: opcode = "sdiv"; break;
    case Instruction::URem: opcode = "urem"; break;
    case Instruction::SRem: opcode = "srem"; break;
    case Instruction::Mul:  opcode = "mul"; break;
    case Instruction::Shl:  opcode = "shl"; break;
    case Instruction::AShr: opcode = "ashr"; break;
    case Instruction::LShr: opcode = "lshr"; break;
    case Instruction::And:  opcode = "and"; break;
    case Instruction::Or:   opcode = "or"; break;
    case Instruction::Xor:  opcode = "xor"; break;
    case Instruction::Add:  opcode = "add"; break;
    case Instruction::Sub:  opcode = "sub"; break;
    default: assert(false && "undefined binary operation");
    }

    *fout << emitBinary(I, opcode, name(I.getOperand(0)), name(I.getOperand(1)));
}
}