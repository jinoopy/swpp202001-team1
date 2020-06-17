start matmul 4:
.entry:
  ; Init stack pointer
  sp = sub sp 344 64 
  r1 = icmp eq arg1 0 32 
  r15 = mul 0 1 32 
  br r1 .for.end425 .for.cond1.preheader 
.for.cond1.preheader:
  r1 = mul r15 arg1 32 
  store 8 r1 sp 0 
  r1 = or r15 1 32 
  r1 = mul r1 arg1 32 
  store 8 r1 sp 8 
  r1 = or r15 2 32 
  r1 = mul r1 arg1 32 
  store 8 r1 sp 16 
  r1 = or r15 3 32 
  r1 = mul r1 arg1 32 
  store 8 r1 sp 24 
  r14 = mul 0 1 32 
  br .for.cond4.preheader 
.for.cond4.preheader:
  r1 = load 8 sp 0 
  r3 = add r14 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r13 = add r2 r1 64 
  r1 = or r3 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r12 = add r2 r1 64 
  r1 = or r3 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r11 = add r2 r1 64 
  r1 = or r3 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r10 = add r2 r1 64 
  r1 = load 8 sp 8 
  r3 = add r14 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r9 = add r2 r1 64 
  r1 = add r3 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r8 = add r2 r1 64 
  r1 = add r3 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r7 = add r2 r1 64 
  r1 = add r3 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r6 = add r2 r1 64 
  r1 = load 8 sp 16 
  r3 = add r14 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r1 sp 32 
  r1 = load 8 sp 32 
  store 8 r1 sp 32 
  r1 = or r3 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r1 sp 40 
  r1 = load 8 sp 40 
  store 8 r1 sp 40 
  r1 = add r3 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r1 sp 48 
  r1 = load 8 sp 48 
  store 8 r1 sp 48 
  r1 = add r3 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r1 sp 56 
  r1 = load 8 sp 56 
  store 8 r1 sp 56 
  r1 = load 8 sp 24 
  r3 = add r14 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r1 sp 64 
  r1 = load 8 sp 64 
  store 8 r1 sp 64 
  r1 = add r3 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r1 sp 72 
  r1 = load 8 sp 72 
  store 8 r1 sp 72 
  r1 = add r3 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r1 sp 80 
  r1 = load 8 sp 80 
  store 8 r1 sp 80 
  r1 = add r3 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r1 sp 88 
  r1 = load 8 sp 88 
  store 8 r1 sp 88 
  r5 = mul 0 1 32 
  br .for.body6 
