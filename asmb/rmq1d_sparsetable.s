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

start initA 0:
.entry:
  r4 = load 4 20480 0 
  r3 = mul 0 1 64 
  br .while.cond 
.while.cond:
  r2 = mul r3 1 32 
  r1 = shl 1 r2 32 
  r1 = icmp sgt r1 r4 32 
  br r1 .while.end .while.body 
.while.body:
  r1 = add r3 1 64 
  r3 = mul r1 1 64 
  br .while.cond 
.while.end:
  store 4 r2 20480 8 
  r1 = mul r3 4294967296 64 
  r1 = sdiv r1 536870912 64 
  r2 = call malloc_upto_8 r1 
  r1 = add 20480 16 64 
  store 8 r2 r1 0 
  r1 = add 20480 24 64 
  r3 = load 8 r1 0 
  r1 = mul r2 1 64 
  store 8 r3 r1 0 
  r1 = load 4 20480 0 
  r2 = mul r1 1 32 
  r8 = mul 1 1 64 
  br .while.cond5 
.while.cond5:
  r1 = mul r8 1 32 
  r7 = shl 1 r1 32 
  r1 = icmp sgt r7 r2 32 
  br r1 .while.end36 .while.body12 
.while.body12:
  r1 = add r2 1 32 
  r1 = sub r1 r7 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 4 64 
  r3 = call malloc_upto_8 r1 
  r2 = load 8 20480 16 
  r1 = mul r8 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r6 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r2 = load 4 20480 0 
  r1 = sub r2 r7 32 
  r1 = icmp sgt r6 r1 32 
  br r1 .for.cond.cleanup .for.body 
.for.cond.cleanup:
  r1 = add r8 1 64 
  r8 = mul r1 1 64 
  br .while.cond5 
.for.body:
  r1 = load 8 20480 16 
  r2 = add r8 18446744073709551615 64 
  r3 = mul r1 1 64 
  r1 = mul r2 8 64 
  r1 = add r3 r1 64 
  r4 = load 8 r1 0 
  r5 = mul r6 1 64 
  r2 = mul r4 1 64 
  r1 = mul r5 4 64 
  r1 = add r2 r1 64 
  r3 = load 4 r1 0 
  r1 = sdiv r7 2 32 
  r1 = add r6 r1 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r4 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r3 = call min r3 r1 
  r2 = load 8 20480 16 
  r1 = mul r8 8 64 
  r1 = add r2 r1 64 
  r2 = load 8 r1 0 
  r1 = mul r5 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r1 = add r6 1 32 
  r6 = mul r1 1 32 
  br .for.cond 
.while.end36:
  ret 0 
end initA

start count_leading_zeros 1:
.entry:
  r2 = mul 0 1 32 
  r3 = mul 31 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp sgt r3 4294967295 32 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  br .cleanup 
.for.body:
  r1 = shl 1 r3 32 
  r1 = and r1 arg1 32 
  r1 = icmp eq r1 0 32 
  br r1 .if.end .if.then 
.if.then:
  br .cleanup 
.if.end:
  r2 = add r2 1 32 
  r1 = add r3 4294967295 32 
  r3 = mul r1 1 32 
  br .for.cond 
.cleanup:
  ret r2 
end count_leading_zeros

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 8 
  r1 = malloc 8 
  r1 = malloc 8 
  r1 = malloc 8 
  r2 = call read 
  r1 = mul r2 1 32 
  store 4 r1 20480 0 
  r1 = mul r2 4294967296 64 
  r1 = sdiv r1 1073741824 64 
  r2 = call malloc_upto_8 r1 
  r1 = add 20480 24 64 
  store 8 r2 r1 0 
  r4 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = load 4 20480 0 
  r1 = icmp slt r4 r1 32 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  call initA 
  r1 = call read 
  r2 = mul r1 1 32 
  br .while.cond 
.for.body:
  r1 = call read 
  r3 = mul r1 1 32 
  r2 = load 8 20480 24 
  r1 = mul r4 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r1 = add r4 1 32 
  r4 = mul r1 1 32 
  br .for.cond 
.while.cond:
  r1 = icmp eq r2 0 32 
  br r1 .while.end .while.body 
.while.body:
  r7 = add r2 4294967295 32 
  r3 = call read 
  r1 = mul r3 1 32 
  r2 = call read 
  r6 = mul r2 1 32 
  r1 = sub 1 r1 32 
  r1 = add r1 r6 32 
  r5 = call count_leading_zeros r1 
  r2 = load 8 20480 16 
  r1 = sub 31 r5 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r4 = load 8 r1 0 
  r1 = mul r3 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r4 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r3 = load 4 r1 0 
  r2 = lshr 2147483648 r5 32 
  r1 = add r6 1 32 
  r1 = sub r1 r2 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r4 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r1 = call min r3 r1 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  r2 = mul r7 1 32 
  br .while.cond 
.while.end:
  ret 0 
end main

