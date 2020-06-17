start gcd 2:
.entry:
  r1 = icmp eq arg1 0 64 
  br r1 .if.then .if.end 
.if.then:
  r1 = mul arg2 1 64 
  br .return 
.if.end:
  r1 = icmp eq arg2 0 64 
  br r1 .if.then2 .if.end3 
.if.then2:
  r1 = mul arg1 1 64 
  br .return 
.if.end3:
  r1 = icmp ugt arg1 arg2 64 
  br r1 .if.then5 .if.else 
.if.then5:
  r1 = urem arg1 arg2 64 
  r2 = mul r1 1 64 
  r1 = mul arg2 1 64 
  br .if.end7 
.if.else:
  r1 = urem arg2 arg1 64 
  r2 = mul arg1 1 64 
  br .if.end7 
.if.end7:
  r1 = call gcd r2 r1 
  br .return 
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

