start countSetBits 1:
.entry:
  r2 = mul arg0 1 32 
  r1 = mul 0 1 32 
  br while.cond 
.while.cond:
  r0 = icmp ne r2 0 32 
  br r0 while.body while.end 
.while.body:
  r0 = and r2 1 32 
  r1 = add r1 r0 32 
  r0 = lshr r2 1 32 
  r2 = mul r0 1 32 
  br while.cond 
.while.end:
  sp = add sp 0 64 
  ret r1 
end countSetBits

start main 0:
.entry:
  r0 = call read 
  r0 = call countSetBits r0 
  0 = call write r0 
  sp = add sp 0 64 
  ret 0 
end main

