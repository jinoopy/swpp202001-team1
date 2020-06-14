start matmul 4:
.entry:
  r1 = icmp eq arg1 0 32 
  br r1 .for.end22 .for.cond1.preheader.us.preheader 
.for.cond1.preheader.us.preheader:
  r11 = mul arg1 1 64 
  r13 = mul 0 1 32 
  br .for.cond1.preheader.us 
.for.cond1.preheader.us:
  r10 = mul r13 arg1 32 
  r12 = mul 0 1 64 
  br .for.cond4.preheader.us.us 
.for.cond4.preheader.us.us:
  r9 = urem r11 2 64 
  r2 = icmp eq arg1 1 32 
  r1 = mul 0 1 64 
  r6 = mul 0 1 64 
  br r2 .for.end.us.us.unr-lcssa .for.cond4.preheader.us.us.new 
.for.cond4.preheader.us.us.new:
  r1 = sub r11 r9 64 
  r7 = mul r1 1 64 
  r8 = mul 0 1 64 
  r5 = mul 0 1 64 
  br .for.body6.us.us 
.for.end.us.us.unr-lcssa:
  r2 = icmp eq r9 0 64 
  br r2 .for.end.us.us.unr-lcssa.for.end.us.us_crit_edge .for.end.us.us.epilog-lcssa 
.for.end.us.us.unr-lcssa.for.end.us.us_crit_edge:
  r1 = mul r12 1 32 
  br .for.end.us.us 
.for.end.us.us.epilog-lcssa:
  r5 = mul r1 1 32 
  r1 = mul r5 arg1 32 
  r4 = mul r12 1 32 
  r1 = add r1 r4 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = add r10 r5 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = mul r3 r1 64 
  r1 = add r1 r6 64 
  r3 = mul r1 1 64 
  r1 = mul r4 1 32 
  br .for.end.us.us 
.for.end.us.us:
  r1 = add r10 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r12 1 64 
  r2 = icmp eq r1 r11 64 
  r12 = mul r1 1 64 
  br r2 .for.cond1.for.end19_crit_edge.us-lcssa.us.us .for.cond4.preheader.us.us 
.for.body6.us.us:
  r4 = mul r8 1 32 
  r1 = add r10 r4 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r4 arg1 32 
  r6 = mul r12 1 32 
  r1 = add r1 r6 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r5 = add r1 r5 64 
  r1 = mul r8 1 32 
  r4 = or r1 1 32 
  r1 = add r10 r4 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r4 arg1 32 
  r1 = add r1 r6 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r3 = add r5 r1 64 
  r2 = add r8 2 64 
  r1 = add r7 18446744073709551614 64 
  r4 = icmp eq r1 0 64 
  r5 = mul r3 1 64 
  r6 = mul r3 1 64 
  r7 = mul r1 1 64 
  r8 = mul r2 1 64 
  r1 = mul r2 1 64 
  br r4 .for.end.us.us.unr-lcssa .for.body6.us.us 
.for.cond1.for.end19_crit_edge.us-lcssa.us.us:
  r1 = add r13 1 32 
  r2 = icmp eq r1 arg1 32 
  r13 = mul r1 1 32 
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
  r4 = mul 0 1 32 
  br r1 .for.end6 .for.cond1.preheader.us 
.for.cond1.preheader.us:
  r3 = mul r4 arg1 32 
  r6 = mul arg1 1 64 
  r5 = mul 0 1 64 
  br .for.body3.us 
.for.body3.us:
  r1 = mul r5 1 32 
  r1 = add r3 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r5 1 64 
  r2 = icmp eq r1 r6 64 
  r5 = mul r1 1 64 
  br r2 .for.end.us .for.body3.us 
.for.end.us:
  r1 = add r4 1 32 
  r2 = icmp eq r1 arg1 32 
  r4 = mul r1 1 32 
  br r2 .for.end6 .for.cond1.preheader.us 
.for.end6:
  ret 0 
end print_mat

start main 0:
.entry:
  ; Init stack pointer
  sp = sub sp 24 64 
  r15 = call read 
  r16 = mul r15 1 32 
  r14 = malloc 0 
  r13 = malloc 0 
  r1 = malloc 0 
  store 8 r1 sp 0 
  r8 = icmp eq r16 0 32 
  r7 = mul 0 1 32 
  br r8 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond1.i.preheader.us:
  r6 = mul r7 r16 32 
  r5 = urem r15 4294967296 64 
  r4 = mul 0 1 64 
  br .for.body3.i.us 
.for.body3.i.us:
  r3 = call read 
  r1 = mul r4 1 32 
  r1 = add r6 r1 32 
  r2 = mul r14 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r5 64 
  r4 = mul r1 1 64 
  br r2 .for.end.i.us .for.body3.i.us 
