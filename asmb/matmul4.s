start copy_mask 5:
.entry:
  r7 = mul 0 1 64 
  br .for.cond 
.for.cond:
  r1 = icmp eq r7 4 64 
  br r1 .for.end19 .for.body 
.for.body:
  r1 = mul r7 1 32 
  r1 = add r1 arg2 32 
  r1 = mul r1 arg1 32 
  r6 = add r1 arg3 32 
  r5 = mul r7 4 64 
  r4 = mul 0 1 64 
  br .for.cond2 
.for.cond2:
  r1 = icmp eq r4 4 64 
  br r1 .for.end .for.body6 
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
  r4 = mul r1 1 64 
  br .for.cond2 
.for.end:
  r1 = add r7 1 64 
  r7 = mul r1 1 64 
  br .for.cond 
.for.end19:
  ret 0 
end copy_mask

start add_mask 5:
.entry:
  r7 = mul 0 1 64 
  br .for.cond 
.for.cond:
  r1 = icmp eq r7 4 64 
  br r1 .for.end20 .for.body 
.for.body:
  r6 = mul r7 4 64 
  r1 = mul r7 1 32 
  r1 = add r1 arg2 32 
  r1 = mul r1 arg1 32 
  r5 = add r1 arg3 32 
  r4 = mul 0 1 64 
  br .for.cond2 
.for.cond2:
  r1 = icmp eq r4 4 64 
  br r1 .for.end .for.body6 
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
  r4 = mul r1 1 64 
  br .for.cond2 
.for.end:
  r1 = add r7 1 64 
  r7 = mul r1 1 64 
  br .for.cond 
.for.end20:
  ret 0 
end add_mask

start mask_mul 3:
.entry:
  r8 = mul 0 1 64 
  br .for.cond 
.for.cond:
  r1 = icmp eq r8 4 64 
  br r1 .for.end33 .for.body 
.for.body:
  r7 = mul r8 4 64 
  r6 = mul 0 1 64 
  br .for.cond2 
.for.cond2:
  r1 = icmp eq r6 4 64 
  br r1 .for.end30 .for.body6 
.for.body6:
  r4 = mul 0 1 64 
  r5 = mul 0 1 64 
  br .for.cond7 
.for.cond7:
  r1 = icmp eq r4 4 64 
  br r1 .for.end .for.body11 
.for.body11:
  r1 = add r4 r7 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r1 = mul r4 4 64 
  r1 = add r1 r6 64 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r2 = add r1 r5 64 
  r1 = add r4 1 64 
  r4 = mul r1 1 64 
  r5 = mul r2 1 64 
  br .for.cond7 
.for.end:
  r1 = add r6 r7 64 
  r2 = mul arg1 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r5 r1 0 
  r1 = add r6 1 64 
  r6 = mul r1 1 64 
  br .for.cond2 
.for.end30:
  r1 = add r8 1 64 
  r8 = mul r1 1 64 
  br .for.cond 
.for.end33:
  ret 0 
end mask_mul

start matmul 4:
.entry:
  ; Init stack pointer
  sp = sub sp 384 64 
  r2 = add sp 128 64 
  r1 = mul 0 128 64 
  r2 = add r2 r1 64 
  r1 = mul 0 8 64 
  r7 = add r2 r1 64 
  r2 = add sp 256 64 
  r1 = mul 0 128 64 
  r2 = add r2 r1 64 
  r1 = mul 0 8 64 
  r6 = add r2 r1 64 
  r2 = add sp 0 64 
  r1 = mul 0 128 64 
  r2 = add r2 r1 64 
  r1 = mul 0 8 64 
  r5 = add r2 r1 64 
  r4 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp ult r4 arg1 32 
  br r1 .for.body .for.end17 
.for.body:
  r3 = mul 0 1 32 
  br .for.cond1 
.for.cond1:
  r1 = icmp ult r3 arg1 32 
  br r1 .for.body3 .for.end14 
.for.body3:
  r2 = mul 0 1 32 
  br .for.cond4 
.for.cond4:
  r1 = icmp ult r2 arg1 32 
  br r1 .for.body6 .for.end 
.for.body6:
  call copy_mask arg1 r4 r2 arg3 r7 
  call copy_mask arg1 r2 r3 arg4 r6 
  call mask_mul r5 r7 r6 
  call add_mask arg1 r4 r3 arg2 r5 
  r1 = add r2 4 32 
  r2 = mul r1 1 32 
  br .for.cond4 
.for.end:
  r1 = add r3 4 32 
  r3 = mul r1 1 32 
  br .for.cond1 
.for.end14:
  r1 = add r4 4 32 
  r4 = mul r1 1 32 
  br .for.cond 
.for.end17:
  sp = add sp 384 64 
  ret 0 
end matmul

start read_mat 2:
.entry:
  r7 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp eq r7 arg1 32 
  br r1 .for.end6 .for.body 
.for.body:
  r5 = mul r7 arg1 32 
  r6 = mul arg1 1 64 
  r4 = mul 0 1 64 
  br .for.cond1 
.for.cond1:
  r1 = icmp eq r4 r6 64 
  br r1 .for.end .for.body3 
.for.body3:
  r3 = call read 
  r1 = mul r4 1 32 
  r1 = add r5 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r4 = mul r1 1 64 
  br .for.cond1 
.for.end:
  r1 = add r7 1 32 
  r7 = mul r1 1 32 
  br .for.cond 
.for.end6:
  ret 0 
end read_mat

start print_mat 2:
.entry:
  r6 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp eq r6 arg1 32 
  br r1 .for.end6 .for.body 
.for.body:
  r4 = mul r6 arg1 32 
  r5 = mul arg1 1 64 
  r3 = mul 0 1 64 
  br .for.cond1 
.for.cond1:
  r1 = icmp eq r3 r5 64 
  br r1 .for.end .for.body3 
.for.body3:
  r1 = mul r3 1 32 
  r1 = add r4 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r3 1 64 
  r3 = mul r1 1 64 
  br .for.cond1 
.for.end:
  r1 = add r6 1 32 
  r6 = mul r1 1 32 
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

