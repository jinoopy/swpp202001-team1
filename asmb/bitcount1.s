start countSetBits 1:
.entry:
  r3 = mul arg1 1 32 
  r2 = mul 0 1 32 
  br .while.cond 
.while.cond:
  r1 = icmp eq r3 0 32 
  br r1 .while.end .while.body 
.while.body:
  r1 = urem r3 2 32 
  r2 = add r2 r1 32 
  r1 = udiv r3 2 32 
  r3 = mul r1 1 32 
  br .while.cond 
.while.end:
  ret r2 
end countSetBits

start main 0:
.entry:
  r1 = call read 
  r1 = call countSetBits r1 
  call write r1 
  ret 0 
end main

