start countSetBits 1:
.entry:
  r1 = icmp eq arg1 0 32 
  r2 = mul arg1 1 32 
  r4 = mul 0 1 32 
  r5 = mul 0 1 32 
  br r1 .while.end .while.body 
.while.body:
  r1 = add r2 4294967295 32 
  r2 = and r1 r2 32 
  r1 = add r4 1 32 
  r3 = icmp eq r2 0 32 
  r4 = mul r1 1 32 
  r5 = mul r1 1 32 
  br r3 .while.end .while.body 
.while.end:
  sp = add sp 0 64 
  ret r5 
end countSetBits

start main 0:
.entry:
  r1 = call read 
  r3 = icmp eq r1 0 32 
  r2 = mul r1 1 32 
  r4 = mul 0 1 32 
  r1 = mul 0 1 64 
  br r3 .countSetBits.exit .while.body.i 
.while.body.i:
  r1 = add r2 4294967295 32 
  r2 = and r1 r2 32 
  r1 = add r4 1 32 
  r3 = icmp eq r2 0 32 
  r4 = mul r1 1 32 
  br r3 .while.cond.i.countSetBits.exit_crit_edge .while.body.i 
.while.cond.i.countSetBits.exit_crit_edge:
  br .countSetBits.exit 
.countSetBits.exit:
  call write r1 
  sp = add sp 0 64 
  ret 0 
end main

