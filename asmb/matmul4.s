start copy_mask 5:
.entry:
  r1 = mul arg2 arg1 32 
  r2 = add r1 arg3 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 1 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 2 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 3 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add arg2 1 32 
  r1 = mul r1 arg1 32 
  r2 = add r1 arg3 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 1 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 2 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 3 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add arg2 2 32 
  r1 = mul r1 arg1 32 
  r2 = add r1 arg3 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 1 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 2 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 3 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add arg2 3 32 
  r1 = mul r1 arg1 32 
  r2 = add r1 arg3 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 1 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 2 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  r1 = add r2 3 32 
  r1 = load 8 arg3 0 
  store r1 8 arg4 0 
  sp = add sp 0 64 
  ret 0 
end copy_mask

start add_mask 5:
.entry:
  r1 = mul arg2 arg1 32 
  r3 = add r1 arg3 32 
  r2 = load 8 arg4 0 
  r1 = mul r3 1 64 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 1 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 2 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 3 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r1 = add arg2 1 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 arg3 32 
  r2 = load 8 arg4 0 
  r1 = mul r3 1 64 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 1 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 2 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 3 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r1 = add arg2 2 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 arg3 32 
  r2 = load 8 arg4 0 
  r1 = mul r3 1 64 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 1 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 2 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 3 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r1 = add arg2 3 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 arg3 32 
  r2 = load 8 arg4 0 
  r1 = mul r3 1 64 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 1 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 2 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  r2 = load 8 arg4 0 
  r1 = add r3 3 32 
  r1 = load 8 arg3 0 
  r1 = add r1 r2 64 
  store r1 8 arg3 0 
  sp = add sp 0 64 
  ret 0 
end add_mask

start mask_mul 3:
.entry:
  r6 = mul 0 1 64 
  br .for.body 
.for.body:
  r5 = mul r6 4 64 
  r4 = shl r6 2 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r3 = mul r1 r2 64 
  r1 = or r5 1 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r3 = add r1 r3 64 
  r1 = or r5 2 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r1 = or r5 3 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r1 = add r3 r1 64 
  store r1 8 arg0 0 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r2 = mul r1 r2 64 
  r1 = or r5 1 64 
  r1 = load 8 arg1 0 
  r3 = load 8 arg2 0 
  r1 = mul r3 r1 64 
  r3 = add r1 r2 64 
  r1 = or r5 2 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r1 = or r5 3 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r2 = add r3 r1 64 
  r1 = or r4 1 64 
  store r2 8 arg0 0 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r3 = mul r1 r2 64 
  r1 = or r5 1 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r3 = add r1 r3 64 
  r1 = or r5 2 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r1 = or r5 3 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r2 = add r3 r1 64 
  r1 = or r4 2 64 
  store r2 8 arg0 0 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r3 = mul r1 r2 64 
  r1 = or r5 1 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r3 = add r1 r3 64 
  r1 = or r5 2 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r3 = add r3 r1 64 
  r1 = or r5 3 64 
  r2 = load 8 arg1 0 
  r1 = load 8 arg2 0 
  r1 = mul r1 r2 64 
  r2 = add r3 r1 64 
  r1 = or r4 3 64 
  store r2 8 arg0 0 
  r1 = add r6 1 64 
  r2 = icmp eq r1 4 64 
  r6 = mul r1 1 64 
  br r2 .for.end33 .for.body 
.for.end33:
  sp = add sp 0 64 
  ret 0 
end mask_mul

start matmul 4:
.entry:
  ; Init stack pointer
  sp = sub sp 384 64 
  r1 = icmp eq arg1 0 32 
  r9 = mul 0 1 32 
  br r1 .for.end17 .for.cond1.preheader 
.for.cond1.preheader:
  r8 = mul 0 1 32 
  br .for.cond4.preheader.us 
.for.cond4.preheader.us:
  r7 = mul 0 1 32 
  br .for.cond.i.preheader.us 
.for.cond.i.preheader.us:
  r1 = mul r9 arg1 32 
  r2 = add r7 r1 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = or r2 1 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = or r2 2 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = or r2 3 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = or r9 1 32 
  r1 = mul r1 arg1 32 
  r2 = add r7 r1 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = add r2 1 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = add r2 2 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = add r2 3 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = or r9 2 32 
  r1 = mul r1 arg1 32 
  r2 = add r7 r1 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = or r2 1 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = add r2 2 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = add r2 3 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = or r9 3 32 
  r1 = mul r1 arg1 32 
  r2 = add r7 r1 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = add r2 1 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = add r2 2 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = add r2 3 32 
  r1 = load 8 arg2 0 
  store r1 8 sp 128 
  r1 = mul r7 arg1 32 
  r2 = add r1 r8 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = or r2 1 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = or r2 2 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = or r2 3 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = or r7 1 32 
  r1 = mul r1 arg1 32 
  r2 = add r1 r8 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = add r2 1 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = add r2 2 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = add r2 3 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = or r7 2 32 
  r1 = mul r1 arg1 32 
  r2 = add r1 r8 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = or r2 1 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = add r2 2 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = add r2 3 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = or r7 3 32 
  r1 = mul r1 arg1 32 
  r2 = add r1 r8 32 
  r1 = mul r2 1 64 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = add r2 1 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = add r2 2 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r1 = add r2 3 32 
  r1 = load 8 arg3 0 
  store r1 8 sp 256 
  r6 = mul 0 1 64 
  br .for.body.i25.us 
.for.body.i25.us:
  r5 = mul r6 4 64 
  r4 = shl r6 2 64 
  r2 = load 8 sp 128 