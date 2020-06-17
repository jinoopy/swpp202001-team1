start malloc_upto_8 1:
.entry:
  r1 = add arg1 7 64 
  r1 = and r1 18446744073709551608 64 
  r1 = malloc r1 
  ret r1 
end malloc_upto_8

start min 2:
.entry:
  r1 = icmp slt arg1 arg2 32 
  br r1 .cond.true .cond.false 
.cond.true:
  r1 = mul arg1 1 32 
  br .cond.end 
.cond.false:
  r1 = mul arg2 1 32 
  br .cond.end 
.cond.end:
  ret r1 
end min

start min_element 2:
.entry:
  r3 = mul arg1 1 64 
  r4 = mul arg1 1 64 
  br .while.cond 
.while.cond:
  r1 = icmp eq r4 arg2 64 
  br r1 .while.end .while.body 
.while.body:
  r2 = load 4 r4 0 
  r1 = load 4 r3 0 
  r1 = icmp slt r2 r1 32 
  r2 = mul r3 1 64 
  br r1 .if.then .if.end 
.if.then:
  r2 = mul r4 1 64 
  br .if.end 
.if.end:
  r1 = mul r4 1 64 
  r3 = mul 1 4 64 
  r1 = add r1 r3 64 
  r3 = mul r2 1 64 
  r4 = mul r1 1 64 
  br .while.cond 
.while.end:
  ret r3 
end min_element

start min_at_row 3:
.entry:
  r1 = load 8 20480 0 
  r3 = mul arg1 4294967296 64 
  r3 = sdiv r3 4294967296 64 
  r2 = mul r1 1 64 
  r1 = mul r3 8 64 
  r1 = add r2 r1 64 
  r4 = load 8 r1 0 
  r1 = mul arg2 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r4 1 64 
  r1 = mul r1 4 64 
  r3 = add r2 r1 64 
  r1 = mul arg3 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r4 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r2 = mul r1 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r1 = call min_element r3 r1 
  r1 = load 4 r1 0 
  ret r1 
end min_at_row

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 8 
  r1 = call read 
  r4 = call read 
  r3 = mul r1 4294967296 64 
  r1 = sdiv r3 536870912 64 
  r2 = call malloc_upto_8 r1 
  r1 = add 20480 0 64 
  store 8 r2 r1 0 
  r1 = mul r4 4294967296 64 
  r8 = sdiv r1 1073741824 64 
  r7 = sdiv r1 4294967296 64 
  r6 = sdiv r3 4294967296 64 
  r5 = mul 0 1 64 
  br .for.cond 
.for.cond:
  r1 = icmp slt r5 r6 64 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  r1 = call read 
  r6 = mul r1 1 32 
  br .while.cond 
.for.body:
  r3 = call malloc_upto_8 r8 
  r2 = load 8 20480 0 
  r1 = mul r5 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r4 = mul 0 1 64 
  br .for.cond9 
.for.cond9:
  r1 = icmp slt r4 r7 64 
  br r1 .for.body13 .for.cond.cleanup12 
.for.cond.cleanup12:
  r1 = add r5 1 64 
  r5 = mul r1 1 64 
  br .for.cond 
.for.body13:
  r1 = call read 
  r3 = mul r1 1 32 
  r2 = load 8 20480 0 
  r1 = mul r5 8 64 
  r1 = add r2 r1 64 
  r2 = load 8 r1 0 
  r1 = mul r4 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r1 = add r4 1 64 
  r4 = mul r1 1 64 
  br .for.cond9 
.while.cond:
  r1 = icmp eq r6 0 32 
  br r1 .while.end .while.body 
.while.body:
  r1 = call read 
  r2 = mul r1 1 32 
  r1 = call read 
  r5 = mul r1 1 32 
  r1 = call read 
  r4 = mul r1 1 32 
  r1 = call read 
  r3 = mul r1 1 32 
  r1 = call min_at_row r2 r4 r3 
  r7 = mul r1 1 32 
  br .for.cond35 
.for.cond35:
  r1 = icmp slt r2 r5 32 
  br r1 .for.body39 .for.cond.cleanup38 
.for.cond.cleanup38:
  r1 = add r6 4294967295 32 
  r2 = mul r7 4294967296 64 
  r2 = sdiv r2 4294967296 64 
  call write r2 
  r6 = mul r1 1 32 
  br .while.cond 
.for.body39:
  r2 = add r2 1 32 
  r1 = call min_at_row r2 r4 r3 
  r1 = call min r7 r1 
  r7 = mul r1 1 32 
  br .for.cond35 
.while.end:
  ret 0 
end main

