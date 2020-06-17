start matmul 4:
.entry:
  ; Init stack pointer
  sp = sub sp 224 64 
  r14 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp ult r14 arg1 32 
  br r1 .for.body .for.end425 
.for.body:
  r13 = mul 0 1 32 
  br .for.cond1 
.for.cond1:
  r1 = icmp ult r13 arg1 32 
  br r1 .for.body3 .for.end422 
.for.body3:
  r12 = mul 0 1 32 
  br .for.cond4 
.for.cond4:
  r1 = icmp ult r12 arg1 32 
  br r1 .for.body6 .for.end 
.for.body6:
  r4 = mul r14 arg1 32 
  r3 = add r12 r4 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r11 = load 8 r1 0 
  r1 = or r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r10 = load 8 r1 0 
  r1 = or r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r9 = load 8 r1 0 
  r1 = or r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r8 = load 8 r1 0 
  r1 = or r14 1 32 
  r1 = mul r1 arg1 32 
  store 8 r1 sp 0 
  r1 = load 8 sp 0 
  r3 = add r12 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r7 = load 8 r1 0 
  r1 = add r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r6 = load 8 r1 0 
  r1 = add r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r5 = load 8 r1 0 
  r1 = add r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 8 
  r1 = or r14 2 32 
  r1 = mul r1 arg1 32 
  store 8 r1 sp 16 
  r1 = load 8 sp 16 
  r3 = add r12 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 24 
  r1 = or r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 32 
  r1 = add r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 40 
  r1 = add r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 48 
  r1 = or r14 3 32 
  r1 = mul r1 arg1 32 
  store 8 r1 sp 56 
  r1 = load 8 sp 56 
  r3 = add r12 r1 32 
  r1 = mul r3 1 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 64 
  r1 = add r3 1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 72 
  r1 = add r3 2 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 80 
  r1 = add r3 3 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 88 
  r1 = mul r12 arg1 32 
  r3 = add r1 r13 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 96 
  r1 = or r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 104 
  r1 = or r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 112 
  r1 = or r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 120 
  r1 = or r12 1 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 r13 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 128 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 136 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 144 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 152 
  r1 = or r12 2 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 r13 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 160 
  r1 = or r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 168 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 176 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 184 
  r1 = or r12 3 32 
  r1 = mul r1 arg1 32 
  r3 = add r1 r13 32 
  r1 = mul r3 1 64 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 192 
  r1 = add r3 1 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 200 
  r1 = add r3 2 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 208 
  r1 = add r3 3 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  store 8 r1 sp 216 
  r1 = load 8 sp 96 
  r2 = mul r1 r11 64 
  r1 = load 8 sp 128 
  r1 = mul r1 r10 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 160 
  r1 = mul r1 r9 64 
  r2 = add r2 r1 64 
  r1 = load 8 sp 192 
  r1 = mul r1 r8 64 
  r3 = add r2 r1 64 
  r4 = add r13 r4 32 
  r1 = mul r4 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r1 = load 8 sp 104 
  r2 = mul r1 r11 64 
  r1 = load 8 sp 136 
  r1 = mul r1 r10 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 168 
  r1 = mul r1 r9 64 
  r2 = add r2 r1 64 
  r1 = load 8 sp 200 
  r1 = mul r1 r8 64 
  r3 = add r2 r1 64 
  r1 = or r4 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r1 = load 8 sp 112 
  r2 = mul r1 r11 64 
  r1 = load 8 sp 144 
  r1 = mul r1 r10 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 176 
  r1 = mul r1 r9 64 
  r2 = add r2 r1 64 
  r1 = load 8 sp 208 
  r1 = mul r1 r8 64 
  r3 = add r2 r1 64 
  r1 = or r4 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r1 = load 8 sp 120 
  r2 = mul r1 r11 64 
  r1 = load 8 sp 152 
  r1 = mul r1 r10 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 184 
  r1 = mul r1 r9 64 
  r2 = add r2 r1 64 
  r1 = load 8 sp 216 
  r1 = mul r1 r8 64 
  r3 = add r2 r1 64 
  r1 = or r4 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r1 = load 8 sp 96 
  r2 = mul r1 r7 64 
  r1 = load 8 sp 128 
  r1 = mul r1 r6 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 160 
  r1 = mul r1 r5 64 
  r3 = add r2 r1 64 
  r2 = load 8 sp 192 
  r1 = load 8 sp 8 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = load 8 sp 0 
  r4 = add r13 r1 32 
  r1 = mul r4 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r1 = load 8 sp 104 
  r2 = mul r1 r7 64 
  r1 = load 8 sp 136 
  r1 = mul r1 r6 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 168 
  r1 = mul r1 r5 64 
  r3 = add r2 r1 64 
  r2 = load 8 sp 200 
  r1 = load 8 sp 8 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = add r4 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r1 = load 8 sp 112 
  r2 = mul r1 r7 64 
  r1 = load 8 sp 144 
  r1 = mul r1 r6 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 176 
  r1 = mul r1 r5 64 
  r3 = add r2 r1 64 
  r2 = load 8 sp 208 
  r1 = load 8 sp 8 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = add r4 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r1 = load 8 sp 120 
  r2 = mul r1 r7 64 
  r1 = load 8 sp 152 
  r1 = mul r1 r6 64 
  r2 = add r1 r2 64 
  r1 = load 8 sp 184 
  r1 = mul r1 r5 64 
  r3 = add r2 r1 64 
  r2 = load 8 sp 216 
  r1 = load 8 sp 8 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = add r4 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r2 = load 8 sp 96 
  r1 = load 8 sp 24 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 128 
  r1 = load 8 sp 32 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 160 
  r1 = load 8 sp 40 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 192 
  r1 = load 8 sp 48 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = load 8 sp 16 
  r4 = add r13 r1 32 
  r1 = mul r4 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r2 = load 8 sp 104 
  r1 = load 8 sp 24 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 136 
  r1 = load 8 sp 32 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 168 
  r1 = load 8 sp 40 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 200 
  r1 = load 8 sp 48 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = or r4 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r2 = load 8 sp 112 
  r1 = load 8 sp 24 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 144 
  r1 = load 8 sp 32 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 176 
  r1 = load 8 sp 40 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 208 
  r1 = load 8 sp 48 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = add r4 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r2 = load 8 sp 120 
  r1 = load 8 sp 24 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 152 
  r1 = load 8 sp 32 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 184 
  r1 = load 8 sp 40 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 216 
  r1 = load 8 sp 48 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = add r4 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r2 = load 8 sp 96 
  r1 = load 8 sp 64 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 128 
  r1 = load 8 sp 72 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 160 
  r1 = load 8 sp 80 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 192 
  r1 = load 8 sp 88 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = load 8 sp 56 
  r4 = add r13 r1 32 
  r1 = mul r4 1 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r2 = load 8 sp 104 
  r1 = load 8 sp 64 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 136 
  r1 = load 8 sp 72 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 168 
  r1 = load 8 sp 80 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 200 
  r1 = load 8 sp 88 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = add r4 1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r2 = load 8 sp 112 
  r1 = load 8 sp 64 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 144 
  r1 = load 8 sp 72 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 176 
  r1 = load 8 sp 80 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 208 
  r1 = load 8 sp 88 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = add r4 2 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r2 = load 8 sp 120 
  r1 = load 8 sp 64 
  r3 = mul r2 r1 64 
  r2 = load 8 sp 152 
  r1 = load 8 sp 72 
  r1 = mul r2 r1 64 
  r3 = add r1 r3 64 
  r2 = load 8 sp 184 
  r1 = load 8 sp 80 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r2 = load 8 sp 216 
  r1 = load 8 sp 88 
  r1 = mul r2 r1 64 
  r3 = add r3 r1 64 
  r1 = add r4 3 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r2 = add r2 r1 64 
  r1 = load 8 r2 0 
  r1 = add r3 r1 64 
  store 8 r1 r2 0 
  r1 = add r12 4 32 
  r12 = mul r1 1 32 
  br .for.cond4 
