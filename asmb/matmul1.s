start matmul 4:
.entry:
  r7 = mul 0 1 32 
  br .for.cond 
.for.cond:
  r1 = icmp ult r7 arg1 32 
  br r1 .for.body .for.end22 
.for.body:
  r6 = mul 0 1 32 
  br .for.cond1 
.for.cond1:
  r1 = icmp ult r6 arg1 32 
  br r1 .for.body3 .for.end19 
.for.body3:
  r5 = mul 0 1 32 
  r4 = mul 0 1 64 
  br .for.cond4 
.for.cond4:
  r1 = icmp ult r5 arg1 32 
  br r1 .for.body6 .for.end 
.for.body6:
  r1 = mul r7 arg1 32 
  r1 = add r5 r1 32 
  r2 = mul arg3 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r1 = mul r5 arg1 32 
  r1 = add r1 r6 32 
  r2 = mul arg4 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r1 = mul r1 r3 64 
  r2 = add r1 r4 64 
  r1 = add r5 1 32 
  r4 = mul r2 1 64 
  r5 = mul r1 1 32 
  br .for.cond4 
.for.end:
  r1 = mul r7 arg1 32 
  r1 = add r6 r1 32 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r1 = add r2 r1 64 
  store 8 r4 r1 0 
  r1 = add r6 1 32 
  r6 = mul r1 1 32 
  br .for.cond1 
.for.end19:
  r1 = add r7 1 32 
  r7 = mul r1 1 32 
  br .for.cond 
.for.end22:
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
  r1 = mul r2 8 64 
  r1 = mul r1 r2 64 
  r4 = and r1 34359738360 64 
  r3 = malloc r4 
  r2 = malloc r4 
  r1 = malloc r4 
  call read_mat r5 r3 
  call read_mat r5 r2 
  call matmul r5 r1 r3 r2 
  call print_mat r5 r1 
  ret 0 
end main

