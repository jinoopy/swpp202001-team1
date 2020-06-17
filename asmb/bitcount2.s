start countSetBits 1:
.entry:
  r2 = mul arg1 1 32 
  r3 = mul 0 1 32 
  br .tailrecurse 
.tailrecurse:
  r1 = icmp eq r2 0 32 
  br r1 .if.then .if.else 
.if.then:
  ret r3 
.if.else:
  r1 = urem r2 2 32 
  r2 = sdiv r2 2 32 
  r1 = add r1 r3 32 
  r3 = mul r1 1 32 
  br .tailrecurse 
end countSetBits

start main 0:
.entry:
  r1 = call read 
  r1 = call countSetBits r1 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  ret 0 
end main

