start copy_mask 5:
.entry:
  r1 = mul arg2 arg1 32 
  r3 = add r1 arg3 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  store 8 r1 arg5 0 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 8 64 
  store 8 r2 r1 0 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 16 64 
  store 8 r2 r1 0 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 24 64 
  store 8 r2 r1 0 
  r1 = add arg2 1 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 arg3 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 32 64 
  store 8 r2 r1 0 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 40 64 
  store 8 r2 r1 0 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 48 64 
  store 8 r2 r1 0 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 56 64 
  store 8 r2 r1 0 
  r1 = add arg2 2 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 arg3 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 64 64 
  store 8 r2 r1 0 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 72 64 
  store 8 r2 r1 0 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 80 64 
  store 8 r2 r1 0 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 88 64 
  store 8 r2 r1 0 
  r1 = add arg2 3 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 arg3 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 96 64 
  store 8 r2 r1 0 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 104 64 
  store 8 r2 r1 0 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 112 64 
  store 8 r2 r1 0 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = mul arg5 1 64 
  r1 = add r1 120 64 
  store 8 r2 r1 0 
  ret 0 
end copy_mask

start add_mask 5:
.entry:
  r1 = mul arg2 arg1 32 
  r4 = add r1 arg3 32 
  r3 = load 8 arg5 0 
  r1 = mul r4 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 8 64 
  r3 = load 8 r1 0 
  r1 = add r4 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 16 64 
  r3 = load 8 r1 0 
  r1 = add r4 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 24 64 
  r3 = load 8 r1 0 
  r1 = add r4 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add arg2 1 32 
  r1 = mul r1 arg1 32 
  r4 = add r1 arg3 32 
  r1 = mul arg5 1 64 
  r1 = add r1 32 64 
  r3 = load 8 r1 0 
  r1 = mul r4 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 40 64 
  r3 = load 8 r1 0 
  r1 = add r4 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 48 64 
  r3 = load 8 r1 0 
  r1 = add r4 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 56 64 
  r3 = load 8 r1 0 
  r1 = add r4 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add arg2 2 32 
  r1 = mul r1 arg1 32 
  r4 = add r1 arg3 32 
  r1 = mul arg5 1 64 
  r1 = add r1 64 64 
  r3 = load 8 r1 0 
  r1 = mul r4 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 72 64 
  r3 = load 8 r1 0 
  r1 = add r4 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 80 64 
  r3 = load 8 r1 0 
  r1 = add r4 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 88 64 
  r3 = load 8 r1 0 
  r1 = add r4 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add arg2 3 32 
  r1 = mul r1 arg1 32 
  r4 = add r1 arg3 32 
  r1 = mul arg5 1 64 
  r1 = add r1 96 64 
  r3 = load 8 r1 0 
  r1 = mul r4 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 104 64 
  r3 = load 8 r1 0 
  r1 = add r4 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 112 64 
  r3 = load 8 r1 0 
  r1 = add r4 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = mul arg5 1 64 
  r1 = add r1 120 64 
  r3 = load 8 r1 0 
  r1 = add r4 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  ret 0 
end add_mask

start mask_mul 3:
.entry:
  r11 = mul 0 1 64 
  br .for.body 