.for.end:
  r1 = add r13 4 32 
  r13 = mul r1 1 32 
  br .for.cond1 
.for.end422:
  r1 = add r14 4 32 
  r14 = mul r1 1 32 
  br .for.cond 
.for.end425:
  sp = add sp 224 64 
  ret 0 
end matmul

start read_mat 2:
.entry:
  r5 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp ult r5 arg1 32 
  br r1 .for.body .for.end6 
.for.body:
  r4 = mul 0 1 32 
  br .for.cond1 
.for.cond1:
  r1 = icmp ult r4 arg1 32 
  br r1 .for.body3 .for.end 
.for.body3:
  r3 = call read 
  r1 = mul r5 arg1 32 
  r1 = add r4 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r4 1 32 
  r4 = mul r1 1 32 
  br .for.cond1 
.for.end:
  r1 = add r5 1 32 
  r5 = mul r1 1 32 
  br .for.cond 
.for.end6:
  ret 0 
end read_mat

start print_mat 2:
.entry:
  r4 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp ult r4 arg1 32 
  br r1 .for.body .for.end6 
.for.body:
  r3 = mul 0 1 32 
  br .for.cond1 
.for.cond1:
  r1 = icmp ult r3 arg1 32 
  br r1 .for.body3 .for.end 
.for.body3:
  r1 = mul r4 arg1 32 
  r1 = add r3 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r3 1 32 
  r3 = mul r1 1 32 
  br .for.cond1 
.for.end:
  r1 = add r4 1 32 
  r4 = mul r1 1 32 
  br .for.cond 
.for.end6:
  ret 0 
end print_mat

start main 0:
.entry:
  r2 = call read 
  r5 = mul r2 1 32 
  r1 = urem r5 4 32 
  r1 = icmp eq r1 0 32 
  br r1 .if.end .if.then 
.if.then:
  br .cleanup 
.if.end:
  r1 = mul r2 8 64 
  r1 = mul r1 r2 64 
  r2 = and r1 34359738360 64 
  r4 = malloc r2 
  r3 = malloc r2 
  r1 = malloc r2 
  call read_mat r5 r4 
  call read_mat r5 r3 
  call matmul r5 r1 r4 r3 
  call print_mat r5 r1 
  br .cleanup 
.cleanup:
  ret 0 
end main

