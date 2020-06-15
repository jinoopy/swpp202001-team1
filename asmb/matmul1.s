start matmul 4:
.entry:
  r1 = icmp eq arg1 0 32 
  r10 = mul 0 1 32 
  br r1 .for.end22 .for.cond1.preheader.us 
.for.cond1.preheader.us:
  r6 = mul r10 arg1 32 
  r5 = mul arg1 1 64 
  r9 = mul 0 1 64 
  br .for.cond4.preheader.us.us 
.for.cond4.preheader.us.us:
  r8 = mul 0 1 64 
  r7 = mul 0 1 64 
  br .for.body6.us.us 
.for.end.us.us:
  r1 = add r6 r4 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r9 1 64 
  r2 = icmp eq r1 r5 64 
  r9 = mul r1 1 64 
  br r2 .for.cond1.for.end19_crit_edge.us-lcssa.us.us .for.cond4.preheader.us.us 
.for.body6.us.us:
  r4 = mul r8 1 32 
  r1 = add r6 r4 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r1 = mul r4 arg1 32 
  r4 = mul r9 1 32 
  r1 = add r1 r4 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r3 = add r1 r7 64 
  r1 = add r8 1 64 
  r2 = icmp eq r1 r5 64 
  r7 = mul r3 1 64 
  r8 = mul r1 1 64 
  br r2 .for.end.us.us .for.body6.us.us 
.for.cond1.for.end19_crit_edge.us-lcssa.us.us:
  r1 = add r10 1 32 
  r2 = icmp eq r1 arg1 32 
  r10 = mul r1 1 32 
  br r2 .for.end22 .for.cond1.preheader.us 
.for.end22:
  ret 0 
end matmul

start read_mat 2:
.entry:
  r1 = icmp eq arg1 0 32 
  r6 = mul 0 1 32 
  br r1 .for.end6 .for.cond1.preheader.us 
.for.cond1.preheader.us:
  r5 = mul r6 arg1 32 
  r7 = mul arg1 1 64 
  r4 = mul 0 1 64 
  br .for.body3.us 
.for.body3.us:
  r3 = call read 
  r1 = mul r4 1 32 
  r1 = add r5 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r7 64 
  r4 = mul r1 1 64 
  br r2 .for.end.us .for.body3.us 
.for.end.us:
  r1 = add r6 1 32 
  r2 = icmp eq r1 arg1 32 
  r6 = mul r1 1 32 
  br r2 .for.end6 .for.cond1.preheader.us 
.for.end6:
  ret 0 
end read_mat

start print_mat 2:
.entry:
  r1 = icmp eq arg1 0 32 
  r5 = mul 0 1 32 
  br r1 .for.end6 .for.cond1.preheader.us 
.for.cond1.preheader.us:
  r4 = mul r5 arg1 32 
  r6 = mul arg1 1 64 
  r3 = mul 0 1 64 
  br .for.body3.us 
.for.body3.us:
  r1 = mul r3 1 32 
  r1 = add r4 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r3 1 64 
  r2 = icmp eq r1 r6 64 
  r3 = mul r1 1 64 
  br r2 .for.end.us .for.body3.us 
.for.end.us:
  r1 = add r5 1 32 
  r2 = icmp eq r1 arg1 32 
  r5 = mul r1 1 32 
  br r2 .for.end6 .for.cond1.preheader.us 
.for.end6:
  ret 0 
end print_mat

start main 0:
.entry:
  r11 = call read 
  r12 = mul r11 1 32 
  r1 = mul r11 8 64 
  r1 = mul r1 r11 64 
  r2 = and r1 34359738360 64 
  r15 = malloc r2 
  r6 = malloc r2 
  r9 = malloc r2 
  r10 = icmp eq r12 0 32 
  r5 = mul 0 1 32 
  br r10 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond1.i.preheader.us:
  r4 = mul r5 r12 32 
  r3 = urem r11 4294967296 64 
  r8 = mul 0 1 64 
  br .for.body3.i.us 
