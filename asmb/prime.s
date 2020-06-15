start main 0:
.entry:
  ; Init global variables
  r1 = malloc 8 
  r1 = malloc 8 
  ; Init stack pointer
  sp = sub sp 8 64 
  r3 = malloc 16 
  r2 = mul r3 1 64 
  r1 = add 20480 0 64 
  store 8 r3 r1 0 
  store 8 2 r2 0 
  r1 = mul r3 1 64 
  r1 = add r1 8 64 
  store 8 0 r1 0 
  r1 = add 20480 8 64 
  store 8 r3 r1 0 
  store 8 2 sp 0 
  r2 = call read 
  r1 = icmp eq r2 0 64 
  r3 = mul r2 1 64 
  br r1 .while.end .if.end 
.if.end:
  r1 = add sp 0 64 
  r1 = call is_prime.3 r3 r1 
  call write r1 
  r1 = call read 
  r2 = icmp eq r1 0 64 
  r3 = mul r1 1 64 
  br r2 .while.end .if.end 
.while.end:
  sp = add sp 8 64 
  ret 0 
end main

start check_with_primes.1 2:
.entry:
  r1 = load 8 20480 0 
  r4 = mul r1 1 64 
  br .while.cond 
.while.cond:
  r1 = icmp eq r4 0 64 
  br r1 .cleanup5.loopexit1 .while.body 
.while.body:
  r3 = load 8 r4 0 
  r1 = mul r3 r3 64 
  r2 = icmp ugt r1 arg1 64 
  r1 = mul r4 1 64 
  r3 = mul 3 1 32 
  br r2 .cleanup .if.end 
.if.end:
  r1 = urem arg1 r3 64 
  r2 = icmp eq r1 0 64 
  r1 = mul r4 1 64 
  r3 = mul 1 1 32 
  br r2 .cleanup .if.end4 
.if.end4:
  r1 = mul r4 1 64 
  r1 = add r1 8 64 
  r1 = load 8 r1 0 
  r3 = mul 0 1 32 
  br .cleanup 
.cleanup:
  r1 = mul 0 1 64 
switch r3 0 .while.cond 3 .cleanup5.loopexit1 .cleanup5
.cleanup5.loopexit1:
  r1 = mul 1 1 64 
  br .cleanup5 
.cleanup5:
  ret r1 
end check_with_primes.1

start add_primes.2 2:
.entry:
  r2 = load 8 arg2 0 
  r1 = mul r2 r2 64 
  r1 = icmp ult r1 arg1 64 
  r3 = mul 1 1 64 
  br r1 .while.body .return 
.while.body:
  r4 = add r2 1 64 
  store 8 r4 arg2 0 
  r1 = load 8 20480 0 
  r6 = mul r1 1 64 
  br .while.cond.i 
.while.cond.i:
  r1 = icmp eq r6 0 64 
  br r1 .while.end.i .while.body.i 
.while.body.i:
  r2 = load 8 r6 0 
  r1 = mul r2 r2 64 
  r3 = icmp ugt r1 r4 64 
  r1 = mul r6 1 64 
  r5 = mul 3 1 32 
  br r3 .cleanup.i .if.end.i 
.if.end.i:
  r1 = urem r4 r2 64 
  r2 = icmp eq r1 0 64 
  r1 = mul r6 1 64 
  r5 = mul 1 1 32 
  br r2 .cleanup.i .if.end4.i 
.if.end4.i:
  r1 = mul r6 1 64 
  r1 = add r1 8 64 
  r1 = load 8 r1 0 
  r5 = mul 0 1 32 
  br .cleanup.i 
.cleanup.i:
switch r5 0 .while.cond.i 3 .while.end.i .if.end5
.while.end.i:
  r3 = malloc 16 
  r1 = mul r3 1 64 
  store 8 r4 r1 0 
  r1 = mul r3 1 64 
  r1 = add r1 8 64 
  store 8 0 r1 0 
  r2 = mul r3 1 64 
  r1 = add 20480 8 64 
  r1 = load 8 r1 0 
  r1 = add r1 8 64 
  store 8 r2 r1 0 
  r1 = add 20480 8 64 
  store 8 r3 r1 0 
  r2 = load 8 arg2 0 
  r1 = urem arg1 r2 64 
  r1 = icmp eq r1 0 64 
  r3 = mul 0 1 64 
  br r1 .return .if.end5 
