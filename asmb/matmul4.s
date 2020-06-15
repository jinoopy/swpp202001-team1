start copy_mask 5:
.entry:
  r7 = mul 0 1 64 
  br .for.body 
.for.body:
  r1 = mul r7 1 32 
  r1 = add r1 arg2 32 
  r1 = mul r1 arg1 32 
  r6 = add r1 arg3 32 
  r5 = mul r7 4 64 
  r4 = mul 0 1 64 
  br .for.body6 
.for.body6:
  r1 = mul r4 1 32 
  r1 = add r6 r1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r1 = add r4 r5 64 
  r2 = mul arg5 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 4 64 
  r4 = mul r1 1 64 
  br r2 .for.end .for.body6 
.for.end:
  r1 = add r7 1 64 
  r2 = icmp eq r1 4 64 
  r7 = mul r1 1 64 
  br r2 .for.end19 .for.body 
.for.end19:
  ret 0 
end copy_mask

start add_mask 5:
.entry:
  r7 = mul 0 1 64 
  br .for.body 
.for.body:
  r6 = mul r7 4 64 
  r1 = mul r7 1 32 
  r1 = add r1 arg2 32 
  r1 = mul r1 arg1 32 
  r5 = add r1 arg3 32 
  r4 = mul 0 1 64 
  br .for.body6 
.for.body6:
  r1 = add r4 r6 64 
  r2 = mul arg5 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r1 = mul r4 1 32 
  r1 = add r5 r1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 4 64 
  r4 = mul r1 1 64 
  br r2 .for.end .for.body6 
.for.end:
  r1 = add r7 1 64 
  r2 = icmp eq r1 4 64 
  r7 = mul r1 1 64 
  br r2 .for.end20 .for.body 
.for.end20:
  ret 0 
end add_mask

start mask_mul 3:
.entry:
  r8 = mul 0 1 64 
  br .for.body 
.for.body:
  r7 = mul r8 4 64 
  r6 = mul 0 1 64 
  br .for.body6 
.for.body6:
  r5 = mul 0 1 64 
  r4 = mul 0 1 64 
  br .for.body11 
.for.body11:
  r1 = add r5 r7 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r1 = mul r5 4 64 
  r1 = add r1 r6 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r3 = add r1 r4 64 
  r1 = add r5 1 64 
  r2 = icmp eq r1 4 64 
  r4 = mul r3 1 64 
  r5 = mul r1 1 64 
  br r2 .for.end .for.body11 
.for.end:
  r1 = add r6 r7 64 
  r2 = mul arg1 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r6 1 64 
  r2 = icmp eq r1 4 64 
  r6 = mul r1 1 64 
  br r2 .for.end30 .for.body6 
.for.end30:
  r1 = add r8 1 64 
  r2 = icmp eq r1 4 64 
  r8 = mul r1 1 64 
  br r2 .for.end33 .for.body 
.for.end33:
  ret 0 
end mask_mul

start matmul 4:
.entry:
  ; Init stack pointer
  sp = sub sp 384 64 
  r1 = icmp eq arg1 0 32 
  r12 = mul 0 1 32 
  br r1 .for.end17 .for.cond1.preheader 
.for.cond1.preheader:
  r11 = mul 0 1 32 
  br .for.cond4.preheader.us 
.for.cond4.preheader.us:
  r10 = mul 0 1 32 
  br .for.cond.i.preheader.us 
.for.cond.i.preheader.us:
  r5 = mul 0 1 64 
  br .for.body.i.us 
.for.body.i.us:
  r1 = mul r5 1 32 
  r1 = add r12 r1 32 
  r1 = mul r1 arg1 32 
  r8 = add r1 r10 32 
  r7 = mul r5 4 64 
  r6 = mul 0 1 64 
  br .for.body6.i.us 
