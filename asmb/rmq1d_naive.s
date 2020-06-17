start malloc_upto_8 1:
.entry:
  r1 = add arg1 7 64 
  r1 = and r1 18446744073709551608 64 
  r1 = malloc r1 
  ret r1 
end malloc_upto_8

start min_element 2:
.entry:
  r2 = load 4 arg1 0 
  r1 = icmp eq arg1 arg2 64 
  r3 = mul r2 1 32 
  r4 = mul r2 1 32 
  r5 = mul r2 1 32 
  r2 = mul arg1 1 64 
  br r1 .while.end .while.body 
.while.body:
  r1 = icmp slt r5 r4 32 
  r3 = select r1 r5 r4 
  r1 = mul 1 4 64 
  r2 = add r2 r1 64 
  r1 = icmp eq r2 arg2 64 
  br r1 .while.end .while.body.while.body_crit_edge 
.while.body.while.body_crit_edge:
  r1 = load 4 r2 0 
  r4 = mul r3 1 32 
  r5 = mul r1 1 32 
  br .while.body 
.while.end:
  ret r3 
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
  r9 = mul r6 1 64 
  r3 = icmp sgt r2 0 32 
  r1 = call read 
  r2 = mul r1 1 64 
  br r3 .for.body.lr.ph .while.cond.preheader 
.for.body.lr.ph:
  r5 = urem r4 4294967296 64 
  r4 = mul 0 1 64 
  br .for.body 
.while.cond.preheader:
  r3 = mul r2 1 32 
  r1 = icmp eq r3 0 32 
  br r1 .while.end .while.body.lr.ph 
.while.body.lr.ph:
  r2 = mul r6 1 64 
  r1 = mul 4 1 64 
  r1 = add r2 r1 64 
  r8 = mul r1 1 64 
  r7 = mul r3 1 32 
  br .while.body 
.for.body:
  r3 = mul r1 1 32 
  r2 = mul r9 1 64 
  r1 = mul r4 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r2 = add r4 1 64 
  r1 = call read 
  r3 = icmp eq r2 r5 64 
  r4 = mul r2 1 64 
  r2 = mul r1 1 64 
  br r3 .while.cond.preheader .for.body 
.while.body:
  r1 = call read 
  r2 = call read 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r3 = mul r9 1 64 
  r1 = mul r1 4 64 
  r3 = add r3 r1 64 
  r1 = mul r2 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  r2 = mul r8 1 64 
  r1 = mul r1 4 64 
  r6 = add r2 r1 64 
  r2 = load 4 r3 0 
  r1 = icmp eq r3 r6 64 
  r4 = mul r2 1 32 
  r5 = mul r2 1 32 
  r10 = mul r2 1 32 
  r2 = mul r3 1 64 
  r3 = mul r2 1 64 
  br r1 .min_element.exit .while.body.i 
.while.body.i:
  r1 = icmp slt r5 r4 32 
  r3 = select r1 r5 r4 
  r1 = mul 1 4 64 
  r2 = add r2 r1 64 
  r1 = icmp eq r2 r6 64 
  br r1 .min_element.exit .while.body.i.while.body.i_crit_edge 
.while.body.i.while.body.i_crit_edge:
  r1 = load 4 r2 0 
  r4 = mul r3 1 32 
  r5 = mul r1 1 32 
  br .while.body.i 
.min_element.exit:
  r2 = add r7 4294967295 32 
  r1 = mul r3 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  r1 = icmp eq r2 0 32 
  r7 = mul r2 1 32 
  br r1 .while.end .while.body 
.while.end:
  ret 0 
end main

