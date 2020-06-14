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
  br r2 .while.end .while.body.preheader 
.while.body.preheader:
  r2 = mul arg1 1 64 
  r1 = mul arg2 1 64 
  r1 = add r1 18446744073709551612 64 
  r1 = sub r1 r2 64 
  r7 = sdiv r1 4 64 
  r1 = add r7 1 64 
  r1 = urem r1 4 64 
  r2 = icmp eq r1 0 64 
  r3 = mul arg1 1 64 
  r5 = mul r1 1 64 
  r6 = mul arg1 1 64 
  r8 = mul arg1 1 64 
  r1 = mul arg1 1 64 
  br r2 .while.body.prol.loopexit .while.body.prol 
.while.body.prol:
  r2 = load 4 r6 0 
  r1 = load 4 r3 0 
  r1 = icmp slt r2 r1 32 
  r3 = select r1 r6 r3 
  r1 = mul r6 1 64 
  r2 = add r1 4 64 
  r1 = add r5 18446744073709551615 64 
  r4 = icmp eq r1 0 64 
  r5 = mul r1 1 64 
  r6 = mul r2 1 64 
  r8 = mul r3 1 64 
  r9 = mul r3 1 64 
  r1 = mul r2 1 64 
  br r4 .while.body.prol.loopexit .while.body.prol 
.while.body.prol.loopexit:
  r2 = icmp ult r7 3 64 
  r4 = mul r8 1 64 
  r5 = mul r1 1 64 
  r1 = mul r9 1 64 
  br r2 .while.end .while.body 
.while.body:
  r2 = load 4 r5 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r5 r4 
  r1 = mul r5 1 64 
  r3 = add r1 4 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r3 = add r1 8 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r3 = add r1 12 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r2 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r1 = add r1 16 64 
  r3 = icmp eq r1 arg2 64 
  r4 = mul r2 1 64 
  r5 = mul r1 1 64 
  r1 = mul r2 1 64 
  br r3 .while.end .while.body 
.while.end:
  ret r1 
end min_element

start min_at_row 3:
.entry:
  r1 = add 20480 0 64 
  r2 = load 8 r1 0 
  r1 = mul arg1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r6 = load 8 r1 0 
  r5 = mul arg2 4294967296 64 
  r5 = sdiv r5 4294967296 64 
  r2 = mul r6 1 64 
  r1 = mul r5 4 64 
  r4 = add r1 r2 64 
  r3 = mul arg3 4294967296 64 
  r3 = sdiv r3 4294967296 64 
  r2 = mul r6 1 64 
  r1 = mul r3 4 64 
  r1 = add r1 r2 64 
  r10 = mul r1 1 64 
  r1 = add r1 4 64 
  r2 = icmp eq r4 r1 64 
  r1 = mul r4 1 64 
  br r2 .min_element.exit .while.body.i.preheader 
.while.body.i.preheader:
  r9 = sub r3 r5 64 
  r1 = add r9 1 64 
  r1 = urem r1 4 64 
  r2 = icmp eq r1 0 64 
  r3 = mul r4 1 64 
  r6 = mul r1 1 64 
  r7 = mul r4 1 64 
  r8 = mul r4 1 64 
  r1 = mul r4 1 64 
  br r2 .while.body.i.prol.loopexit .while.body.i.prol 
.while.body.i.prol:
  r2 = load 4 r7 0 
  r1 = load 4 r8 0 
  r1 = icmp slt r2 r1 32 
  r3 = select r1 r7 r8 
  r1 = mul r7 1 64 
  r2 = add r1 4 64 
  r1 = add r6 18446744073709551615 64 
  r4 = icmp eq r1 0 64 
  r5 = mul r3 1 64 
  r6 = mul r1 1 64 
  r7 = mul r2 1 64 
  r8 = mul r3 1 64 
  r1 = mul r2 1 64 
  br r4 .while.body.i.prol.loopexit .while.body.i.prol 
.while.body.i.prol.loopexit:
  r2 = icmp ult r9 3 64 
  r4 = mul r3 1 64 
  r11 = mul r1 1 64 
  r1 = mul r5 1 64 
  r5 = mul r1 1 64 
  r1 = mul r5 1 64 
  r1 = mul r1 1 64 
  r11 = mul r5 1 64 
  r5 = mul r1 1 64 
  r1 = mul r5 1 64 
  br r2 .min_element.exit .while.body.i 
.while.body.i:
  r2 = load 4 r5 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r5 r4 
  r1 = mul r5 1 64 
  r3 = add r1 4 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r3 = add r1 8 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r3 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r4 = add r1 12 64 
  r2 = load 4 r4 0 
  r1 = load 4 r3 0 
  r1 = icmp slt r2 r1 32 
  r2 = select r1 r4 r3 
  r1 = mul r5 1 64 
  r1 = add r1 16 64 
  r3 = icmp eq r4 r10 64 
  r4 = mul r2 1 64 
  r5 = mul r1 1 64 
  r1 = mul r2 1 64 
  br r3 .min_element.exit .while.body.i 