.for.body6.i.us:
  r1 = mul r6 1 32 
  r1 = add r8 r1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r4 = load 8 r1 0 
  r3 = add r6 r7 64 
  r2 = add sp 128 64 
  r1 = mul 0 128 64 
  r2 = add r2 r1 64 
  r1 = mul r3 8 64 
  r1 = add r2 r1 64 
  store 8 r4 r1 0 
  r1 = add r6 1 64 
  r2 = icmp eq r1 4 64 
  r6 = mul r1 1 64 
  br r2 .for.end.i.us .for.body6.i.us 
.for.end.i.us:
  r1 = add r5 1 64 
  r2 = icmp eq r1 4 64 
  r5 = mul r1 1 64 
  r8 = mul 0 1 64 
  br r2 .for.body.i42.us .for.body.i.us 
.for.body.i42.us:
  r1 = mul r8 1 32 
  r1 = add r10 r1 32 
  r1 = mul r1 arg1 32 
  r6 = add r1 r11 32 
  r5 = mul r8 4 64 
  r7 = mul 0 1 64 
  br .for.body6.i58.us 
.for.body6.i58.us:
  r1 = mul r7 1 32 
  r1 = add r6 r1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r4 = load 8 r1 0 
  r3 = add r7 r5 64 
  r2 = add sp 256 64 
  r1 = mul 0 128 64 
  r2 = add r2 r1 64 
  r1 = mul r3 8 64 
  r1 = add r2 r1 64 
  store 8 r4 r1 0 
  r1 = add r7 1 64 
  r2 = icmp eq r1 4 64 
  r7 = mul r1 1 64 
  br r2 .for.end.i60.us .for.body6.i58.us 
.for.end.i60.us:
  r1 = add r8 1 64 
  r2 = icmp eq r1 4 64 
  r8 = mul r1 1 64 
  r9 = mul 0 1 64 
  br r2 .for.body.i25.us .for.body.i42.us 
.for.body.i25.us:
  r5 = mul r9 4 64 
  r8 = mul 0 1 64 
  br .for.body6.i30.us 
.for.body6.i30.us:
  r7 = mul 0 1 64 
  r6 = mul 0 1 64 
  br .for.body11.i.us 
.for.body11.i.us:
  r3 = add r7 r5 64 
  r2 = add sp 128 64 
  r1 = mul 0 128 64 
  r2 = add r2 r1 64 
  r1 = mul r3 8 64 
  r1 = add r2 r1 64 
  r4 = load 8 r1 0 
  r1 = mul r7 4 64 
  r3 = add r1 r8 64 
  r2 = add sp 256 64 
  r1 = mul 0 128 64 
  r2 = add r2 r1 64 
  r1 = mul r3 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r4 64 
  r4 = add r1 r6 64 
  r1 = add r7 1 64 
  r2 = icmp eq r1 4 64 
  r6 = mul r4 1 64 
  r7 = mul r1 1 64 
  br r2 .for.end.i37.us .for.body11.i.us 
.for.end.i37.us:
  r3 = add r8 r5 64 
  r2 = add sp 0 64 
  r1 = mul 0 128 64 
  r2 = add r2 r1 64 
  r1 = mul r3 8 64 
  r1 = add r2 r1 64 
  store 8 r4 r1 0 
  r1 = add r8 1 64 
  r2 = icmp eq r1 4 64 
  r8 = mul r1 1 64 
  br r2 .for.end30.i.us .for.body6.i30.us 
.for.end30.i.us:
  r1 = add r9 1 64 
  r2 = icmp eq r1 4 64 
  r9 = mul r1 1 64 
  r7 = mul 0 1 64 
  br r2 .for.body.i5.us .for.body.i25.us 
.for.body.i5.us:
  r5 = mul r7 4 64 
  r1 = mul r7 1 32 
  r1 = add r12 r1 32 
  r1 = mul r1 arg1 32 
  r4 = add r1 r11 32 
  r6 = mul 0 1 64 
  br .for.body6.i19.us 
.for.body6.i19.us:
  r3 = add r6 r5 64 
  r2 = add sp 0 64 
  r1 = mul 0 128 64 
  r2 = add r2 r1 64 
  r1 = mul r3 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r1 = mul r6 1 32 
  r1 = add r4 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add r6 1 64 
  r2 = icmp eq r1 4 64 
  r6 = mul r1 1 64 
  br r2 .for.end.i20.us .for.body6.i19.us 
