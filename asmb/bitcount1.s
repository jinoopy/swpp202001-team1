start countSetBits 1:
.entry:
  r3 = icmp eq arg1 0 32 
  r4 = mul arg1 1 32 
  r2 = mul 0 1 32 
  r1 = mul 0 1 32 
  br r3 .while.end .while.body 
.while.body:
  r1 = urem r4 2 32 
  r2 = add r1 r2 32 
  r1 = udiv r4 2 32 
  r3 = icmp eq r1 0 32 
  r4 = mul r1 1 32 
  r1 = mul r2 1 32 
  br r3 .while.end .while.body 
.while.end:
  ret r1 
end countSetBits

start main 0:
.entry:
  r1 = call read 
  r3 = icmp eq r1 0 32 
  r4 = mul r1 1 32 
  r2 = mul 0 1 32 
  r1 = mul 0 1 64 
  br r3 .countSetBits.exit .while.body.i 
.while.body.i:
  r1 = urem r4 2 32 
  r2 = add r1 r2 32 
  r1 = udiv r4 2 32 
  r3 = icmp eq r1 0 32 
  r4 = mul r1 1 32 
  br r3 .while.cond.i.countSetBits.exit_crit_edge .while.body.i 
.while.cond.i.countSetBits.exit_crit_edge:
  r1 = mul r2 1 64 
  br .countSetBits.exit 
.countSetBits.exit:
  call write r1 
  ret 0 
end main

