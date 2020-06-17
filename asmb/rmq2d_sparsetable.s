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

start count_leading_zeros 1:
.entry:
  r2 = mul 0 1 32 
  r3 = mul 31 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp eq r2 32 32 
  br r1 .for.cond.cleanup .for.body 
.for.cond.cleanup:
  r1 = mul 32 1 32 
  br .cleanup 
.for.body:
  r1 = shl 1 r3 32 
  r1 = and r1 arg1 32 
  r1 = icmp eq r1 0 32 
  br r1 .if.end .if.then 
.if.then:
  r1 = mul r2 1 32 
  br .cleanup 
.if.end:
  r2 = add r2 1 32 
  r1 = add r3 4294967295 32 
  r3 = mul r1 1 32 
  br .for.cond 
.cleanup:
  ret r1 
end count_leading_zeros

start floorlog2 1:
.entry:
  r1 = call count_leading_zeros arg1 
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
  r1 = call A arg1 arg2 
  r2 = load 8 r1 0 
  r1 = call width arg2 
  r1 = mul r1 arg3 32 
  r1 = add r1 arg4 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  ret r1 
end P

start preprocess 0:
.entry:
  ; Init stack pointer
  sp = sub sp 16 64 
  r1 = load 4 20480 16 
  r1 = call floorlog2 r1 
  store 4 r1 20480 40 
  r1 = load 4 20480 8 
  r3 = call floorlog2 r1 
  store 4 r3 20480 32 
  r1 = load 4 20480 40 
  r2 = add r1 1 32 
  r2 = mul r2 4294967296 64 
  r2 = sdiv r2 4294967296 64 
  r1 = add r3 1 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r1 8 64 
  r1 = mul r1 r2 64 
  r2 = call malloc_upto_8 r1 
  r1 = add 20480 24 64 
  store 8 r2 r1 0 
  r1 = add 20480 0 64 
  r2 = load 8 r1 0 
  r1 = call A 0 0 
  store 8 r2 r1 0 
  r5 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r2 = load 4 20480 40 
  r1 = icmp sgt r5 r2 32 
  br r1 .for.end26 .for.body 
.for.body:
  r4 = icmp eq r5 0 32 
  r3 = mul 0 1 32 
  br .for.cond8 
.for.cond8:
  r1 = load 4 20480 32 
  r1 = icmp sgt r3 r1 32 
  br r1 .for.end .for.body11 
.for.body11:
  br r4 .land.lhs.true .if.end 
.land.lhs.true:
  r1 = icmp eq r3 0 32 
  br r1 .if.then .if.end 
.if.then:
  br .for.inc 
.if.end:
  r1 = call height r5 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r1 4 64 
  r1 = call width r3 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r1 = mul r2 r1 64 
  r2 = call malloc_upto_8 r1 
  r1 = call A r5 r3 
  store 8 r2 r1 0 
  br .for.inc 
.for.inc:
  r1 = add r3 1 32 
  r3 = mul r1 1 32 
  br .for.cond8 
.for.end:
  r1 = add r5 1 32 
  r5 = mul r1 1 32 
  br .for.cond 
.for.end26:
  r1 = mul r2 1 32 
  r14 = mul 0 1 32 
  br .for.cond27 
.for.cond27:
  r1 = icmp sgt r14 r1 32 
  br r1 .for.end112 .for.body30 
.for.body30:
  r13 = icmp eq r14 0 32 
  r12 = add r14 4294967295 32 
  r11 = shl 1 r12 32 
  r15 = mul 0 1 32 
  br .for.cond31 
.for.cond31:
  r1 = load 4 20480 32 
  r1 = icmp sgt r15 r1 32 
  br r1 .for.end109 .for.body34 
.for.body34:
  br r13 .land.lhs.true37 .if.end41 
.land.lhs.true37:
  r1 = icmp eq r15 0 32 
  br r1 .if.then40 .if.end41 
.if.then40:
  br .for.inc107 
.if.end41:
  r1 = call A r14 r15 
  r10 = load 8 r1 0 
  r9 = icmp eq r15 0 32 
  r8 = add r15 4294967295 32 
  r1 = shl 1 r8 32 
  store 8 r1 sp 0 
  r7 = mul 0 1 32 
  br .for.cond43 
.for.cond43:
  r1 = call height r14 
  r1 = icmp slt r7 r1 32 
  br r1 .for.body47 .for.cond.cleanup 
.for.cond.cleanup:
  br .for.inc107 