.for.end.i.us:
  r1 = add r7 1 32 
  r2 = icmp eq r1 r16 32 
  r7 = mul r1 1 32 
  br r2 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond.i3.preheader:
  r6 = mul 0 1 32 
  br r8 .print_mat.exit .for.cond1.i7.preheader.us 
.for.cond1.i7.preheader.us:
  r5 = mul r6 r16 32 
  r12 = urem r15 4294967296 64 
  r4 = mul 0 1 64 
  br .for.body3.i14.us 
.for.body3.i14.us:
  r3 = call read 
  r1 = mul r4 1 32 
  r1 = add r5 r1 32 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r12 64 
  r4 = mul r1 1 64 
  br r2 .for.end.i16.us .for.body3.i14.us 
.for.end.i16.us:
  r1 = add r6 1 32 
  r2 = icmp eq r1 r16 32 
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
  r11 = mul r1 r16 32 
  r10 = mul 0 1 64 
  br .for.cond4.i.preheader.us.us 
.for.cond4.i.preheader.us.us:
  r1 = urem r15 2 64 
  r1 = icmp eq r12 1 64 
  r5 = mul 0 1 64 
  r4 = mul 0 1 64 
  br r1 .for.end.i31.us.us.unr-lcssa .for.cond4.i.preheader.us.us.new 
.for.cond4.i.preheader.us.us.new:
  r1 = load 8 sp 16 
  r1 = sub r12 r1 64 
  r7 = mul r1 1 64 
  r9 = mul 0 1 64 
  r8 = mul 0 1 64 
  br .for.body6.i.us.us 
.for.end.i31.us.us.unr-lcssa:
  r1 = load 8 sp 16 
  r1 = icmp eq r1 0 64 
  r4 = mul r2 1 64 
  br r1 .for.end.i31.us.us .for.end.i31.us.us.epilog-lcssa 
.for.end.i31.us.us.epilog-lcssa:
  r1 = mul r5 r15 64 
  r1 = add r1 r10 64 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = urem r1 4 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r5 1 32 
  r1 = add r11 r1 32 
  r2 = mul r14 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = mul r3 r1 64 
  r1 = add r1 r4 64 
  r4 = mul r1 1 64 
  br .for.end.i31.us.us 
.for.end.i31.us.us:
  r1 = mul r10 1 32 
  r3 = add r11 r1 32 
  r1 = load 8 sp 0 
  r2 = mul r1 1 64 
  r1 = mul r3 8 64 
  r1 = add r1 r2 64 
  store 8 r4 r1 0 
  r1 = add r10 1 64 
  r2 = icmp eq r1 r12 64 
  r10 = mul r1 1 64 
  br r2 .for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us .for.cond4.i.preheader.us.us 
.for.body6.i.us.us:
  r1 = mul r9 1 32 
  r1 = add r11 r1 32 
  r2 = mul r14 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r9 r15 64 
  r1 = add r1 r10 64 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = urem r1 4 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r5 = add r1 r8 64 
  r4 = or r9 1 64 
  r1 = mul r4 1 32 
  r1 = add r11 r1 32 
  r2 = mul r14 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r3 = load 8 r1 0 
  r1 = mul r4 r15 64 
  r1 = add r1 r10 64 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = urem r1 4 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r3 = add r5 r1 64 
  r2 = add r9 2 64 
  r1 = add r7 18446744073709551614 64 
  r6 = icmp eq r1 0 64 
  r4 = mul r3 1 64 
  r5 = mul r2 1 64 
  r7 = mul r1 1 64 
  r8 = mul r3 1 64 
  r9 = mul r2 1 64 
  r2 = mul r3 1 64 
  br r6 .for.end.i31.us.us.unr-lcssa .for.body6.i.us.us 
.for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us:
  r1 = load 8 sp 8 
  r1 = add r1 1 32 
  r2 = icmp eq r1 r16 32 
  r6 = mul 0 1 32 
  br r2 .for.cond1.i38.preheader.us .for.cond1.i24.preheader.us 
.for.cond1.i38.preheader.us:
  r4 = mul r6 r16 32 
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
  r2 = icmp eq r1 r12 64 
  r5 = mul r1 1 64 
  br r2 .for.end.i46.us .for.body3.i44.us 
.for.end.i46.us:
  r1 = add r6 1 32 
  r2 = icmp eq r1 r16 32 
  r6 = mul r1 1 32 
  br r2 .print_mat.exit .for.cond1.i38.preheader.us 
.print_mat.exit:
  sp = add sp 24 64 
  ret 0 
end main

