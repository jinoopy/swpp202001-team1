start collatz 2:
.entry:
  r1 = mul arg2 1 64 
  call write r1 
  r1 = icmp ult arg2 2 32 
  r3 = mul arg2 1 32 
  r4 = mul arg2 1 32 
  br r1 .return .if.end 
.if.end:
  r2 = load 2 arg1 0 
  r1 = icmp slt r2 0 16 
  r3 = mul 4294967295 1 32 
  br r1 .return .if.end6 
.if.end6:
  r1 = add r2 1 16 
  store 2 r1 arg1 0 
  r1 = urem r4 2 32 
  r1 = icmp eq r1 0 32 
  br r1 .cond.true .cond.false 
.cond.true:
  r1 = udiv r4 2 32 
  r2 = mul r1 1 32 
  br .cond.end 
.cond.false:
  r1 = mul r4 3 32 
  r1 = add r1 1 32 
  r2 = mul r1 1 32 
  br .cond.end 
.cond.end:
  r1 = mul r2 1 64 
  call write r1 
  r1 = icmp ult r2 2 32 
  r3 = mul r2 1 32 
  r4 = mul r2 1 32 
  br r1 .return .if.end 
.return:
  ret r3 
end collatz

start main 0:
.entry:
  r1 = call read 
  r2 = mul r1 1 32 
  r1 = urem r1 4294967296 64 
  call write r1 
  r4 = icmp ult r2 2 32 
  r3 = mul r2 1 32 
  r2 = mul 0 1 16 
  r1 = mul 0 1 64 
  br r4 .collatz.exit .if.end6.i 
.if.end6.i:
  r1 = urem r3 2 32 
  r1 = icmp eq r1 0 32 
  br r1 .cond.true.i .cond.false.i 
.cond.true.i:
  r1 = udiv r3 2 32 
  r4 = mul r1 1 32 
  br .cond.end.i 
.cond.false.i:
  r1 = mul r3 3 32 
  r1 = add r1 1 32 
  r4 = mul r1 1 32 
  br .cond.end.i 
.cond.end.i:
  r3 = add r2 1 16 
  r1 = mul r4 1 64 
  call write r1 
  r2 = icmp ult r4 2 32 
  r1 = icmp slt r3 0 16 
  r1 = or r1 r2 1 
  r2 = mul r3 1 16 
  r3 = mul r4 1 32 
  br r1 .tailrecurse.i.collatz.exit_crit_edge .if.end6.i 
.tailrecurse.i.collatz.exit_crit_edge:
  r1 = mul r3 281474976710656 64 
  r1 = sdiv r1 281474976710656 64 
  br .collatz.exit 
.collatz.exit:
  call write r1 
  ret 0 
end main