.min_element.exit:
  r1 = load 4 r1 0 
  ret r1 
end min_at_row

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 8 
  ; Init stack pointer
  sp = sub sp 24 64 
  r4 = call read 
  r3 = mul r4 1 32 
  r9 = call read 
  r1 = sdiv r4 536870912 64 
  r2 = malloc r1 
  r1 = add 20480 0 64 
  store 8 r2 r1 0 
  r1 = icmp sgt r3 0 32 
  r3 = mul r2 1 64 
  br r1 .for.body.lr.ph .for.cond.cleanup 
.for.body.lr.ph:
  r2 = mul r9 1 32 
  r1 = sdiv r9 1073741824 64 
  r1 = add r1 7 64 
  r8 = and r1 18446744073709551608 64 
  r1 = icmp sgt r2 0 32 
  r7 = urem r4 4294967296 64 
  r2 = mul r3 1 64 
  r5 = mul r3 1 64 
  r6 = mul 0 1 64 
  r4 = mul 0 1 64 
  br r1 .for.body.us .for.body 
.for.body.us:
  r3 = malloc r8 
  r2 = mul r5 1 64 
  r1 = mul r6 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r4 = urem r9 4294967296 64 
  r5 = mul 0 1 64 
  br .for.body13.us 
.for.body13.us:
  r1 = call read 
  r3 = mul r1 1 32 
  r1 = add 20480 0 64 
  r2 = load 8 r1 0 
  r1 = mul r6 8 64 
  r1 = add r2 r1 64 
  r2 = load 8 r1 0 
  r1 = mul r5 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r1 = add r5 1 64 
  r2 = icmp eq r1 r4 64 
  r5 = mul r1 1 64 
  br r2 .for.cond.cleanup12.us .for.body13.us 
.for.cond.cleanup12.us:
  r2 = add r6 1 64 
  r1 = icmp eq r2 r7 64 
  br r1 .for.cond.cleanup .for.cond.cleanup12.us.for.body.us_crit_edge 
.for.cond.cleanup12.us.for.body.us_crit_edge:
  r1 = load 8 20480 0 
  r5 = mul r1 1 64 
  r6 = mul r2 1 64 
  br .for.body.us 
.for.cond.cleanup:
  r1 = call read 
  r2 = mul r1 1 32 
  r1 = icmp eq r2 0 32 
  r1 = mul r2 1 32 
  br r1 .while.end .while.body 
.for.body:
  r3 = malloc r8 
  r1 = mul r4 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r2 = add r4 1 64 
  r1 = icmp eq r2 r7 64 
  br r1 .for.cond.cleanup .for.body.for.body_crit_edge 
.for.body.for.body_crit_edge:
  r1 = load 8 20480 0 
  r4 = mul r2 1 64 
  r2 = mul r1 1 64 
  br .for.body 
.while.body:
  store 8 r1 sp 0 
  r11 = call read 
  r15 = call read 
  r14 = call read 
  r13 = call read 
  r1 = load 8 20480 0 
  store 8 r1 sp 8 
  r1 = load 8 sp 8 
  r2 = mul r1 1 64 
  r1 = mul r11 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r2 = mul r3 1 64 
  r1 = mul r14 4 64 
  r4 = add r1 r2 64 
  r1 = mul r3 1 64 
  r2 = add r1 4 64 
  r1 = mul r13 4 64 
  r10 = add r2 r1 64 
  r1 = icmp eq r4 r10 64 
  r6 = mul r4 1 64 
  br r1 .min_at_row.exit .while.body.i.i.preheader 
.while.body.i.i.preheader:
  r1 = sub r13 r14 64 
  r1 = mul r1 4 64 
  r7 = sdiv r1 4 64 
  r1 = add r7 1 64 
  r1 = urem r1 4 64 
  r2 = icmp eq r1 0 64 
  r3 = mul r4 1 64 
  r5 = mul r1 1 64 
  r6 = mul r4 1 64 
  r8 = mul r4 1 64 
  r1 = mul r4 1 64 
  br r2 .while.body.i.i.prol.loopexit .while.body.i.i.prol 
.while.body.i.i.prol:
  r2 = load 4 r6 0 
  r1 = load 4 r3 0 
  r1 = icmp slt r2 r1 32 
  r3 = select r1 r6 r3 
  r1 = mul r6 1 64 
  r2 = add r1 4 64 
  r1 = add r5 18446744073709551615 64 
  r4 = icmp eq r1 0 64 
  r5 = mul r1 1 64 
  r6 = mul r2 1 64 
  r8 = mul r3 1 64 
  r9 = mul r3 1 64 
  r1 = mul r2 1 64 
  br r4 .while.body.i.i.prol.loopexit .while.body.i.i.prol 
.while.body.i.i.prol.loopexit:
  r2 = icmp ult r7 3 64 
  r4 = mul r8 1 64 
  r5 = mul r1 1 64 
  r6 = mul r9 1 64 
  br r2 .min_at_row.exit .while.body.i.i 
