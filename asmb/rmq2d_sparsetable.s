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

start count_leading_zeros 1:
.entry:
  r5 = mul 31 1 32 
  r4 = mul 0 1 32 
  br .for.body 
.for.body:
  r1 = shl 1 r5 32 
  r1 = and r1 arg1 32 
  r2 = icmp eq r1 0 32 
  r1 = mul r4 1 32 
  br r2 .if.end .cleanup 
.if.end:
  r2 = add r4 1 32 
  r1 = add r5 4294967295 32 
  r3 = icmp eq r2 32 32 
  r4 = mul r2 1 32 
  r5 = mul r1 1 32 
  r1 = mul 32 1 32 
  br r3 .cleanup .for.body 
.cleanup:
  ret r1 
end count_leading_zeros

start floorlog2 1:
.entry:
  r5 = mul 31 1 32 
  r4 = mul 0 1 32 
  br .for.body.i 
.for.body.i:
  r1 = shl 1 r5 32 
  r1 = and r1 arg1 32 
  r2 = icmp eq r1 0 32 
  r1 = mul r4 1 32 
  br r2 .if.end.i .count_leading_zeros.exit 
.if.end.i:
  r2 = add r4 1 32 
  r1 = add r5 4294967295 32 
  r3 = icmp eq r2 32 32 
  r4 = mul r2 1 32 
  r5 = mul r1 1 32 
  r1 = mul 32 1 32 
  br r3 .count_leading_zeros.exit .for.body.i 
.count_leading_zeros.exit:
  r1 = sub 31 r1 32 
  ret r1 
end floorlog2

start input 2:
.entry:
  r2 = load 8 20480 0 
  r1 = load 4 20480 8 
  r1 = mul r1 arg1 32 
  r1 = add r1 arg2 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  ret r1 
end input

start width 1:
.entry:
  r2 = load 4 20480 8 
  r1 = shl 4294967295 arg1 32 
  r1 = add r1 1 32 
  r1 = add r1 r2 32 
  ret r1 
end width

start height 1:
.entry:
  r2 = load 4 20480 16 
  r1 = shl 4294967295 arg1 32 
  r1 = add r1 1 32 
  r1 = add r1 r2 32 
  ret r1 
end height

start A 2:
.entry:
  r2 = load 8 20480 24 
  r1 = load 4 20480 32 
  r1 = add r1 1 32 
  r1 = mul r1 arg1 32 
  r1 = add r1 arg2 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  ret r1 
end A

start P 4:
.entry:
  r2 = load 8 20480 24 
  r1 = load 4 20480 32 
  r1 = add r1 1 32 
  r1 = mul r1 arg1 32 
  r1 = add r1 arg2 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r2 = load 4 20480 8 
  r1 = shl 4294967295 arg2 32 
  r1 = add r1 1 32 
  r1 = add r1 r2 32 
  r1 = mul r1 arg3 32 
  r1 = add r1 arg4 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r3 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  ret r1 
end P

start preprocess 0:
.entry:
  ; Init stack pointer
  sp = sub sp 40 64 
  r6 = load 4 20480 16 
  r5 = mul 31 1 32 
  r4 = mul 0 1 32 
  br .for.body.i.i 
.for.body.i.i:
  r1 = shl 1 r5 32 
  r1 = and r1 r6 32 
  r2 = icmp eq r1 0 32 
  r1 = mul r4 1 32 
  br r2 .if.end.i.i .floorlog2.exit 
.if.end.i.i:
  r2 = add r4 1 32 
  r1 = add r5 4294967295 32 
  r3 = icmp eq r2 32 32 
  r4 = mul r2 1 32 
  r5 = mul r1 1 32 
  r1 = mul 32 1 32 
  br r3 .floorlog2.exit .for.body.i.i 
.floorlog2.exit:
  r7 = sub 31 r1 32 
  store 4 r7 20480 40 
  r5 = load 4 20480 8 
  r4 = mul 31 1 32 
  r2 = mul 0 1 32 
  br .for.body.i.i47 
.for.body.i.i47:
  r1 = shl 1 r4 32 
  r1 = and r1 r5 32 
  r1 = icmp eq r1 0 32 
  r6 = mul r2 1 32 
  br r1 .if.end.i.i51 .floorlog2.exit54 
.if.end.i.i51:
  r2 = add r2 1 32 
  r1 = add r4 4294967295 32 
  r3 = icmp eq r2 32 32 
  r4 = mul r1 1 32 
  r6 = mul 32 1 32 
  br r3 .floorlog2.exit54 .for.body.i.i47 
