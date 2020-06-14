start malloc_upto_8 1:
.entry:
  r1 = add arg1 7 64 
  r1 = and r1 18446744073709551608 64 
  r1 = malloc r1 
  ret r1 
end malloc_upto_8

start min_element 2:
.entry:
  r3 = load 4 arg1 0 
  r1 = icmp eq arg1 arg2 64 
  r2 = mul r3 1 32 
  br r1 .while.end .while.body.preheader 
.while.body.preheader:
  r2 = mul arg1 1 64 
  r1 = mul arg2 1 64 
  r1 = add r1 18446744073709551612 64 
  r1 = sub r1 r2 64 
  r9 = sdiv r1 4 64 
  r1 = add r9 1 64 
  r2 = srem r1 8 64 
  r1 = icmp eq r2 0 64 
  r4 = mul r3 1 32 
  r5 = mul r2 1 64 
  r6 = mul arg1 1 64 
  r7 = mul r3 1 32 
  r2 = mul arg1 1 64 
  br r1 .while.body.prol.loopexit .while.body.prol 
.while.body.prol:
  r1 = icmp slt r7 r4 32 
  r4 = select r1 r7 r4 32 
  r1 = mul r6 1 64 
  r3 = add r1 4 64 
  r2 = add r5 18446744073709551615 64 
  r1 = icmp eq r2 0 64 
  r2 = mul r3 1 64 
  r8 = mul r4 1 32 
  r3 = mul r4 1 32 
  br r1 .while.body.prol.loopexit .while.body.prol.while.body.prol_crit_edge 
.while.body.prol.while.body.prol_crit_edge:
  r1 = load 4 r3 0 
  r5 = mul r2 1 64 
  r6 = mul r3 1 64 
  r7 = mul r1 1 32 
  br .while.body.prol 
.while.body.prol.loopexit:
  r1 = icmp ult r9 7 64 
  r4 = mul r2 1 64 
  r5 = mul r3 1 32 
  r2 = mul r8 1 32 
  br r1 .while.end .while.body 
.while.body:
  r2 = load 4 r4 0 
  r1 = icmp slt r2 r5 32 
  r3 = select r1 r2 r5 32 
  r1 = mul r4 1 64 
  r1 = add r1 4 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 8 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 12 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 16 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 20 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 24 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 28 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r2 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 32 64 
  r3 = icmp eq r1 arg2 64 
  r4 = mul r1 1 64 
  r5 = mul r2 1 32 
  br r3 .while.end .while.body 
.while.end:
  ret r2 
end min_element

start main 0:
.entry:
  r4 = call read 
  r2 = mul r4 1 32 
  r1 = sdiv r4 1073741824 64 
  r1 = add r1 7 64 
  r1 = and r1 18446744073709551608 64 
  r14 = malloc r1 
  r3 = icmp sgt r2 0 32 
  r1 = call read 
  r2 = mul r1 1 64 
  br r3 .for.body.preheader .while.cond.preheader 
.for.body.preheader:
  r4 = srem r4 4294967296 64 
  r5 = mul 0 1 64 
  br .for.body 
.while.cond.preheader:
  r1 = icmp eq r2 0 32 
  br r1 .while.end .while.body.lr.ph 
.while.body.lr.ph:
  r1 = mul r14 1 64 
  r13 = add r1 4 64 
  r12 = mul r2 1 32 
  br .while.body 
.for.body:
  r3 = mul r1 1 32 
  r2 = mul r14 1 64 
  r1 = mul r5 4 64 
  r1 = add r1 r2 64 
  store 4 r3 r1 0 
  r2 = add r5 1 64 
  r1 = call read 
  r3 = icmp eq r2 r4 64 
  r5 = mul r2 1 64 
  r2 = mul r1 1 64 
  br r3 .while.cond.preheader .for.body 
.while.body:
  r4 = call read 
  r3 = call read 
  r2 = mul r14 1 64 
  r1 = mul r4 4 64 
  r6 = add r1 r2 64 
  r1 = mul r3 4 64 
  r11 = add r13 r1 64 
  r5 = load 4 r6 0 
  r2 = icmp eq r6 r11 64 
  r1 = mul r5 1 32 
  br r2 .min_element.exit .while.body.i.preheader 
.while.body.i.preheader:
  r1 = sub r3 r4 64 
  r1 = mul r1 4 64 
  r7 = sdiv r1 4 64 
  r1 = add r7 1 64 
  r1 = srem r1 8 64 
  r2 = icmp eq r1 0 64 
  r3 = mul r6 1 64 
  r4 = mul r5 1 32 
  r8 = mul r6 1 64 
  r9 = mul r5 1 32 
  r6 = mul r1 1 64 
  br r2 .while.body.i.prol.loopexit .while.body.i.prol 
.while.body.i.prol:
  r1 = icmp slt r5 r4 32 
  r4 = select r1 r5 r4 32 
  r1 = mul r3 1 64 
  r3 = add r1 4 64 
  r2 = add r6 18446744073709551615 64 
  r1 = icmp eq r2 0 64 
  r8 = mul r3 1 64 
  r9 = mul r4 1 32 
  r10 = mul r4 1 32 
  br r1 .while.body.i.prol.loopexit .while.body.i.prol.while.body.i.prol_crit_edge 
.while.body.i.prol.while.body.i.prol_crit_edge:
  r1 = load 4 r3 0 
  r5 = mul r1 1 32 
  r6 = mul r2 1 64 
  br .while.body.i.prol 
.while.body.i.prol.loopexit:
  r2 = icmp ult r7 7 64 
  r1 = mul r10 1 32 
  r4 = mul r8 1 64 
  r5 = mul r9 1 32 
  br r2 .min_element.exit .while.body.i 
.while.body.i:
  r2 = load 4 r4 0 
  r1 = icmp slt r2 r5 32 
  r3 = select r1 r2 r5 32 
  r1 = mul r4 1 64 
  r1 = add r1 4 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 8 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 12 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 16 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 20 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 24 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r3 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 28 64 
  r2 = load 4 r1 0 
  r1 = icmp slt r2 r3 32 
  r2 = select r1 r2 r3 32 
  r1 = mul r4 1 64 
  r1 = add r1 32 64 
  r3 = icmp eq r1 r11 64 
  r4 = mul r1 1 64 
  r5 = mul r2 1 32 
  r1 = mul r2 1 32 
  br r3 .min_element.exit .while.body.i 
.min_element.exit:
  r2 = add r12 4294967295 32 
  call write r1 
  r1 = icmp eq r2 0 32 
  r12 = mul r2 1 32 
  br r1 .while.end .while.body 
.while.end:
  ret 0 
end main