.for.body6:
  r1 = load 8 sp 0 
  r3 = add r5 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 96 
  r1 = or r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 104 
  r1 = or r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 112 
  r1 = or r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 120 
  r1 = load 8 sp 8 
  r3 = add r5 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 128 
  r1 = add r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 136 
  r1 = add r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 144 
  r1 = add r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 152 
  r1 = load 8 sp 16 
  r3 = add r5 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 160 
  r1 = or r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 168 
  r1 = add r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 176 
  r1 = add r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 184 
  r1 = load 8 sp 24 
  r3 = add r5 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 192 
  r1 = add r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 200 
  r1 = add r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 208 
  r1 = add r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 216 
  r1 = mul r5 arg1 32 
  r3 = add r1 r14 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 224 
  r1 = or r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 232 
  r1 = or r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 240 
  r1 = or r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 248 
  r1 = or r5 1 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 r14 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 256 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 264 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 272 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 280 
  r1 = or r5 2 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 r14 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 288 
  r1 = or r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 296 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 304 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 312 
  r1 = or r5 3 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 r14 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 320 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 328 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 336 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r4 = load 8 r1 0 
  r2 = load 8 sp 224 
  r1 = load 8 sp 96 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 256 
  r1 = load 8 sp 104 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 288 
  r1 = load 8 sp 112 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 320 
  r1 = load 8 sp 120 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 r13 0 
  r1 = add r2 r1 64 
  store 8 r1 r13 0 
  r2 = load 8 sp 232 
  r1 = load 8 sp 96 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 264 
  r1 = load 8 sp 104 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 296 
  r1 = load 8 sp 112 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 328 
  r1 = load 8 sp 120 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 r12 0 
  r1 = add r2 r1 64 
  store 8 r1 r12 0 
  r2 = load 8 sp 240 
  r1 = load 8 sp 96 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 272 
  r1 = load 8 sp 104 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 304 
  r1 = load 8 sp 112 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 336 
  r1 = load 8 sp 120 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 r11 0 
  r1 = add r2 r1 64 
  store 8 r1 r11 0 
  r2 = load 8 sp 248 
  r1 = load 8 sp 96 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 280 
  r1 = load 8 sp 104 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 312 
  r1 = load 8 sp 112 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 120 
  r1 = mul r4 r1 64 
  r2 = add r2 r1 64 
  r1 = load 8 r10 0 
  r1 = add r2 r1 64 
  store 8 r1 r10 0 
  r2 = load 8 sp 224 
  r1 = load 8 sp 128 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 256 
  r1 = load 8 sp 136 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 288 
  r1 = load 8 sp 144 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 320 
  r1 = load 8 sp 152 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 r9 0 
  r1 = add r2 r1 64 
  store 8 r1 r9 0 
  r2 = load 8 sp 232 
  r1 = load 8 sp 128 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 264 
  r1 = load 8 sp 136 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 296 
  r1 = load 8 sp 144 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 328 
  r1 = load 8 sp 152 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 r8 0 
  r1 = add r2 r1 64 
  store 8 r1 r8 0 
  r2 = load 8 sp 240 
  r1 = load 8 sp 128 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 272 
  r1 = load 8 sp 136 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 304 
  r1 = load 8 sp 144 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 336 
  r1 = load 8 sp 152 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 r7 0 
  r1 = add r2 r1 64 
  store 8 r1 r7 0 
  r2 = load 8 sp 248 
  r1 = load 8 sp 128 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 280 
  r1 = load 8 sp 136 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 312 
  r1 = load 8 sp 144 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 152 
  r1 = mul r4 r1 64 
  r2 = add r2 r1 64 
  r1 = load 8 r6 0 
  r1 = add r2 r1 64 
  store 8 r1 r6 0 
  r2 = load 8 sp 224 
  r1 = load 8 sp 160 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 256 
  r1 = load 8 sp 168 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 288 
  r1 = load 8 sp 176 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 320 
  r1 = load 8 sp 184 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 32 
  r1 = load 8 r1 0 
  r2 = add r2 r1 64 
  r1 = load 8 sp 32 
  store 8 r2 r1 0 
  r2 = load 8 sp 232 
  r1 = load 8 sp 160 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 264 
  r1 = load 8 sp 168 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 296 
  r1 = load 8 sp 176 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 328 
  r1 = load 8 sp 184 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 40 
  r1 = load 8 r1 0 
  r2 = add r2 r1 64 
  r1 = load 8 sp 40 
  store 8 r2 r1 0 
  r2 = load 8 sp 240 
  r1 = load 8 sp 160 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 272 
  r1 = load 8 sp 168 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 304 
  r1 = load 8 sp 176 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 336 
  r1 = load 8 sp 184 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 48 
  r1 = load 8 r1 0 
  r2 = add r2 r1 64 
  r1 = load 8 sp 48 
  store 8 r2 r1 0 
  r2 = load 8 sp 248 
  r1 = load 8 sp 160 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 280 
  r1 = load 8 sp 168 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 312 
  r1 = load 8 sp 176 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 184 
  r1 = mul r4 r1 64 
  r2 = add r2 r1 64 
  r1 = load 8 sp 56 
  r1 = load 8 r1 0 
  r2 = add r2 r1 64 
  r1 = load 8 sp 56 
  store 8 r2 r1 0 
  r2 = load 8 sp 224 
  r1 = load 8 sp 192 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 256 
  r1 = load 8 sp 200 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 288 
  r1 = load 8 sp 208 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 320 
  r1 = load 8 sp 216 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 64 
  r1 = load 8 r1 0 
  r2 = add r2 r1 64 
  r1 = load 8 sp 64 
  store 8 r2 r1 0 
  r2 = load 8 sp 232 
  r1 = load 8 sp 192 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 264 
  r1 = load 8 sp 200 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 296 
  r1 = load 8 sp 208 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 328 
  r1 = load 8 sp 216 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 72 
  r1 = load 8 r1 0 
  r2 = add r2 r1 64 
  r1 = load 8 sp 72 
  store 8 r2 r1 0 
  r2 = load 8 sp 240 
  r1 = load 8 sp 192 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 272 
  r1 = load 8 sp 200 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 304 
  r1 = load 8 sp 208 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 336 
  r1 = load 8 sp 216 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 80 
  r1 = load 8 r1 0 
  r2 = add r2 r1 64 
  r1 = load 8 sp 80 
  store 8 r2 r1 0 
  r2 = load 8 sp 248 
  r1 = load 8 sp 192 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 280 
  r1 = load 8 sp 200 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 312 
  r1 = load 8 sp 208 
  r1 = mul r2 r1 64 
  r2 = add r3 r1 64 
  r1 = load 8 sp 216 
  r1 = mul r4 r1 64 
  r2 = add r2 r1 64 
  r1 = load 8 sp 88 
  r1 = load 8 r1 0 
  r2 = add r2 r1 64 
  r1 = load 8 sp 88 
  store 8 r2 r1 0 
  r1 = add r5 4 32 
  r2 = icmp ult r1 arg1 32 
  r5 = mul r1 1 32 
  br r2 .for.body6 .for.end 
