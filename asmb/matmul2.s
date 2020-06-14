start matmul 4:
.entry:
  r1 = icmp eq arg1 0 32 
  br r1 .for.end22 .for.cond1.preheader.us.preheader 
.for.cond1.preheader.us.preheader:
  r12 = mul arg1 1 64 
  r14 = mul 0 1 32 
  br .for.cond1.preheader.us 
.for.cond1.preheader.us:
  r11 = mul r14 arg1 32 
  r13 = mul 0 1 64 
  br .for.cond4.preheader.us.us 
.for.cond4.preheader.us.us:
  r10 = mul r13 1 32 
  r1 = add r11 r10 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r9 = add r1 r2 64 
  r8 = srem r12 2 64 
  r1 = icmp eq arg1 1 32 
  r2 = mul 0 1 64 
  br r1 .for.end.us.us.unr-lcssa .for.cond4.preheader.us.us.new 
.for.cond4.preheader.us.us.new:
  r1 = sub r12 r8 64 
  r2 = load 8 r9 0 
  r5 = mul r2 1 64 
  r6 = mul r1 1 64 
  r7 = mul 0 1 64 
  br .for.body6.us.us 
.for.end.us.us.unr-lcssa:
  r1 = icmp eq r8 0 64 
  br r1 .for.end.us.us .for.body6.us.us.epil 
.for.body6.us.us.epil:
  r4 = mul r2 1 32 
  r1 = add r11 r4 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r4 arg1 32 
  r1 = add r1 r10 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r2 = mul r1 r3 64 
  r1 = load 8 r9 0 
  r1 = add r1 r2 64 
  store 8 r1 r9 0 
  br .for.end.us.us 
.for.end.us.us:
  r1 = add r13 1 64 
  r2 = icmp eq r1 r12 64 
  r13 = mul r1 1 64 
  br r2 .for.cond1.for.end19_crit_edge.us-lcssa.us.us .for.cond4.preheader.us.us 
.for.body6.us.us:
  r4 = mul r7 1 32 
  r1 = add r11 r4 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r4 arg1 32 
  r1 = add r1 r10 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r5 = add r5 r1 64 
  store 8 r5 r9 0 
  r1 = mul r7 1 32 
  r4 = or r1 1 32 
  r1 = add r11 r4 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r4 arg1 32 
  r1 = add r1 r10 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r3 = add r5 r1 64 
  store 8 r3 r9 0 
  r2 = add r7 2 64 
  r1 = add r6 18446744073709551614 64 
  r4 = icmp eq r1 0 64 
  r5 = mul r3 1 64 
  r6 = mul r1 1 64 
  r7 = mul r2 1 64 
  br r4 .for.end.us.us.unr-lcssa .for.body6.us.us 
.for.cond1.for.end19_crit_edge.us-lcssa.us.us:
  r1 = add r14 1 32 
  r2 = icmp eq r1 arg1 32 
  r14 = mul r1 1 32 
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
  r1 = add r1 r2 64 
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
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  call write r1 
  r2 = add r3 1 64 
  r1 = icmp eq r2 r6 64 
  r3 = mul r2 1 64 
  br r1 .for.end.us .for.body3.us 
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
  ; Init stack pointer
  sp = sub sp 32 64 
  r15 = call read 
  r14 = mul r15 1 32 
  r13 = malloc 0 
  r12 = malloc 0 
  r1 = malloc 0 
  store 8 r1 sp 0 
  r1 = icmp eq r14 0 32 
  store 8 r1 sp 24 
  r1 = load 8 sp 24 
  r7 = mul 0 1 32 
  br r1 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond1.i.preheader.us:
  r5 = mul r7 r14 32 
  r4 = srem r15 4294967296 64 
  r6 = mul 0 1 64 
  br .for.body3.i.us 
.for.body3.i.us:
  r3 = call read 
  r1 = mul r6 1 32 
  r1 = add r5 r1 32 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r6 1 64 
  r2 = icmp eq r1 r4 64 
  r6 = mul r1 1 64 
  br r2 .for.end.i.us .for.body3.i.us 
.for.end.i.us:
  r1 = add r7 1 32 
  r2 = icmp eq r1 r14 32 
  r7 = mul r1 1 32 
  br r2 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond.i3.preheader:
  r1 = load 8 sp 24 
  r6 = mul 0 1 32 
  br r1 .print_mat.exit .for.cond1.i7.preheader.us 
.for.cond1.i7.preheader.us:
  r5 = mul r6 r14 32 
  r11 = srem r15 4294967296 64 
  r4 = mul 0 1 64 
  br .for.body3.i14.us 
.for.body3.i14.us:
  r3 = call read 
  r1 = mul r4 1 32 
  r1 = add r5 r1 32 
  r2 = mul r12 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r11 64 
  r4 = mul r1 1 64 
  br r2 .for.end.i16.us .for.body3.i14.us 