.for.body:
  r4 = mul r11 4 64 
  r2 = mul arg2 1 64 
  r1 = mul r11 32 64 
  r10 = add r1 r2 64 
  r2 = load 8 r10 0 
  r1 = load 8 arg3 0 
  r3 = mul r1 r2 64 
  r9 = or r4 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r9 8 64 
  r8 = add r1 r2 64 
  r2 = load 8 r8 0 
  r1 = mul arg3 1 64 
  r1 = add r1 32 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r1 r3 64 
  r7 = or r4 2 64 
  r2 = mul arg2 1 64 
  r1 = mul r7 8 64 
  r6 = add r1 r2 64 
  r2 = load 8 r6 0 
  r1 = mul arg3 1 64 
  r1 = add r1 64 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r5 = or r4 3 64 
  r2 = mul arg2 1 64 
  r1 = mul r5 8 64 
  r4 = add r1 r2 64 
  r2 = load 8 r4 0 
  r1 = mul arg3 1 64 
  r1 = add r1 96 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r2 = mul arg1 1 64 
  r1 = mul r11 32 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r2 = load 8 r10 0 
  r1 = mul arg3 1 64 
  r1 = add r1 8 64 
  r1 = load 8 r1 0 
  r3 = mul r1 r2 64 
  r2 = load 8 r8 0 
  r1 = mul arg3 1 64 
  r1 = add r1 40 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r1 r3 64 
  r2 = load 8 r6 0 
  r1 = mul arg3 1 64 
  r1 = add r1 72 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r2 = load 8 r4 0 
  r1 = mul arg3 1 64 
  r1 = add r1 104 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r2 = mul arg1 1 64 
  r1 = mul r9 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r2 = load 8 r10 0 
  r1 = mul arg3 1 64 
  r1 = add r1 16 64 
  r1 = load 8 r1 0 
  r3 = mul r1 r2 64 
  r2 = load 8 r8 0 
  r1 = mul arg3 1 64 
  r1 = add r1 48 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r1 r3 64 
  r2 = load 8 r6 0 
  r1 = mul arg3 1 64 
  r1 = add r1 80 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r2 = load 8 r4 0 
  r1 = mul arg3 1 64 
  r1 = add r1 112 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r2 = mul arg1 1 64 
  r1 = mul r7 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r2 = load 8 r10 0 
  r1 = mul arg3 1 64 
  r1 = add r1 24 64 
  r1 = load 8 r1 0 
  r3 = mul r1 r2 64 
  r2 = load 8 r8 0 
  r1 = mul arg3 1 64 
  r1 = add r1 56 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r1 r3 64 
  r2 = load 8 r6 0 
  r1 = mul arg3 1 64 
  r1 = add r1 88 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r2 = load 8 r4 0 
  r1 = mul arg3 1 64 
  r1 = add r1 120 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r2 = mul arg1 1 64 
  r1 = mul r5 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r11 1 64 
  r2 = icmp eq r1 4 64 
  r11 = mul r1 1 64 
  br r2 .for.end33 .for.body 
.for.end33:
  ret 0 
end mask_mul

start matmul 4:
.entry:
  ; Init stack pointer
  sp = sub sp 544 64 
  r1 = icmp eq arg1 0 32 
  r15 = mul 0 1 32 
  br r1 .for.end17 .for.cond1.preheader 
.for.cond1.preheader:
  r14 = mul 0 1 32 
  br .for.cond4.preheader.us 
.for.cond4.preheader.us:
  r1 = add sp 160 64 
  r13 = add r1 96 64 
  r12 = mul 0 1 32 
  br .for.cond.i.preheader.us 
.for.cond.i.preheader.us:
  r11 = mul r15 arg1 32 
  r3 = add r12 r11 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  store 8 r2 r1 0 
  r1 = or r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = or r1 8 64 
  store 8 r2 r1 0 
  r1 = or r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 16 64 
  store 8 r2 r1 0 
  r1 = or r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 24 64 
  store 8 r2 r1 0 
  r1 = or r15 1 32 
  r10 = mul r1 arg1 32 
  r3 = add r12 r10 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 32 64 
  store 8 r2 r1 0 
  r1 = add r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 40 64 
  store 8 r2 r1 0 
  r1 = add r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 48 64 
  store 8 r2 r1 0 
  r1 = add r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 56 64 
  store 8 r2 r1 0 
  r1 = or r15 2 32 
  r9 = mul r1 arg1 32 
  r3 = add r12 r9 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 64 64 
  store 8 r2 r1 0 
  r1 = or r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 72 64 
  store 8 r2 r1 0 
  r1 = add r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 80 64 
  store 8 r2 r1 0 
  r1 = add r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 88 64 
  store 8 r2 r1 0 
  r1 = or r15 3 32 
  r1 = mul r1 arg1 32 
  store 8 r1 sp 0 
  r1 = load 8 sp 0 
  r3 = add r12 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 96 64 
  store 8 r2 r1 0 
  r1 = add r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 104 64 
  store 8 r2 r1 0 
  r1 = add r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 112 64 
  store 8 r2 r1 0 
  r1 = add r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r2 = load 8 r1 0 
  r1 = add sp 288 64 
  r1 = add r1 120 64 
  store 8 r2 r1 0 
  r1 = mul r12 arg1 32 
  r3 = add r1 r14 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = load 8 sp 24 
  store 8 r1 r2 0 
  r1 = or r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = or r1 8 64 
  r1 = load 8 sp 32 
  store 8 r1 r2 0 
  r1 = or r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 16 64 
  r1 = load 8 sp 40 
  store 8 r1 r2 0 
  r1 = or r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 24 64 
  r1 = load 8 sp 48 
  store 8 r1 r2 0 
  r1 = or r12 1 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 r14 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 32 64 
  r1 = load 8 sp 56 
  store 8 r1 r2 0 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 40 64 
  r1 = load 8 sp 64 
  store 8 r1 r2 0 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 48 64 
  r1 = load 8 sp 72 
  store 8 r1 r2 0 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 56 64 
  r1 = load 8 sp 80 
  store 8 r1 r2 0 
  r1 = or r12 2 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 r14 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 64 64 
  r1 = load 8 sp 88 
  store 8 r1 r2 0 
  r1 = or r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 72 64 
  r1 = load 8 sp 96 
  store 8 r1 r2 0 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 80 64 
  r1 = load 8 sp 104 
  store 8 r1 r2 0 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 88 64 
  r1 = load 8 sp 112 
  store 8 r1 r2 0 
  r1 = or r12 3 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 r14 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 96 64 
  r1 = load 8 sp 120 
  store 8 r1 r2 0 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 104 64 
  r1 = load 8 sp 128 
  store 8 r1 r2 0 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 112 64 
  r1 = load 8 sp 136 
  store 8 r1 r2 0 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r1 = add sp 416 64 
  r2 = add r1 120 64 
  r1 = load 8 sp 16 
  store 8 r1 r2 0 
  r8 = mul 0 1 64 
  br .for.body.i25.us 
