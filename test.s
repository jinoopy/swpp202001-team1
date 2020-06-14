start countSetBits 1:
.entry:
  r0 = icmp eq arg0 0 32 
  r3 = mul arg0 1 32 
  r2 = mul 0 1 32 
  r1 = mul 0 1 32 
  br r0 while.end while.body 
.while.body:
  r0 = srem r3 2 32 
  r2 = add r0 r2 32 
  r1 = sdiv r3 2 32 
  r0 = add r3 1 32 
  r0 = icmp ult r0 3 32 
  r3 = mul r1 1 32 
  r1 = mul r2 1 32 
  br r0 while.end while.body 
.while.end:
  sp = add sp 0 64 
  ret r1 
end countSetBits

start main 0:
.entry:
  r0 = call read 
  r2 = icmp eq r0 0 32 
  r3 = mul r0 1 32 
  r1 = mul 0 1 32 
  r0 = mul 0 1 64 
  br r2 countSetBits.exit while.body.i 
.while.body.i:
  r0 = srem r3 2 32 
  r2 = add r0 r1 32 
  r1 = sdiv r3 2 32 
  r0 = add r3 1 32 
  r0 = icmp ult r0 3 32 
  r3 = mul r1 1 32 
  r1 = mul r2 1 32 
  br r0 while.cond.i.countSetBits.exit_crit_edge while.body.i 
.while.cond.i.countSetBits.exit_crit_edge:
  r0 = mul r2 1 64 
  br countSetBits.exit 
.countSetBits.exit:
  0 = call write r0 
  sp = add sp 0 64 
  ret 0 
end main