.for.end.i16.us:
  r1 = add r6 1 32 
  r2 = icmp eq r1 r14 32 
  r6 = mul r1 1 32 
  br r2 .for.cond.i20.preheader .for.cond1.i7.preheader.us 
.for.cond.i20.preheader:
  br .for.cond1.i24.preheader.us.preheader 
.for.cond1.i24.preheader.us.preheader:
  r1 = mul 0 1 32 
  br .for.cond1.i24.preheader.us 
.for.cond1.i24.preheader.us:
  store 8 r1 sp 8 
  r1 = load 8 sp 8 
  r10 = mul r1 r14 32 
  r9 = mul 0 1 64 
  br .for.cond4.i.preheader.us.us 
.for.cond4.i.preheader.us.us:
  r1 = mul r9 1 32 
  r3 = add r10 r1 32 
  r1 = load 8 sp 0 
  r2 = mul r1 1 64 
  r1 = mul r3 8 64 
  r8 = add r1 r2 64 
  r1 = srem r15 2 64 
  r1 = icmp eq r11 1 64 
  r4 = mul 0 1 64 
  br r1 .for.end.i31.us.us.unr-lcssa .for.cond4.i.preheader.us.us.new 
.for.cond4.i.preheader.us.us.new:
  r1 = load 8 sp 16 
  r2 = sub r11 r1 64 
  r1 = load 8 r8 0 
  r6 = mul r2 1 64 
  r2 = mul r1 1 64 
  r7 = mul 0 1 64 
  br .for.body6.i.us.us 
.for.end.i31.us.us.unr-lcssa:
  r1 = load 8 sp 16 
  r1 = icmp eq r1 0 64 
  br r1 .for.end.i31.us.us .for.body6.i.us.us.epil 
.for.body6.i.us.us.epil:
  r1 = mul r4 1 32 
  r1 = add r10 r1 32 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r4 r15 64 
  r1 = add r1 r9 64 
  r1 = srem r1 4294967296 64 
  r2 = mul r12 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r2 = mul r1 r3 64 
  r1 = load 8 r8 0 
  r1 = add r1 r2 64 
  store 8 r1 r8 0 
  br .for.end.i31.us.us 
.for.end.i31.us.us:
  r1 = add r9 1 64 
  r2 = icmp eq r1 r11 64 
  r9 = mul r1 1 64 
  br r2 .for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us .for.cond4.i.preheader.us.us 
.for.body6.i.us.us:
  r1 = mul r7 1 32 
  r1 = add r10 r1 32 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r7 r15 64 
  r1 = add r1 r9 64 
  r1 = srem r1 4294967296 64 
  r2 = mul r12 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r2 = mul r1 r3 64 
  r1 = load 8 sp 24 
  r5 = add r1 r2 64 
  store 8 r5 r8 0 
  r4 = or r7 1 64 
  r1 = mul r4 1 32 
  r1 = add r10 r1 32 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r4 r15 64 
  r1 = add r1 r9 64 
  r1 = srem r1 4294967296 64 
  r2 = mul r12 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r4 = add r5 r1 64 
  store 8 r4 r8 0 
  r2 = add r7 2 64 
  r1 = add r6 18446744073709551614 64 
  r3 = icmp eq r1 0 64 
  r6 = mul r1 1 64 
  r7 = mul r2 1 64 
  r16 = mul r2 1 64 
  r2 = mul r4 1 64 
  r4 = mul r2 1 64 
  r2 = mul r4 1 64 
  r1 = mul r16 1 64 
  r16 = mul r4 1 64 
  r4 = mul r2 1 64 
  r1 = mul r16 1 64 
  br r3 .for.end.i31.us.us.unr-lcssa .for.body6.i.us.us 
.for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us:
  r1 = load 8 sp 8 
  r1 = add r1 1 32 
  r2 = icmp eq r1 r14 32 
  r6 = mul 0 1 32 
  br r2 .for.cond1.i38.preheader.us .for.cond1.i24.preheader.us 
.for.cond1.i38.preheader.us:
  r4 = mul r6 r14 32 
  r5 = mul 0 1 64 
  br .for.body3.i44.us 
.for.body3.i44.us:
  r1 = mul r5 1 32 
  r3 = add r4 r1 32 
  r1 = load 8 sp 0 
  r2 = mul r1 1 64 
  r1 = mul r3 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r5 1 64 
  r2 = icmp eq r1 r11 64 
  r5 = mul r1 1 64 
  br r2 .for.end.i46.us .for.body3.i44.us 
.for.end.i46.us:
  r1 = add r6 1 32 
  r2 = icmp eq r1 r14 32 
  r6 = mul r1 1 32 
  br r2 .print_mat.exit .for.cond1.i38.preheader.us 
.print_mat.exit:
  sp = add sp 32 64 
  ret 0 
end main