.for.body3.i.us:
  r7 = call read 
  r1 = mul r8 1 32 
  r1 = add r4 r1 32 
  r2 = mul r15 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r7 r1 0 
  r1 = add r8 1 64 
  r2 = icmp eq r1 r3 64 
  r8 = mul r1 1 64 
  br r2 .for.end.i.us .for.body3.i.us 
.for.end.i.us:
  r1 = add r5 1 32 
  r2 = icmp eq r1 r12 32 
  r5 = mul r1 1 32 
  br r2 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond.i3.preheader:
  r14 = mul r6 1 64 
  r7 = mul 0 1 32 
  br r10 .for.cond.i20.preheader .for.cond1.i7.preheader.us 
.for.cond1.i7.preheader.us:
  r6 = mul r7 r12 32 
  r5 = urem r11 4294967296 64 
  r4 = mul 0 1 64 
  br .for.body3.i14.us 
.for.body3.i14.us:
  r3 = call read 
  r1 = mul r4 1 32 
  r1 = add r6 r1 32 
  r2 = mul r14 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r5 64 
  r4 = mul r1 1 64 
  br r2 .for.end.i16.us .for.body3.i14.us 
.for.end.i16.us:
  r1 = add r7 1 32 
  r2 = icmp eq r1 r12 32 
  r7 = mul r1 1 32 
  br r2 .for.cond.i20.preheader .for.cond1.i7.preheader.us 
.for.cond.i20.preheader:
  r13 = mul r9 1 64 
  r9 = mul 0 1 32 
  br r10 .print_mat.exit .for.cond1.i24.preheader.us 
.for.cond1.i24.preheader.us:
  r4 = mul r9 r12 32 
  r6 = urem r11 4294967296 64 
  r8 = mul 0 1 64 
  br .for.cond4.i.preheader.us.us 
.for.cond4.i.preheader.us.us:
  r7 = mul 0 1 64 
  r5 = mul 0 1 64 
  br .for.body6.i.us.us 
.for.end.i31.us.us:
  r1 = mul r8 1 32 
  r1 = add r4 r1 32 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r8 1 64 
  r2 = icmp eq r1 r6 64 
  r8 = mul r1 1 64 
  br r2 .for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us .for.cond4.i.preheader.us.us 
.for.body6.i.us.us:
  r1 = mul r7 1 32 
  r1 = add r4 r1 32 
  r2 = mul r15 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r1 = mul r7 r11 64 
  r1 = add r1 r8 64 
  r1 = urem r1 4294967296 64 
  r2 = mul r14 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r3 = add r1 r5 64 
  r1 = add r7 1 64 
  r2 = icmp eq r1 r6 64 
  r5 = mul r3 1 64 
  r7 = mul r1 1 64 
  br r2 .for.end.i31.us.us .for.body6.i.us.us 
.for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us:
  r1 = add r9 1 32 
  r2 = icmp eq r1 r12 32 
  r9 = mul r1 1 32 
  br r2 .for.cond.i34.preheader .for.cond1.i24.preheader.us 
.for.cond.i34.preheader:
  r5 = mul 0 1 32 
  br .for.cond1.i38.preheader.us 
.for.cond1.i38.preheader.us:
  r3 = mul r5 r12 32 
  r4 = mul 0 1 64 
  br .for.body3.i44.us 
.for.body3.i44.us:
  r1 = mul r4 1 32 
  r1 = add r3 r1 32 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r6 64 
  r4 = mul r1 1 64 
  br r2 .for.end.i46.us .for.body3.i44.us 
.for.end.i46.us:
  r1 = add r5 1 32 
  r2 = icmp eq r1 r12 32 
  r5 = mul r1 1 32 
  br r2 .print_mat.exit .for.cond1.i38.preheader.us 
.print_mat.exit:
  ret 0 
end main

