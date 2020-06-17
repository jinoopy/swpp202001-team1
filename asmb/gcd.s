start gcd 2:
.entry:
  r2 = mul arg2 1 64 
  r3 = mul arg1 1 64 
  br .tailrecurse 
.tailrecurse:
  r1 = icmp eq r3 0 64 
  br r1 .if.then .if.end 
.if.then:
  r1 = mul r2 1 64 
  br .return 
.if.end:
  r1 = icmp eq r2 0 64 
  br r1 .if.then2 .if.end3 
.if.then2:
  r1 = mul r3 1 64 
  br .return 
.if.end3:
  r1 = icmp ugt r3 r2 64 
  br r1 .if.then5 .if.else 
.if.then5:
  r1 = urem r3 r2 64 
  r4 = mul r1 1 64 
  r1 = mul r2 1 64 
  r2 = mul r4 1 64 
  br .if.end7 
.if.else:
  r1 = urem r2 r3 64 
  r2 = mul r3 1 64 
  br .if.end7 
.if.end7:
  r3 = mul r2 1 64 
  r2 = mul r1 1 64 
  br .tailrecurse 
.return:
  ret r1 
end gcd

start main 0:
.entry:
  r2 = call read 
  r1 = call read 
  r1 = call gcd r2 r1 
  call write r1 
  ret 0 
end main