.for.body.i25.us:
  r4 = mul r8 4 64 
  r2 = add sp 288 64 
  r1 = mul r8 32 64 
  r1 = add r1 r2 64 
  r7 = load 8 r1 0 
  r1 = load 8 sp 24 
  r3 = mul r1 r7 64 
  r1 = or r4 1 64 
  r2 = add sp 288 64 
  r1 = load 8 sp 144 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r6 = load 8 r1 0 
  r1 = load 8 sp 56 
  r1 = mul r1 r6 64 
  r3 = add r1 r3 64 
  r1 = or r4 2 64 
  r2 = add sp 288 64 
  r1 = load 8 sp 8 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r5 = load 8 r1 0 
  r1 = load 8 sp 88 
  r1 = mul r1 r5 64 
  r3 = add r3 r1 64 
  r1 = or r4 3 64 
  r2 = add sp 288 64 
  r1 = load 8 sp 152 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r4 = load 8 r1 0 
  r1 = load 8 sp 120 
  r1 = mul r1 r4 64 
  r3 = add r3 r1 64 
  r2 = add sp 160 64 
  r1 = mul r8 32 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = load 8 sp 32 
  r2 = mul r1 r7 64 
  r1 = load 8 sp 64 
  r1 = mul r1 r6 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 96 
  r1 = mul r1 r5 64 
  r2 = add r2 r1 64 
  r1 = load 8 sp 128 
  r1 = mul r1 r4 64 
  r3 = add r2 r1 64 
  r2 = add sp 160 64 
  r1 = load 8 sp 144 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = load 8 sp 40 
  r2 = mul r1 r7 64 
  r1 = load 8 sp 72 
  r1 = mul r1 r6 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 104 
  r1 = mul r1 r5 64 
  r2 = add r2 r1 64 
  r1 = load 8 sp 136 
  r1 = mul r1 r4 64 
  r3 = add r2 r1 64 
  r2 = add sp 160 64 
  r1 = load 8 sp 8 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = load 8 sp 48 
  r2 = mul r1 r7 64 
  r1 = load 8 sp 80 
  r1 = mul r1 r6 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 112 
  r1 = mul r1 r5 64 
  r2 = add r2 r1 64 
  r1 = load 8 sp 16 
  r1 = mul r1 r4 64 
  r3 = add r2 r1 64 
  r2 = add sp 160 64 
  r1 = load 8 sp 152 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r8 1 64 
  r2 = icmp eq r1 4 64 
  br r2 .for.body.i5.us .for.body.i25.us.for.body.i25.us_crit_edge 
.for.body.i25.us.for.body.i25.us_crit_edge:
  r8 = mul r1 1 64 
  br .for.body.i25.us 
.for.body.i5.us:
  r4 = add r14 r11 32 
  r3 = load 8 r1 0 
  r1 = mul r4 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = or r1 8 64 
  r3 = load 8 r1 0 
  r1 = or r4 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 16 64 
  r3 = load 8 r1 0 
  r1 = or r4 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 24 64 
  r3 = load 8 r1 0 
  r1 = or r4 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r4 = add r14 r10 32 
  r1 = add sp 160 64 
  r1 = add r1 32 64 
  r3 = load 8 r1 0 
  r1 = mul r4 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 40 64 
  r3 = load 8 r1 0 
  r1 = add r4 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 48 64 
  r3 = load 8 r1 0 
  r1 = add r4 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 56 64 
  r3 = load 8 r1 0 
  r1 = add r4 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r4 = add r14 r9 32 
  r1 = add sp 160 64 
  r1 = add r1 64 64 
  r3 = load 8 r1 0 
  r1 = mul r4 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 72 64 
  r3 = load 8 r1 0 
  r1 = or r4 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 80 64 
  r3 = load 8 r1 0 
  r1 = add r4 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 88 64 
  r3 = load 8 r1 0 
  r1 = add r4 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = load 8 sp 0 
  r4 = add r14 r1 32 
  r3 = load 8 r13 0 
  r1 = mul r4 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 104 64 
  r3 = load 8 r1 0 
  r1 = add r4 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 112 64 
  r3 = load 8 r1 0 
  r1 = add r4 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add sp 160 64 
  r1 = add r1 120 64 
  r3 = load 8 r1 0 
  r1 = add r4 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r1 = add r1 r3 64 
  store 8 r1 r2 0 
  r1 = add r12 4 32 
  r2 = icmp ult r1 arg1 32 
  r12 = mul r1 1 32 
  br r2 .for.cond.i.preheader.us .for.end.us 