.for.end:
  r1 = add r14 4 32 
  r2 = icmp ult r1 arg1 32 
  r14 = mul r1 1 32 
  br r2 .for.cond4.preheader .for.end422 
.for.end422:
  r1 = add r15 4 32 
  r2 = icmp ult r1 arg1 32 
  r15 = mul r1 1 32 
  br r2 .for.cond1.preheader .for.end425 
.for.end425:
  sp = add sp 344 64 
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
  r1 = urem r12 4 32 
  r1 = icmp eq r1 0 32 
  br r1 .if.end .cleanup 
.if.end:
  r1 = mul r11 8 64 
  r1 = mul r1 r11 64 
  r2 = and r1 34359738360 64 
  r13 = malloc r2 
  r8 = malloc r2 
  r10 = malloc r2 
  r9 = icmp eq r12 0 32 
  r7 = mul 0 1 32 
  br r9 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond1.i.preheader.us:
  r6 = mul r7 r12 32 
  r5 = urem r11 4294967296 64 
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
  r2 = icmp eq r1 r12 32 
  r7 = mul r1 1 32 
  br r2 .for.cond.i3.preheader .for.cond1.i.preheader.us 
.for.cond.i3.preheader:
  r7 = mul 0 1 32 
  br r9 .read_mat.exit17 .for.cond1.i7.preheader.us 
.for.cond1.i7.preheader.us:
  r6 = mul r7 r12 32 
  r5 = urem r11 4294967296 64 
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
  r2 = icmp eq r1 r12 32 
  r7 = mul r1 1 32 
  br r2 .read_mat.exit17 .for.cond1.i7.preheader.us 
.read_mat.exit17:
  r7 = mul r10 1 64 
  call matmul r12 r7 r13 r8 
  r6 = mul 0 1 32 
  br r9 .cleanup .for.cond1.i24.preheader.us 
.for.cond1.i24.preheader.us:
  r4 = mul r6 r12 32 
  r3 = urem r11 4294967296 64 
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
  r2 = icmp eq r1 r12 32 
  r6 = mul r1 1 32 
  br r2 .cleanup .for.cond1.i24.preheader.us 
.cleanup:
  ret 0 
end main

