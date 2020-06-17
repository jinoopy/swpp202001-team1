start countSetBits 1:
.entry:
  r2 = mul arg1 1 32 
  r3 = mul 0 1 32 
  br .while.cond 
.while.cond:
  r1 = icmp eq r2 0 32 
  br r1 .while.end .while.body 
.while.body:
  r1 = add r2 4294967295 32 
  r2 = and r1 r2 32 
  r1 = add r3 1 32 
  r3 = mul r1 1 32 
  br .while.cond 
.while.end:
  ret r3 
end countSetBits

start main 0:
.entry:
  r1 = call read 
  r1 = call countSetBits r1 
  call write r1 
  ret 0 
end main

