start countSetBits 1:
.entry:
  r1 = icmp eq arg1 0 32 
  br r1 .if.then .if.else 
.if.then:
  r1 = mul 0 1 32 
  br .return 
.if.else:
  r2 = urem arg1 2 32 
  r1 = sdiv arg1 2 32 
  r1 = call countSetBits r1 
  r1 = add r1 r2 32 
  br .return 
.return:
  ret r1 
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

