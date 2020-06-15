start main 0:
.entry:
  ; Init global variables
  r1 = malloc 8 
  r1 = malloc 8 
  ; Init stack pointer
  sp = sub sp 8 64 
  r1 = call read 
  r3 = mul r1 1 32 
  store 4 r3 sp 4 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 1073741824 64 
  r1 = add r1 7 64 
  r1 = and r1 18446744073709551608 64 
  r2 = malloc r1 
  r1 = add 20480 8 64 
  store 8 r2 r1 0 
  r1 = icmp sgt r3 0 32 
  r4 = mul 0 1 64 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  r2 = add sp 4 64 
  r1 = add sp 0 64 
  call initA.3 r2 r1 
  r1 = call read 
  r2 = icmp eq r1 0 32 
  br r2 .while.end .while.body 
.for.body:
  r1 = call read 
  r3 = mul r1 1 32 
  r1 = add 20480 8 64 
  r2 = load 8 r1 0 
  r1 = mul r4 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r2 = add r4 1 64 
  r1 = load 4 sp 4 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = icmp slt r2 r1 64 
  r4 = mul r2 1 64 
  br r1 .for.body .for.cond.cleanup 
.while.body:
  r8 = add r1 4294967295 32 
  r7 = call read 
  r2 = mul r7 1 32 
  r1 = call read 
  r6 = add r1 1 32 
  r4 = sub r6 r2 32 
  r10 = mul 31 1 32 
  r9 = mul 0 1 32 
  br .for.body.i 
.for.body.i:
  r1 = shl 1 r10 32 
  r1 = and r1 r4 32 
  r1 = icmp eq r1 0 32 
  r5 = mul r9 1 32 
  br r1 .if.end.i .count_leading_zeros.4.exit 
.if.end.i:
  r2 = or r9 1 32 
  r1 = add r10 4294967295 32 
  r1 = shl 1 r1 32 
  r1 = and r1 r4 32 
  r1 = icmp eq r1 0 32 
  r5 = mul r2 1 32 
  br r1 .if.end.i.1 .count_leading_zeros.4.exit 
.count_leading_zeros.4.exit:
  r1 = add 20480 0 64 
  r2 = load 8 r1 0 
  r1 = sub 31 r5 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r4 = load 8 r1 0 
  r1 = mul r7 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r4 1 64 
  r1 = mul r1 4 64 
  r1 = add r1 r2 64 
  r3 = load 4 r1 0 
  r1 = lshr 2147483648 r5 32 
  r1 = sub r6 r1 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r4 1 64 
  r1 = mul r1 4 64 
  r1 = add r1 r2 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r3 r2 32 
  r1 = select r1 r3 r2 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  r2 = icmp eq r8 0 32 
  r1 = mul r8 1 32 
  br r2 .while.end .while.body 
.while.end:
  sp = add sp 8 64 
  ret 0 
.if.end.i.1:
  r2 = or r9 2 32 
  r1 = add r10 4294967294 32 
  r1 = shl 1 r1 32 
  r1 = and r1 r4 32 
  r1 = icmp eq r1 0 32 
  r5 = mul r2 1 32 
  br r1 .if.end.i.2 .count_leading_zeros.4.exit 
.if.end.i.2:
  r2 = or r9 3 32 
  r1 = add r10 4294967293 32 
  r1 = shl 1 r1 32 
  r1 = and r1 r4 32 
  r1 = icmp eq r1 0 32 
  r5 = mul r2 1 32 
  br r1 .if.end.i.3 .count_leading_zeros.4.exit 
.if.end.i.3:
  r2 = add r9 4 32 
  r1 = add r10 4294967292 32 
  r3 = icmp eq r2 32 32 
  r9 = mul r2 1 32 
  r10 = mul r1 1 32 
  r5 = mul 32 1 32 
  br r3 .count_leading_zeros.4.exit .for.body.i 
end main

start malloc_upto_8.1 3:
.entry:
  r1 = add arg1 7 64 
  r1 = and r1 18446744073709551608 64 
  r1 = malloc r1 
  ret r1 
end malloc_upto_8.1

start min.2 4:
.entry:
  r1 = icmp slt arg1 arg2 32 
  r1 = select r1 arg1 arg2 
  ret r1 
end min.2

start initA.3 2:
.entry:
  r4 = load 4 arg1 0 
  r3 = mul 0 1 64 
  br .while.cond 
.while.cond:
  r5 = mul r3 1 32 
  r1 = shl 1 r5 32 
  r2 = icmp sgt r1 r4 32 
  r1 = add r3 1 64 
  r3 = mul r1 1 64 
  br r2 .while.end .while.cond 