.for.end.i20.us:
  r1 = add r7 1 64 
  r2 = icmp eq r1 4 64 
  r7 = mul r1 1 64 
  br r2 .add_mask.exit.us .for.body.i5.us 
.add_mask.exit.us:
  r1 = add r10 4 32 
  r2 = icmp ult r1 arg1 32 
  r10 = mul r1 1 32 
  br r2 .for.cond.i.preheader.us .for.end.us 
.for.end.us:
  r1 = add r11 4 32 
  r2 = icmp ult r1 arg1 32 
  r11 = mul r1 1 32 
  br r2 .for.cond4.preheader.us .for.end14 
.for.end14:
  r1 = add r12 4 32 
  r2 = icmp ult r1 arg1 32 
  r12 = mul r1 1 32 
  br r2 .for.cond1.preheader .for.end17 
.for.end17:
  sp = add sp 384 64 
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
  r12 = call read 
  r11 = mul r12 1 32 
  r1 = urem r11 4 32 
  r1 = icmp eq r1 0 32 
  br r1 .if.end .cleanup 
.if.end:
  r1 = mul r12 8 64 
  r1 = mul r1 r12 64 
  r2 = and r1 34359738360 64 
  r13 = malloc r2 
  r8 = malloc r2 
  r10 = malloc r2 
  r9 = icmp eq r11 0 32 
  r7 = mul 0 1 32 
  br r9 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond1.i.preheader.us:
  r6 = mul r7 r11 32 
  r5 = urem r12 4294967296 64 
  r4 = mul 0 1 64 
  br .for.body3.i.us 
.for.body3.i.us:
  r3 = call read 
  r1 = mul r4 1 32 
  r1 = add r6 r1 32 
  r2 = mul r13 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r5 64 
  r4 = mul r1 1 64 
  br r2 .for.end.i.us .for.body3.i.us 
.for.end.i.us:
  r1 = add r7 1 32 
  r2 = icmp eq r1 r11 32 
  r7 = mul r1 1 32 
  br r2 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond.i3.preheader:
  r7 = mul 0 1 32 
  br r9 .read_mat.exit17 .for.cond1.i7.preheader.us 
.for.cond1.i7.preheader.us:
  r6 = mul r7 r11 32 
  r5 = urem r12 4294967296 64 
  r4 = mul 0 1 64 
  br .for.body3.i14.us 
.for.body3.i14.us:
  r3 = call read 
  r1 = mul r4 1 32 
  r1 = add r6 r1 32 
  r2 = mul r8 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r5 64 
  r4 = mul r1 1 64 
  br r2 .for.end.i16.us .for.body3.i14.us 
.for.end.i16.us:
  r1 = add r7 1 32 
  r2 = icmp eq r1 r11 32 
  r7 = mul r1 1 32 
  br r2 .read_mat.exit17 .for.cond1.i7.preheader.us 
.read_mat.exit17:
  r7 = mul r10 1 64 
  call matmul r11 r7 r13 r8 
  r6 = mul 0 1 32 
  br r9 .cleanup .for.cond1.i24.preheader.us 
.for.cond1.i24.preheader.us:
  r4 = mul r6 r11 32 
  r3 = urem r12 4294967296 64 
  r5 = mul 0 1 64 
  br .for.body3.i30.us 
.for.body3.i30.us:
  r1 = mul r5 1 32 
  r1 = add r4 r1 32 
  r2 = mul r7 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r5 1 64 
  r2 = icmp eq r1 r3 64 
  r5 = mul r1 1 64 
  br r2 .for.end.i32.us .for.body3.i30.us 
.for.end.i32.us:
  r1 = add r6 1 32 
  r2 = icmp eq r1 r11 32 
  r6 = mul r1 1 32 
  br r2 .cleanup .for.cond1.i24.preheader.us 
.cleanup:
  ret 0 
end main

