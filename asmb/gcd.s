start gcd 2:
.entry:
  r1 = icmp eq arg1 0 64 
  r2 = mul arg2 1 64 
  r4 = mul arg1 1 64 
  r5 = mul arg2 1 64 
  br r1 .return .if.end 
.if.end:
  r1 = icmp eq r5 0 64 
  r2 = mul r4 1 64 
  br r1 .return .if.end3 
.if.end3:
  r3 = icmp ugt r4 r5 64 
  br r3 .if.then5 .if.else 
.if.then5:
  r1 = urem r4 r5 64 
  r2 = mul r1 1 64 
  r1 = mul r5 1 64 
  br .if.end7 
.if.else:
  r1 = urem r5 r4 64 
  r2 = mul r4 1 64 
  br .if.end7 
.if.end7:
  r3 = icmp eq r2 0 64 
  r4 = mul r2 1 64 
  r5 = mul r1 1 64 
  r2 = mul r1 1 64 
  br r3 .return .if.end 
.return:
  ret r2 
end gcd

start main 0:
.entry:
  r3 = call read 
  r2 = call read 
  r1 = icmp eq r3 0 64 
  r4 = mul r3 1 64 
  r5 = mul r2 1 64 
  br r1 .gcd.exit .if.end.i 
.if.end.i:
  r1 = icmp eq r5 0 64 
  r2 = mul r4 1 64 
  br r1 .gcd.exit .if.end3.i 
.if.end3.i:
  r3 = icmp ugt r4 r5 64 
  br r3 .if.then5.i .if.else.i 
.if.then5.i:
  r1 = urem r4 r5 64 
  r2 = mul r1 1 64 
  r1 = mul r5 1 64 
  br .if.end7.i 
.if.else.i:
  r1 = urem r5 r4 64 
  r2 = mul r4 1 64 
  br .if.end7.i 
.if.end7.i:
  r3 = icmp eq r2 0 64 
  r4 = mul r2 1 64 
  r5 = mul r1 1 64 
  r2 = mul r1 1 64 
  br r3 .gcd.exit .if.end.i 
.gcd.exit:
  call write r2 
  ret 0 
end main