.while.body.i.i:
  r2 = load 4 r5 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r5 r4 
  r1 = mul r5 1 64 
  r3 = add r1 4 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r3 = add r1 8 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r3 = add r1 12 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r2 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r1 = add r1 16 64 
  r3 = icmp eq r1 r10 64 
  r4 = mul r2 1 64 
  r5 = mul r1 1 64 
  r6 = mul r2 1 64 
  br r3 .min_at_row.exit .while.body.i.i 
.min_at_row.exit:
  r2 = mul r11 1 32 
  r1 = mul r15 1 32 
  r3 = load 4 r6 0 
  r1 = icmp slt r2 r1 32 
  r4 = mul r3 1 32 
  br r1 .for.body39.lr.ph .for.cond.cleanup38 
.for.body39.lr.ph:
  r1 = sub r13 r14 64 
  r1 = mul r1 4 64 
  r12 = sdiv r1 4 64 
  r10 = add r12 1 64 
  r16 = mul r3 1 32 
  r3 = mul r11 1 64 
  r11 = mul r3 1 32 
  r3 = mul r11 1 64 
  r1 = mul r16 1 32 
  r16 = mul r11 1 64 
  r11 = mul r3 1 32 
  r1 = mul r16 1 64 
  br .for.body39 
.for.cond.cleanup38:
  r1 = load 8 sp 0 
  r2 = add r1 4294967295 32 
  r1 = mul r4 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  r1 = icmp eq r2 0 32 
  r1 = mul r2 1 32 
  br r1 .while.end .while.body 
.for.body39:
  r9 = add r3 1 64 
  r1 = load 8 sp 8 
  r2 = mul r1 1 64 
  r1 = mul r9 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul r2 1 64 
  r3 = mul r14 4 64 
  r3 = add r3 r1 64 
  r1 = mul r2 1 64 
  r2 = add r1 4 64 
  r1 = mul r13 4 64 
  r8 = add r2 r1 64 
  r2 = icmp eq r3 r8 64 
  r1 = mul r3 1 64 
  br r2 .min_at_row.exit22 .while.body.i.i17.preheader 
.while.body.i.i17.preheader:
  r1 = urem r10 4 64 
  r4 = icmp eq r1 0 64 
  r2 = mul r3 1 64 
  r6 = mul r1 1 64 
  r7 = mul r3 1 64 
  r1 = mul r3 1 64 
  br r4 .while.body.i.i17.prol.loopexit .while.body.i.i17.prol 
.while.body.i.i17.prol:
  r1 = mul r2 1 64 
  store 8 r1 sp 16 
  r2 = load 4 r7 0 
  r1 = load 8 sp 16 
  r1 = load 4 r1 0 
  r2 = icmp slt r2 r1 32 
  r1 = load 8 sp 16 
  r3 = select r2 r7 r1 
  r1 = mul r7 1 64 
  r2 = add r1 4 64 
  r1 = add r6 18446744073709551615 64 
  r4 = icmp eq r1 0 64 
  r5 = mul r3 1 64 
  r6 = mul r1 1 64 
  r7 = mul r2 1 64 
  r1 = mul r2 1 64 
  r2 = mul r3 1 64 
  br r4 .while.body.i.i17.prol.loopexit .while.body.i.i17.prol 
.while.body.i.i17.prol.loopexit:
  r2 = icmp ult r12 3 64 
  r4 = mul r3 1 64 
  r16 = mul r1 1 64 
  r1 = mul r5 1 64 
  r5 = mul r1 1 64 
  r1 = mul r5 1 64 
  r1 = mul r1 1 64 
  r16 = mul r5 1 64 
  r5 = mul r1 1 64 
  r1 = mul r5 1 64 
  br r2 .min_at_row.exit22 .while.body.i.i17 
.while.body.i.i17:
  r2 = load 4 r5 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r5 r4 
  r1 = mul r5 1 64 
  r3 = add r1 4 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r3 = add r1 8 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r4 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r3 = add r1 12 64 
  r2 = load 4 r3 0 
  r1 = load 4 r4 0 
  r1 = icmp slt r2 r1 32 
  r2 = select r1 r3 r4 
  r1 = mul r5 1 64 
  r1 = add r1 16 64 
  r3 = icmp eq r1 r8 64 
  r4 = mul r2 1 64 
  r5 = mul r1 1 64 
  r1 = mul r2 1 64 
  br r3 .min_at_row.exit22 .while.body.i.i17 
.min_at_row.exit22:
  r2 = load 4 r1 0 
  r1 = icmp slt r11 r2 32 
  r1 = select r1 r11 r2 
  r2 = icmp eq r9 r15 64 
  r3 = mul r9 1 64 
  r4 = mul r1 1 32 
  r11 = mul r1 1 32 
  br r2 .for.cond.cleanup38 .for.body39 
.while.end:
  sp = add sp 24 64 
  ret 0 
end main