.for.end.us:
  r1 = add r14 4 32 
  r2 = icmp ult r1 arg1 32 
  r14 = mul r1 1 32 
  br r2 .for.cond4.preheader.us .for.end14 
.for.end14:
  r1 = add r15 4 32 
  r2 = icmp ult r1 arg1 32 
  r15 = mul r1 1 32 
  br r2 .for.cond1.preheader .for.end17 
.for.end17:
  sp = add sp 544 64 
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
  r2 = add r4 1 64 
  r1 = icmp eq r2 r7 64 
  r4 = mul r2 1 64 
  br r1 .for.end.us .for.body3.us 
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
  r13 = mul r12 1 32 
  r1 = urem r13 4 32 
  r1 = icmp eq r1 0 32 
  br r1 .if.end .cleanup 
.if.end:
  r1 = mul r12 8 64 
  r1 = mul r1 r12 64 
  r1 = and r1 34359738360 64 
  r8 = malloc r1 
  r14 = mul r8 1 64 
  r10 = malloc r1 
  r9 = malloc r1 
  r11 = icmp eq r13 0 32 
  r6 = mul 0 1 32 
  br r11 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond1.i.preheader.us:
  r5 = mul r6 r13 32 
  r4 = urem r12 4294967296 64 
  r3 = mul 0 1 64 
  br .for.body3.i.us 
.for.body3.i.us:
  r2 = call read 
  r1 = mul r3 1 32 
  r1 = add r5 r1 32 
  r7 = mul r8 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r7 64 
  store 8 r2 r1 0 
  r1 = add r3 1 64 
  r2 = icmp eq r1 r4 64 
  r3 = mul r1 1 64 
  br r2 .for.end.i.us .for.body3.i.us 
.for.end.i.us:
  r1 = add r6 1 32 
  r2 = icmp eq r1 r13 32 
  r6 = mul r1 1 32 
  br r2 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond.i3.preheader:
  r8 = mul r10 1 64 
  r7 = mul 0 1 32 
  br r11 .read_mat.exit17 .for.cond1.i7.preheader.us 
.for.cond1.i7.preheader.us:
  r6 = mul r7 r13 32 
  r5 = urem r12 4294967296 64 
  r4 = mul 0 1 64 
  br .for.body3.i14.us 
.for.body3.i14.us:
  r3 = call read 
  r1 = mul r4 1 32 
  r1 = add r6 r1 32 
  r2 = mul r10 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r5 64 
  r4 = mul r1 1 64 
  br r2 .for.end.i16.us .for.body3.i14.us 
.for.end.i16.us:
  r1 = add r7 1 32 
  r2 = icmp eq r1 r13 32 
  r7 = mul r1 1 32 
  br r2 .read_mat.exit17 .for.cond1.i7.preheader.us 
.read_mat.exit17:
  r1 = mul r9 1 64 
  call matmul r13 r1 r14 r8 
  r6 = mul 0 1 32 
  br r11 .cleanup .for.cond1.i24.preheader.us 
.for.cond1.i24.preheader.us:
  r4 = mul r6 r13 32 
  r3 = urem r12 4294967296 64 
  r5 = mul 0 1 64 
  br .for.body3.i30.us 
.for.body3.i30.us:
  r1 = mul r5 1 32 
  r1 = add r4 r1 32 
  r2 = mul r9 1 64 
  r1 = mul r1 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r5 1 64 
  r2 = icmp eq r1 r3 64 
  r5 = mul r1 1 64 
  br r2 .for.end.i32.us .for.body3.i30.us 
.for.end.i32.us:
  r1 = add r6 1 32 
  r2 = icmp eq r1 r13 32 
  r6 = mul r1 1 32 
  br r2 .cleanup .for.cond1.i24.preheader.us 
.cleanup:
  ret 0 
end main