.if.end5:
  r1 = mul r2 r2 64 
  r1 = icmp ult r1 arg1 64 
  r3 = mul 1 1 64 
  br r1 .while.body .return 
.return:
  ret r3 
end add_primes.2

start is_prime.3 2:
.entry:
  r1 = load 8 20480 0 
  r5 = mul r1 1 64 
  br .while.cond.i 
.while.cond.i:
  r1 = icmp eq r5 0 64 
  br r1 .while.end.i .while.body.i 
.while.body.i:
  r2 = load 8 r5 0 
  r1 = mul r2 r2 64 
  r3 = icmp ugt r1 arg1 64 
  r1 = mul r5 1 64 
  r4 = mul 3 1 32 
  br r3 .cleanup.i .if.end.i 
.if.end.i:
  r1 = urem arg1 r2 64 
  r2 = icmp eq r1 0 64 
  r1 = mul r5 1 64 
  r4 = mul 1 1 32 
  br r2 .cleanup.i .if.end4.i 
.if.end4.i:
  r1 = mul r5 1 64 
  r1 = add r1 8 64 
  r1 = load 8 r1 0 
  r4 = mul 0 1 32 
  br .cleanup.i 
.cleanup.i:
  r3 = mul 0 1 64 
switch r4 0 .while.cond.i 3 .while.end.i .return
.while.end.i:
  r2 = load 8 arg2 0 
  r1 = mul r2 r2 64 
  r4 = icmp ult r1 arg1 64 
  r1 = mul r2 1 64 
  r3 = mul 1 1 64 
  br r4 .while.body.i4 .return 
.while.body.i4:
  r4 = add r1 1 64 
  store 8 r4 arg2 0 
  r1 = load 8 20480 0 
  r5 = mul r1 1 64 
  br .while.cond.i.i 
.while.cond.i.i:
  r1 = icmp eq r5 0 64 
  br r1 .while.end.i.i .while.body.i.i 
.while.body.i.i:
  r3 = load 8 r5 0 
  r1 = mul r3 r3 64 
  r2 = icmp ugt r1 r4 64 
  r1 = mul r5 1 64 
  r3 = mul 3 1 32 
  br r2 .cleanup.i.i .if.end.i.i 
.if.end.i.i:
  r1 = urem r4 r3 64 
  r2 = icmp eq r1 0 64 
  r1 = mul r5 1 64 
  r3 = mul 1 1 32 
  br r2 .cleanup.i.i .if.end4.i.i 
.if.end4.i.i:
  r1 = mul r5 1 64 
  r1 = add r1 8 64 
  r1 = load 8 r1 0 
  r3 = mul 0 1 32 
  br .cleanup.i.i 
.cleanup.i.i:
switch r3 0 .while.cond.i.i 3 .while.end.i.i .if.end5.i
.while.end.i.i:
  r3 = malloc 16 
  r1 = mul r3 1 64 
  store 8 r4 r1 0 
  r1 = mul r3 1 64 
  r1 = add r1 8 64 
  store 8 0 r1 0 
  r2 = mul r3 1 64 
  r1 = add 20480 8 64 
  r1 = load 8 r1 0 
  r1 = add r1 8 64 
  store 8 r2 r1 0 
  r1 = add 20480 8 64 
  store 8 r3 r1 0 
  r2 = load 8 arg2 0 
  r1 = urem arg1 r2 64 
  r1 = icmp eq r1 0 64 
  r4 = mul r2 1 64 
  r3 = mul 0 1 64 
  br r1 .return .if.end5.i 
.if.end5.i:
  r1 = mul r4 r4 64 
  r2 = icmp ult r1 arg1 64 
  r1 = mul r4 1 64 
  r3 = mul 1 1 64 
  br r2 .while.body.i4 .return 
.return:
  ret r3 
end is_prime.3