.floorlog2.exit54:
  r4 = sub 31 r6 32 
  store 4 r4 20480 32 
  r2 = add r7 1 32 
  r2 = mul r2 4294967296 64 
  r2 = sdiv r2 4294967296 64 
  r1 = sub 32 r6 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = mul r1 r2 64 
  r3 = malloc r1 
  r1 = add 20480 24 64 
  store 8 r3 r1 0 
  r1 = add 20480 0 64 
  r2 = load 8 r1 0 
  r1 = mul r3 1 64 
  store 8 r2 r1 0 
  r1 = icmp slt r7 0 32 
  r2 = mul r4 1 32 
  r3 = mul r4 1 32 
  r6 = mul r7 1 32 
  r8 = mul r7 1 32 
  r7 = mul 0 1 32 
  br r1 .for.cond27.preheader .for.cond8.preheader 
.for.cond8.preheader:
  r1 = icmp slt r3 0 32 
  r2 = mul r3 1 32 
  r3 = mul r4 1 32 
  r4 = mul r6 1 32 
  br r1 .for.end .for.body11.lr.ph 
.for.body11.lr.ph:
  r1 = shl 4294967295 r7 32 
  r6 = add r1 1 32 
  r2 = mul r4 1 32 
  r5 = mul r3 1 32 
  r4 = mul 0 1 32 
  br .for.body11 
.for.cond27.preheader:
  r1 = icmp slt r8 0 32 
  r3 = mul r2 1 32 
  r4 = mul r8 1 32 
  r15 = mul 0 1 32 
  br r1 .for.end112 .for.cond31.preheader 
.for.body11:
  r1 = or r4 r7 32 
  r1 = icmp eq r1 0 32 
  br r1 .for.inc .if.end 
.if.end:
  r1 = load 4 20480 16 
  r1 = add r6 r1 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r3 = mul r1 4 64 
  r2 = load 4 20480 8 
  r1 = shl 4294967295 r4 32 
  r1 = add r1 1 32 
  r1 = add r1 r2 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r3 r1 64 
  r1 = add r1 7 64 
  r1 = and r1 18446744073709551608 64 
  r3 = malloc r1 
  r2 = load 8 20480 24 
  r1 = add r5 1 32 
  r1 = mul r1 r7 32 
  r1 = add r1 r4 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = load 4 20480 32 
  r2 = mul r1 1 32 
  br .for.inc 
.for.inc:
  r1 = add r4 1 32 
  r3 = icmp slt r4 r2 32 
  r4 = mul r1 1 32 
  r5 = mul r2 1 32 
  br r3 .for.body11 .for.inc.for.end_crit_edge 
.for.inc.for.end_crit_edge:
  r1 = load 4 20480 40 
  r3 = mul r2 1 32 
  r4 = mul r1 1 32 
  br .for.end 
.for.end:
  r1 = add r7 1 32 
  r5 = icmp slt r7 r4 32 
  r6 = mul r4 1 32 
  r7 = mul r1 1 32 
  r8 = mul r4 1 32 
  r4 = mul r3 1 32 
  r16 = mul r2 1 32 
  r2 = mul r3 1 32 
  r3 = mul r16 1 32 
  br r5 .for.cond8.preheader .for.cond27.preheader 
.for.cond31.preheader:
  r1 = icmp slt r2 0 32 
  br r1 .for.end109 .for.body34.lr.ph 
.for.body34.lr.ph:
  r1 = shl 4294967295 r15 32 
  r14 = add r1 1 32 
  r13 = add r15 4294967295 32 
  r1 = shl 1 r13 32 
  store 8 r1 sp 0 
  r4 = mul r2 1 32 
  r2 = mul r3 1 32 
  r12 = mul 0 1 32 
  br .for.body34 
.for.body34:
  r1 = or r12 r15 32 
  r1 = icmp eq r1 0 32 
  br r1 .for.inc107 .if.end41 
.if.end41:
  r1 = load 4 20480 16 
  r1 = add r1 r14 32 
  r1 = icmp sgt r1 0 32 
  br r1 .for.cond48.preheader.lr.ph .for.inc107 
.for.cond48.preheader.lr.ph:
  r2 = load 8 20480 24 
  r1 = add r4 1 32 
  r1 = mul r1 r15 32 
  r1 = add r1 r12 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 16 
  r1 = shl 4294967295 r12 32 
  r11 = add r1 1 32 
  r1 = icmp eq r12 0 32 
  store 8 r1 sp 8 
  r10 = add r12 4294967295 32 
  r1 = shl 4294967295 r10 32 
  r1 = add r1 1 32 
  store 8 r1 sp 24 
  r1 = shl 1 r10 32 
  store 8 r1 sp 32 
  r1 = load 4 20480 8 
  r2 = mul r1 1 32 
  r9 = mul 0 1 32 
  br .for.cond48.preheader 