.while.end:
  store 4 r5 arg2 0 
  r1 = mul r3 4294967296 64 
  r1 = sdiv r1 536870912 64 
  r4 = malloc r1 
  r1 = add 20480 0 64 
  store 8 r4 r1 0 
  r1 = add 20480 8 64 
  r2 = load 8 r1 0 
  r1 = mul r4 1 64 
  store 8 r2 r1 0 
  r2 = load 4 arg1 0 
  r3 = icmp slt r2 2 32 
  r1 = mul r4 1 64 
  r4 = mul r1 1 64 
  r9 = mul 2 1 32 
  r8 = mul 1 1 64 
  br r3 .while.end36 .while.body12 
.while.body12:
  r1 = sub 1 r9 32 
  r1 = add r1 r2 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 4 64 
  r1 = add r1 7 64 
  r1 = and r1 18446744073709551608 64 
  r3 = malloc r1 
  r2 = mul r4 1 64 
  r1 = mul r8 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = load 4 arg1 0 
  r2 = icmp slt r1 r9 32 
  r4 = mul r1 1 32 
  br r2 .for.cond.cleanup .for.body.lr.ph 
.for.body.lr.ph:
  r6 = sdiv r9 2 32 
  r6 = mul r6 4294967296 64 
  r6 = sdiv r6 4294967296 64 
  r5 = mul 0 1 64 
  br .for.body 
.for.cond.cleanup:
  r3 = add r8 1 64 
  r1 = mul r3 1 32 
  r2 = shl 1 r1 32 
  r1 = icmp sgt r2 r4 32 
  br r1 .while.end36 .for.cond.cleanup.while.body12_crit_edge 
.for.cond.cleanup.while.body12_crit_edge:
  r1 = load 8 20480 0 
  r8 = mul r3 1 64 
  r9 = mul r2 1 32 
  r2 = mul r4 1 32 
  r4 = mul r1 1 64 
  br .while.body12 
.for.body:
  r7 = load 8 20480 0 
  r2 = mul r7 1 64 
  r1 = mul r8 8 64 
  r1 = add r1 18446744073709551608 64 
  r1 = add r1 r2 64 
  r4 = load 8 r1 0 
  r2 = mul r4 1 64 
  r1 = mul r5 4 64 
  r1 = add r1 r2 64 
  r3 = load 4 r1 0 
  r1 = add r5 r6 64 
  r2 = mul r4 1 64 
  r1 = mul r1 4 64 
  r1 = add r1 r2 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r3 r2 32 
  r3 = select r1 r3 r2 
  r2 = mul r7 1 64 
  r1 = mul r8 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul r5 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r2 = add r5 1 64 
  r3 = load 4 arg1 0 
  r1 = sub r3 r9 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = icmp slt r5 r1 64 
  r4 = mul r3 1 32 
  r5 = mul r2 1 64 
  br r1 .for.body .for.cond.cleanup 
.while.end36:
  ret 0 
end initA.3

start count_leading_zeros.4 3:
.entry:
  r5 = mul 31 1 32 
  r4 = mul 0 1 32 
  br .for.body 
.for.body:
  r1 = shl 1 r5 32 
  r1 = and r1 arg1 32 
  r1 = icmp eq r1 0 32 
  r2 = mul r4 1 32 
  br r1 .if.end .cleanup 
.if.end:
  r2 = or r4 1 32 
  r1 = add r5 4294967295 32 
  r1 = shl 1 r1 32 
  r1 = and r1 arg1 32 
  r1 = icmp eq r1 0 32 
  br r1 .if.end.1 .cleanup 
.cleanup:
  ret r2 
.if.end.1:
  r2 = or r4 2 32 
  r1 = add r5 4294967294 32 
  r1 = shl 1 r1 32 
  r1 = and r1 arg1 32 
  r1 = icmp eq r1 0 32 
  br r1 .if.end.2 .cleanup 
.if.end.2:
  r2 = or r4 3 32 
  r1 = add r5 4294967293 32 
  r1 = shl 1 r1 32 
  r1 = and r1 arg1 32 
  r1 = icmp eq r1 0 32 
  br r1 .if.end.3 .cleanup 
.if.end.3:
  r2 = add r4 4 32 
  r1 = add r5 4294967292 32 
  r3 = icmp eq r2 32 32 
  r4 = mul r2 1 32 
  r5 = mul r1 1 32 
  r2 = mul 32 1 32 
  br r3 .cleanup .for.body 
end count_leading_zeros.4

