start countSetBits 1:
.entry:
  r1 = icmp eq arg1 0 32 
  r4 = mul arg1 1 32 
  r3 = mul 0 1 32 
  r2 = mul 0 1 32 
  br r1 .while.end .while.body 
.while.body:
  r1 = srem r4 2 32 
  r3 = add r1 r3 32 
  r2 = sdiv r4 2 32 
  r1 = add r4 1 32 
  r1 = icmp ult r1 3 32 
  r4 = mul r2 1 32 
  r2 = mul r3 1 32 
  br r1 .while.end .while.body 
.while.end:
  ret r2 
end countSetBits

start main 0:
.entry:
  r1 = call read 
  r2 = mul r1 1 32 
  r1 = icmp eq r2 0 32 
  r4 = mul r2 1 32 
  r3 = mul 0 1 32 
  r2 = mul 0 1 64 
  br r1 .countSetBits.exit .while.body.i 
.while.body.i:
  r1 = srem r4 2 32 
  r3 = add r1 r3 32 
  r2 = sdiv r4 2 32 
  r1 = add r4 1 32 
  r1 = icmp ult r1 3 32 
  r4 = mul r2 1 32 
  br r1 .while.cond.i.countSetBits.exit_crit_edge .while.body.i 
.while.cond.i.countSetBits.exit_crit_edge:
  r1 = mul r3 1 64 
  r2 = mul r1 1 64 
  br .countSetBits.exit 
.countSetBits.exit:
  call write r2 
  ret 0 
end main

