start collatz 2:
.entry:
  r3 = mul arg2 1 32 
  br .tailrecurse 
.tailrecurse:
  r1 = mul r3 1 64 
  call write r1 
  r1 = icmp ult r3 2 32 
  br r1 .if.then .if.end 
.if.then:
  r1 = mul r3 1 32 
  br .return 
.if.end:
  r2 = load 2 arg1 0 
  r1 = icmp slt r2 0 16 
  br r1 .if.then5 .if.end6 
.if.then5:
  r1 = mul 4294967295 1 32 
  br .return 
.if.end6:
  r1 = add r2 1 16 
  store 2 r1 arg1 0 
  r1 = urem r3 2 32 
  r1 = icmp eq r1 0 32 
  br r1 .cond.true .cond.false 
.cond.true:
  r1 = udiv r3 2 32 
  br .cond.end 
.cond.false:
  r1 = mul r3 3 32 
  r1 = add r1 1 32 
  br .cond.end 
.cond.end:
  r3 = mul r1 1 32 
  br .tailrecurse 
.return:
  ret r1 
end collatz

start main 0:
.entry:
  ; Init stack pointer
  sp = sub sp 2 64 
  r1 = call read 
  r2 = mul r1 1 32 
  store 2 0 sp 0 
  r1 = add sp 0 64 
  r1 = call collatz r1 r2 
  r1 = load 2 sp 0 
  r1 = mul r1 281474976710656 64 
  r1 = sdiv r1 281474976710656 64 
  call write r1 
  sp = add sp 2 64 
  ret 0 
end main