.for.body47:
  r1 = add r7 r11 32 
  store 8 r1 sp 8 
  r6 = mul 0 1 32 
  br .for.cond48 
.for.cond48:
  r1 = call width r15 
  r1 = icmp slt r6 r1 32 
  br r1 .for.body53 .for.cond.cleanup52 
.for.cond.cleanup52:
  r1 = add r7 1 32 
  r7 = mul r1 1 32 
  br .for.cond43 
.for.body53:
  br r9 .if.else .if.then56 
.if.then56:
  r1 = call A r14 r8 
  r5 = load 8 r1 0 
  r1 = call width r8 
  r1 = mul r1 r7 32 
  r4 = add r1 r6 32 
  r1 = mul r4 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r5 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r3 = load 4 r1 0 
  r1 = load 8 sp 0 
  r1 = add r4 r1 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r5 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r3 = call min r3 r1 
  r1 = call width r15 
  r1 = mul r1 r7 32 
  r1 = add r1 r6 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r10 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  br .if.end100 
.if.else:
  r1 = call A r12 0 
  r3 = load 8 r1 0 
  r1 = call height r12 
  r1 = call width 0 
  r1 = mul r1 r7 32 
  r1 = add r1 r6 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r3 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r4 = load 4 r1 0 
  r2 = call width 0 
  r1 = load 8 sp 8 
  r1 = mul r2 r1 32 
  r1 = add r1 r6 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r3 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r3 = call min r4 r1 
  r1 = call width 0 
  r1 = mul r1 r7 32 
  r1 = add r1 r6 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r10 1 64 
  r1 = mul r1 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  br .if.end100 
.if.end100:
  r1 = add r6 1 32 
  r6 = mul r1 1 32 
  br .for.cond48 
.for.inc107:
  r1 = add r15 1 32 
  r15 = mul r1 1 32 
  br .for.cond31 
.for.end109:
  r2 = add r14 1 32 
  r1 = load 4 20480 40 
  r14 = mul r2 1 32 
  br .for.cond27 
.for.end112:
  sp = add sp 16 64 
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
  r3 = call read 
  r1 = mul r3 1 32 
  store 4 r1 20480 8 
  r2 = load 4 20480 16 
  r2 = mul r2 4294967296 64 
  r2 = sdiv r2 4294967296 64 
  r1 = mul r3 4294967296 64 
  r1 = sdiv r1 1073741824 64 
  r1 = mul r1 r2 64 
  r2 = call malloc_upto_8 r1 
  r1 = add 20480 0 64 
  store 8 r2 r1 0 
  r4 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = load 4 20480 16 
  r1 = icmp slt r4 r1 32 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  call preprocess 
  r1 = call read 
  r2 = mul r1 1 32 
  br .while.cond 
.for.body:
  r2 = mul 0 1 32 
  br .for.cond8 
.for.cond8:
  r1 = load 4 20480 8 
  r1 = icmp slt r2 r1 32 
  br r1 .for.body12 .for.cond.cleanup11 
.for.cond.cleanup11:
  r1 = add r4 1 32 
  r4 = mul r1 1 32 
  br .for.cond 
.for.body12:
  r1 = call read 
  r3 = call input r4 r2 
  store 4 r1 r3 0 
  r1 = add r2 1 32 
  r2 = mul r1 1 32 
  br .for.cond8 
.while.cond:
  r1 = icmp eq r2 0 32 
  br r1 .while.end .while.body 
.while.body:
  r8 = add r2 4294967295 32 
  r1 = call read 
  r10 = mul r1 1 32 
  r1 = call read 
  r2 = mul r1 1 32 
  r1 = call read 
  r4 = mul r1 1 32 
  r1 = call read 
  r3 = mul r1 1 32 
  r2 = add r2 1 32 
  r1 = sub r2 r10 32 
  r7 = call floorlog2 r1 
  r3 = add r3 1 32 
  r1 = sub r3 r4 32 
  r6 = call floorlog2 r1 
  r5 = call P r7 r6 r10 r4 
  r1 = shl 4294967295 r7 32 
  r9 = add r2 r1 32 
  r2 = call P r7 r6 r9 r4 
  r1 = shl 4294967295 r6 32 
  r1 = add r3 r1 32 
  r3 = call P r7 r6 r10 r1 
  r1 = call P r7 r6 r9 r1 
  r2 = call min r5 r2 
  r1 = call min r3 r1 
  r1 = call min r2 r1 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  r2 = mul r8 1 32 
  br .while.cond 
.while.end:
  ret 0 
end main