.for.cond48.preheader:
  r1 = add r2 r11 32 
  r1 = icmp sgt r1 0 32 
  r3 = mul r2 1 32 
  br r1 .for.body53.lr.ph .for.cond.cleanup52 
.for.body53.lr.ph:
  r1 = load 8 sp 8 
  r7 = mul r2 1 32 
  r6 = mul 0 1 32 
  br r1 .for.body53.lr.ph.split.us .for.body53 
.for.body53.lr.ph.split.us:
  r1 = load 8 sp 0 
  r8 = add r9 r1 32 
  r7 = mul r2 1 32 
  r6 = mul 0 1 32 
  br .for.body53.us 
.for.body53.us:
  r2 = load 8 20480 24 
  r1 = load 4 20480 32 
  r1 = add r1 1 32 
  r1 = mul r1 r13 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r5 = load 8 r1 0 
  r1 = mul r7 r9 32 
  r4 = add r1 r6 32 
  r4 = mul r4 4294967296 64 
  r4 = sdiv r4 4294967296 64 
  r2 = mul r5 1 64 
  r1 = mul r4 4 64 
  r1 = add r2 r1 64 
  r3 = load 4 r1 0 
  r1 = mul r7 r8 32 
  r1 = add r1 r6 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r5 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r3 r2 32 
  r3 = select r1 r3 r2 
  r1 = load 8 sp 16 
  r2 = mul r1 1 64 
  r1 = mul r4 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r2 = add r6 1 32 
  r3 = load 4 20480 8 
  r1 = add r3 r11 32 
  r1 = icmp slt r2 r1 32 
  r6 = mul r2 1 32 
  r7 = mul r3 1 32 
  br r1 .for.body53.us .for.cond.cleanup52 
.for.cond.cleanup52:
  r2 = add r9 1 32 
  r1 = load 4 20480 16 
  r1 = add r1 r14 32 
  r1 = icmp slt r2 r1 32 
  r9 = mul r2 1 32 
  r2 = mul r3 1 32 
  br r1 .for.cond48.preheader .for.cond.cleanup52.for.inc107_crit_edge 
.for.cond.cleanup52.for.inc107_crit_edge:
  r1 = load 4 20480 32 
  r2 = mul r1 1 32 
  br .for.inc107 
.for.body53:
  r2 = load 8 20480 24 
  r1 = load 4 20480 32 
  r1 = add r1 1 32 
  r1 = mul r1 r15 32 
  r1 = add r1 r10 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r5 = load 8 r1 0 
  r1 = load 8 sp 24 
  r1 = add r7 r1 32 
  r1 = mul r1 r9 32 
  r4 = add r1 r6 32 
  r1 = mul r4 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r5 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r3 = load 4 r1 0 
  r1 = load 8 sp 32 
  r1 = add r4 r1 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r5 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r3 r2 32 
  r4 = select r1 r3 r2 
  r1 = add r7 r11 32 
  r1 = mul r1 r9 32 
  r3 = add r1 r6 32 
  r3 = mul r3 4294967296 64 
  r3 = sdiv r3 4294967296 64 
  r1 = load 8 sp 16 
  r2 = mul r1 1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  store 4 r4 r1 0 
  r2 = add r6 1 32 
  r3 = load 4 20480 8 
  r1 = add r3 r11 32 
  r1 = icmp slt r2 r1 32 
  r6 = mul r2 1 32 
  r7 = mul r3 1 32 
  br r1 .for.body53 .for.cond.cleanup52 
.for.inc107:
  r1 = add r12 1 32 
  r3 = icmp slt r12 r2 32 
  r4 = mul r2 1 32 
  r12 = mul r1 1 32 
  br r3 .for.body34 .for.inc107.for.end109_crit_edge 
.for.inc107.for.end109_crit_edge:
  r1 = load 4 20480 40 
  r3 = mul r2 1 32 
  r4 = mul r1 1 32 
  br .for.end109 
.for.end109:
  r1 = add r15 1 32 
  r5 = icmp slt r15 r4 32 
  r15 = mul r1 1 32 
  br r5 .for.cond31.preheader .for.end112 
.for.end112:
  sp = add sp 40 64 
  ret 0 
end preprocess

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 8 
  r1 = malloc 8 
  r1 = malloc 8 
  r1 = malloc 8 
  r1 = malloc 8 
  r1 = malloc 8 
  r1 = call read 
  store 4 r1 20480 16 
  r1 = call read 
  r3 = mul r1 1 32 
  store 4 r3 20480 8 
  r4 = load 4 20480 16 
  r2 = mul r4 4294967296 64 
  r2 = sdiv r2 4294967296 64 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 1073741824 64 
  r1 = mul r1 r2 64 
  r1 = add r1 7 64 
  r1 = and r1 18446744073709551608 64 
  r2 = malloc r1 
  r1 = add 20480 0 64 
  store 8 r2 r1 0 
  r1 = icmp sgt r4 0 32 
  r2 = mul r3 1 32 
  r3 = mul r4 1 32 
  r5 = mul 0 1 32 
  br r1 .for.cond8.preheader .for.cond.cleanup 
