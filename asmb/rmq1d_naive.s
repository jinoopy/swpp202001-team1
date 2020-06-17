start malloc_upto_8 1:
.entry:
  r1 = add arg1 7 64 
  r1 = and r1 18446744073709551608 64 
  r1 = malloc r1 
  ret r1 
end malloc_upto_8

start min_element 2:
.entry:
  r1 = load 4 arg1 0 
  r2 = mul r1 1 32 
  r4 = mul arg1 1 64 
  br .while.cond 
.while.cond:
  r1 = icmp eq r4 arg2 64 
  br r1 .while.end .while.body 
.while.body:
  r3 = load 4 r4 0 
  r1 = icmp slt r3 r2 32 
  r5 = mul r2 1 32 
  br r1 .if.then .if.end 
.if.then:
  r5 = mul r3 1 32 
  br .if.end 
.if.end:
  r2 = mul r4 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = mul r5 1 32 
  r4 = mul r1 1 64 
  br .while.cond 
.while.end:
  ret r2 
end min_element

start main 0:
.entry:
  r1 = call read 
  r5 = mul r1 1 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 1073741824 64 
  r7 = call malloc_upto_8 r1 
  r6 = mul r7 1 64 
  r3 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp slt r3 r5 32 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  r1 = call read 
  r2 = mul r1 1 32 
  br .while.cond 
.for.body:
  r1 = call read 
  r4 = mul r1 1 32 
  r1 = mul r3 1 64 
  r2 = mul r6 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  store 4 r4 r1 0 
  r1 = add r3 1 32 
  r3 = mul r1 1 32 
  br .for.cond 
.while.cond:
  r1 = icmp eq r2 0 32 
  br r1 .while.end .while.body 
.while.body:
  r5 = add r2 4294967295 32 
  r1 = call read 
  r2 = call read 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r3 = mul r6 1 64 
  r1 = mul r1 4 64 
  r4 = add r3 r1 64 
  r1 = mul r2 4294967296 64 
  r3 = sdiv r1 4294967296 64 
  r2 = mul r7 1 64 
  r1 = mul 4 1 64 
  r1 = add r2 r1 64 
  r2 = mul r1 1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r1 = call min_element r4 r1 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  r2 = mul r5 1 32 
  br .while.cond 
.while.end:
  ret 0 
end main

