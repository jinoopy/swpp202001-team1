start malloc_upto_8 1:
.entry:
  r1 = add arg1 7 64 
  r1 = and r1 18446744073709551608 64 
  r1 = malloc r1 
  ret r1 
end malloc_upto_8

start min_element 2:
.entry:
  r4 = load 4 arg1 0 
  r1 = icmp eq arg1 arg2 64 
  r5 = mul r4 1 32 
  br r1 .while.end .while.body.preheader 
.while.body.preheader:
  r3 = mul arg1 1 64 
  r2 = mul arg2 1 64 
  r1 = mul 18446744073709551615 4 64 
  r1 = add r2 r1 64 
  r9 = sub r1 r3 64 
  r1 = udiv r9 4 64 
  r1 = add r1 1 64 
  r2 = urem r1 8 64 
  r1 = icmp eq r2 0 64 
  r3 = mul r4 1 32 
  r5 = mul r2 1 64 
  r6 = mul arg1 1 64 
  r7 = mul r4 1 32 
  r8 = mul r4 1 32 
  r2 = mul arg1 1 64 
  br r1 .while.body.prol.loopexit .while.body.prol 
.while.body.prol:
  r1 = icmp slt r8 r7 32 
  r4 = select r1 r8 r7 
  r2 = mul r6 1 64 
  r1 = mul 1 4 64 
  r3 = add r2 r1 64 
  r2 = add r5 18446744073709551615 64 
  r1 = icmp eq r2 0 64 
  r2 = mul r3 1 64 
  r3 = mul r4 1 32 
  br r1 .while.body.prol.loopexit .while.body.prol.while.body.prol_crit_edge 
.while.body.prol.while.body.prol_crit_edge:
  r1 = load 4 r3 0 
  r5 = mul r2 1 64 
  r6 = mul r3 1 64 
  r7 = mul r4 1 32 
  r8 = mul r1 1 32 
  br .while.body.prol 
.while.body.prol.loopexit:
  r1 = icmp ult r9 28 64 
  r5 = mul r4 1 32 
  r4 = mul r2 1 64 
  br r1 .while.end .while.body 
.while.body:
  r2 = load 4 r4 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 2 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 3 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 4 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 5 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 6 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 7 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 8 4 64 
  r1 = add r2 r1 64 
  r2 = icmp eq r1 arg2 64 
  r4 = mul r1 1 64 
  r5 = mul r3 1 32 
  br r2 .while.end .while.body 
.while.end:
  ret r5 
end min_element

start main 0:
.entry:
  r4 = call read 
  r2 = mul r4 1 32 
  r1 = mul r4 4294967296 64 
  r1 = sdiv r1 1073741824 64 
  r1 = add r1 7 64 
  r1 = and r1 18446744073709551608 64 
  r6 = malloc r1 
  r14 = mul r6 1 64 
  r3 = icmp sgt r2 0 32 
  r1 = call read 
  r2 = mul r1 1 64 
  br r3 .for.body.preheader .while.cond.preheader 
.for.body.preheader:
  r4 = urem r4 4294967296 64 
  r5 = mul 0 1 64 
  br .for.body 
.while.cond.preheader:
  r3 = mul r2 1 32 
  r1 = icmp eq r3 0 32 
  br r1 .while.end .while.body.lr.ph 
.while.body.lr.ph:
  r2 = mul r6 1 64 
  r1 = mul 4 1 64 
  r1 = add r2 r1 64 
  r13 = mul r1 1 64 
  r12 = mul r3 1 32 
  br .while.body 
.for.body:
  r3 = mul r1 1 32 
  r2 = mul r14 1 64 
  r1 = mul r5 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r2 = add r5 1 64 
  r1 = call read 
  r3 = icmp eq r2 r4 64 
  r5 = mul r2 1 64 
  r2 = mul r1 1 64 
  br r3 .while.cond.preheader .for.body 
.while.body:
  r1 = call read 
  r3 = call read 
  r1 = mul r1 4294967296 64 
  r4 = sdiv r1 4294967296 64 
  r2 = mul r14 1 64 
  r1 = mul r4 4 64 
  r6 = add r2 r1 64 
  r1 = mul r3 4294967296 64 
  r3 = sdiv r1 4294967296 64 
  r2 = mul r13 1 64 
  r1 = mul r3 4 64 
  r11 = add r2 r1 64 
  r5 = load 4 r6 0 
  r2 = icmp eq r6 r11 64 
  r1 = mul r5 1 32 
  br r2 .min_element.exit .while.body.i.preheader 
.while.body.i.preheader:
  r10 = sub r3 r4 64 
  r1 = add r10 1 64 
  r1 = urem r1 8 64 
  r2 = icmp eq r1 0 64 
  r3 = mul r6 1 64 
  r4 = mul r5 1 32 
  r7 = mul r5 1 32 
  r8 = mul r6 1 64 
  r9 = mul r1 1 64 
  r6 = mul r5 1 32 
  br r2 .while.body.i.prol.loopexit .while.body.i.prol 
.while.body.i.prol:
  r1 = icmp slt r7 r6 32 
  r4 = select r1 r7 r6 
  r2 = mul r8 1 64 
  r1 = mul 1 4 64 
  r3 = add r2 r1 64 
  r2 = add r9 18446744073709551615 64 
  r1 = icmp eq r2 0 64 
  r5 = mul r4 1 32 
  br r1 .while.body.i.prol.loopexit .while.body.i.prol.while.body.i.prol_crit_edge 
.while.body.i.prol.while.body.i.prol_crit_edge:
  r1 = load 4 r3 0 
  r6 = mul r4 1 32 
  r7 = mul r1 1 32 
  r8 = mul r3 1 64 
  r9 = mul r2 1 64 
  br .while.body.i.prol 
.while.body.i.prol.loopexit:
  r1 = urem r10 4611686018427387904 64 
  r2 = icmp ult r1 7 64 
  r1 = mul r5 1 32 
  r15 = mul r3 1 64 
  r3 = mul r4 1 32 
  r4 = mul r15 1 64 
  br r2 .min_element.exit .while.body.i 
.while.body.i:
  r2 = load 4 r4 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 2 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 3 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 4 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 5 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 6 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 7 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 
  r2 = mul r4 1 64 
  r1 = mul 8 4 64 
  r1 = add r2 r1 64 
  r2 = icmp eq r1 r11 64 
  r4 = mul r1 1 64 
  r1 = mul r3 1 32 
  br r2 .min_element.exit .while.body.i 
.min_element.exit:
  r2 = add r12 4294967295 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  r1 = icmp eq r2 0 32 
  r12 = mul r2 1 32 
  br r1 .while.end .while.body 
.while.end:
  ret 0 
end main