.for.cond8.preheader:
  r1 = icmp sgt r2 0 32 
  r4 = mul 0 1 32 
  br r1 .for.body12 .for.cond.cleanup11 
.for.cond.cleanup:
  call preprocess 
  r1 = call read 
  r2 = mul r1 1 32 
  r1 = icmp eq r2 0 32 
  br r1 .while.end .while.body 
.for.cond.cleanup11:
  r1 = add r5 1 32 
  r4 = icmp slt r1 r3 32 
  r5 = mul r1 1 32 
  br r4 .for.cond8.preheader .for.cond.cleanup 
.for.body12:
  r1 = call read 
  r3 = mul r1 1 32 
  r2 = load 8 20480 0 
  r1 = load 4 20480 8 
  r1 = mul r1 r5 32 
  r1 = add r1 r4 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r1 = add r4 1 32 
  r3 = load 4 20480 8 
  r2 = icmp slt r1 r3 32 
  r4 = mul r1 1 32 
  br r2 .for.body12 .for.body12.for.cond.cleanup11_crit_edge 
.for.body12.for.cond.cleanup11_crit_edge:
  r1 = load 4 20480 16 
  r2 = mul r3 1 32 
  r3 = mul r1 1 32 
  br .for.cond.cleanup11 
.while.body:
  r15 = add r2 4294967295 32 
  r1 = call read 
  r14 = mul r1 1 32 
  r1 = call read 
  r2 = mul r1 1 32 
  r1 = call read 
  r13 = mul r1 1 32 
  r1 = call read 
  r6 = mul r1 1 32 
  r12 = add r2 1 32 
  r5 = sub r12 r14 32 
  r4 = mul 31 1 32 
  r2 = mul 0 1 32 
  br .for.body.i.i62 
.for.body.i.i62:
  r1 = shl 1 r4 32 
  r1 = and r1 r5 32 
  r1 = icmp eq r1 0 32 
  r11 = mul r2 1 32 
  br r1 .if.end.i.i66 .floorlog2.exit69 
.if.end.i.i66:
  r2 = add r2 1 32 
  r1 = add r4 4294967295 32 
  r3 = icmp eq r2 32 32 
  r4 = mul r1 1 32 
  r11 = mul 32 1 32 
  br r3 .floorlog2.exit69 .for.body.i.i62 
.floorlog2.exit69:
  r7 = sub 31 r11 32 
  r10 = add r6 1 32 
  r5 = sub r10 r13 32 
  r4 = mul 31 1 32 
  r2 = mul 0 1 32 
  br .for.body.i.i 
.for.body.i.i:
  r1 = shl 1 r4 32 
  r1 = and r1 r5 32 
  r1 = icmp eq r1 0 32 
  r6 = mul r2 1 32 
  br r1 .if.end.i.i .floorlog2.exit 
.if.end.i.i:
  r2 = add r2 1 32 
  r1 = add r4 4294967295 32 
  r3 = icmp eq r2 32 32 
  r4 = mul r1 1 32 
  r6 = mul 32 1 32 
  br r3 .floorlog2.exit .for.body.i.i 
.floorlog2.exit:
  r2 = sub 31 r6 32 
  r3 = load 8 20480 24 
  r1 = load 4 20480 32 
  r1 = add r1 1 32 
  r1 = mul r1 r7 32 
  r1 = add r1 r2 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r9 = load 8 r1 0 
  r2 = load 4 20480 8 
  r8 = lshr 2147483648 r6 32 
  r1 = sub 1 r8 32 
  r3 = add r1 r2 32 
  r4 = mul r3 r14 32 
  r1 = add r4 r13 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r9 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r7 = load 4 r1 0 
  r1 = lshr 2147483648 r11 32 
  r1 = sub r12 r1 32 
  r6 = mul r3 r1 32 
  r1 = add r6 r13 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r9 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r5 = load 4 r1 0 
  r3 = sub r10 r8 32 
  r1 = add r4 r3 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r9 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r4 = load 4 r1 0 
  r1 = add r6 r3 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r9 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r7 r5 32 
  r3 = select r1 r7 r5 
  r1 = icmp slt r4 r2 32 
  r2 = select r1 r4 r2 
  r1 = icmp slt r3 r2 32 
  r1 = select r1 r3 r2 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  r1 = icmp eq r15 0 32 
  r2 = mul r15 1 32 
  br r1 .while.end .while.body 
.while.end:
  ret 0 
end main

