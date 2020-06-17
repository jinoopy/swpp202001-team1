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
  r1 = select r1 arg1 arg2 
  ret r1 
end min

start min_element 2:
.entry:
  r2 = icmp eq arg1 arg2 64 
  r1 = mul arg1 1 64 
  r3 = mul arg1 1 64 
  r4 = mul arg1 1 64 
  br r2 .while.end .while.body 
.while.body:
  r2 = load 4 r4 0 
  r1 = load 4 r3 0 
  r1 = icmp slt r2 r1 32 
  r3 = select r1 r4 r3 
  r2 = mul r4 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = icmp eq r1 arg2 64 
  r4 = mul r1 1 64 
  r1 = mul r3 1 64 
  br r2 .while.end .while.body 
.while.end:
  ret r1 
end min_element

start min_at_row 3:
.entry:
  r2 = load 8 20480 0 
  r1 = mul arg1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
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
  r5 = add r2 r1 64 
  r2 = mul r5 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = icmp eq r3 r1 64 
  r1 = mul r3 1 64 
  r4 = mul r3 1 64 
  br r2 .min_element.exit .while.body.i 
.while.body.i:
  r2 = load 4 r4 0 
  r1 = load 4 r3 0 
  r1 = icmp slt r2 r1 32 
  r3 = select r1 r4 r3 
  r2 = mul r4 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = icmp eq r4 r5 64 
  r4 = mul r1 1 64 
  r1 = mul r3 1 64 
  br r2 .min_element.exit .while.body.i 
.min_element.exit:
  r1 = load 4 r1 0 
  ret r1 
end min_at_row

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 8 
  r4 = call read 
  r3 = mul r4 1 32 
  r9 = call read 
  r1 = mul r4 4294967296 64 
  r1 = sdiv r1 536870912 64 
  r2 = malloc r1 
  r1 = add 20480 0 64 
  store 8 r2 r1 0 
  r1 = icmp sgt r3 0 32 
  br r1 .for.body.lr.ph .for.cond.cleanup 
.for.body.lr.ph:
  r1 = mul r9 4294967296 64 
  r1 = sdiv r1 1073741824 64 
  r1 = add r1 7 64 
  r8 = and r1 18446744073709551608 64 
  r1 = mul r9 1 32 
  r3 = icmp sgt r1 0 32 
  r7 = urem r4 4294967296 64 
  r1 = mul r2 1 64 
  r6 = mul 0 1 64 
  r4 = mul 0 1 64 
  br r3 .for.body.us .for.body 
.for.body.us:
  r3 = malloc r8 
  r1 = mul r6 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r5 = urem r9 4294967296 64 
  r4 = mul 0 1 64 
  br .for.body13.us 
.for.body13.us:
  r1 = call read 
  r3 = mul r1 1 32 
  r2 = load 8 20480 0 
  r1 = mul r6 8 64 
  r1 = add r2 r1 64 
  r2 = load 8 r1 0 
  r1 = mul r4 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r5 64 
  r4 = mul r1 1 64 
  br r2 .for.cond.cleanup12.us .for.body13.us 
.for.cond.cleanup12.us:
  r2 = add r6 1 64 
  r1 = icmp eq r2 r7 64 
  br r1 .for.cond.cleanup .for.cond.cleanup12.us.for.body.us_crit_edge 
.for.cond.cleanup12.us.for.body.us_crit_edge:
  r1 = load 8 20480 0 
  r6 = mul r2 1 64 
  r2 = mul r1 1 64 
  br .for.body.us 
.for.cond.cleanup:
  r1 = call read 
  r2 = icmp eq r1 0 32 
  r12 = mul r1 1 32 
  br r2 .while.end .while.body 
.for.body:
  r3 = malloc r8 
  r2 = mul r1 1 64 
  r1 = mul r4 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r2 = add r4 1 64 
  r1 = icmp eq r2 r7 64 
  br r1 .for.cond.cleanup .for.body.for.body_crit_edge 
.for.body.for.body_crit_edge:
  r1 = load 8 20480 0 
  r4 = mul r2 1 64 
  br .for.body 
.while.body:
  r11 = call read 
  r8 = call read 
  r3 = call read 
  r5 = call read 
  r13 = load 8 20480 0 
  r1 = mul r11 4294967296 64 
  r7 = sdiv r1 4294967296 64 
  r2 = mul r13 1 64 
  r1 = mul r7 8 64 
  r1 = add r2 r1 64 
  r4 = load 8 r1 0 
  r1 = mul r3 4294967296 64 
  r10 = sdiv r1 4294967296 64 
  r2 = mul r4 1 64 
  r1 = mul r10 4 64 
  r3 = add r2 r1 64 
  r1 = mul r5 4294967296 64 
  r9 = sdiv r1 4294967296 64 
  r2 = mul r4 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = mul r1 1 64 
  r1 = mul r9 4 64 
  r6 = add r2 r1 64 
  r1 = icmp eq r3 r6 64 
  r4 = mul r3 1 64 
  r5 = mul r3 1 64 
  br r1 .min_at_row.exit .while.body.i.i 
.while.body.i.i:
  r2 = load 4 r5 0 
  r1 = load 4 r3 0 
  r1 = icmp slt r2 r1 32 
  r3 = select r1 r5 r3 
  r2 = mul r5 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = icmp eq r1 r6 64 
  r4 = mul r3 1 64 
  r5 = mul r1 1 64 
  br r2 .min_at_row.exit .while.body.i.i 
.min_at_row.exit:
  r3 = mul r11 1 32 
  r1 = mul r8 1 32 
  r2 = load 4 r4 0 
  r1 = icmp slt r3 r1 32 
  r3 = mul r2 1 32 
  br r1 .for.body39.lr.ph .for.cond.cleanup38 
.for.body39.lr.ph:
  r1 = mul r8 4294967296 64 
  r8 = sdiv r1 4294967296 64 
  r1 = mul r7 1 64 
  r7 = mul r2 1 32 
  br .for.body39 
.for.cond.cleanup38:
  r2 = add r12 4294967295 32 
  r1 = mul r3 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  r1 = icmp eq r2 0 32 
  r12 = mul r2 1 32 
  br r1 .while.end .while.body 
.for.body39:
  r6 = add r1 1 64 
  r2 = mul r13 1 64 
  r1 = mul r6 8 64 
  r1 = add r2 r1 64 
  r4 = load 8 r1 0 
  r2 = mul r4 1 64 
  r1 = mul r10 4 64 
  r3 = add r2 r1 64 
  r2 = mul r4 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = mul r1 1 64 
  r1 = mul r9 4 64 
  r5 = add r2 r1 64 
  r2 = icmp eq r3 r5 64 
  r1 = mul r3 1 64 
  r4 = mul r3 1 64 
  br r2 .min_at_row.exit22 .while.body.i.i17 
.while.body.i.i17:
  r2 = load 4 r4 0 
  r1 = load 4 r3 0 
  r1 = icmp slt r2 r1 32 
  r3 = select r1 r4 r3 
  r2 = mul r4 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = icmp eq r1 r5 64 
  r4 = mul r1 1 64 
  r1 = mul r3 1 64 
  br r2 .min_at_row.exit22 .while.body.i.i17 
.min_at_row.exit22:
  r2 = load 4 r1 0 
  r1 = icmp slt r7 r2 32 
  r1 = select r1 r7 r2 
  r2 = icmp eq r6 r8 64 
  r3 = mul r1 1 32 
  r7 = mul r1 1 32 
  r1 = mul r6 1 64 
  br r2 .for.cond.cleanup38 .for.body39 
.while.end:
  ret 0 
end main

