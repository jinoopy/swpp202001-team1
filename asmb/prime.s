start check_with_primes 1:
.entry:
  r1 = load 8 20480 0 
  r5 = mul r1 1 64 
  br .while.cond 
.while.cond:
  r2 = icmp eq r5 0 64 
  r1 = mul 1 1 64 
  br r2 .cleanup5 .while.body 
.while.body:
  r3 = load 8 r5 0 
  r1 = mul r3 r3 64 
  r2 = icmp ugt r1 arg1 64 
  r1 = mul r5 1 64 
  r4 = mul 3 1 32 
  br r2 .cleanup .if.end 
.if.end:
  r1 = urem arg1 r3 64 
  r2 = icmp eq r1 0 64 
  r1 = mul r5 1 64 
  r4 = mul 1 1 32 
  br r2 .cleanup .if.end4 
.if.end4:
  r2 = mul r5 1 64 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r4 = mul 0 1 32 
  br .cleanup 
.cleanup:
  r5 = mul r1 1 64 
  r1 = mul 1 1 64 
  switch r4 0 .while.cond 3 .cleanup5 .cleanup5.loopexit
.cleanup5.loopexit:
  r1 = mul 0 1 64 
  br .cleanup5 
.cleanup5:
  ret r1 
end check_with_primes

start add_primes 1:
.entry:
  r2 = load 8 20480 8 
  r1 = mul r2 r2 64 
  r1 = icmp ult r1 arg1 64 
  r3 = mul 1 1 64 
  br r1 .while.body.lr.ph .return 
.while.body.lr.ph:
  r7 = load 8 20480 0 
  br .while.body 
.while.body:
  r6 = add r2 1 64 
  store 8 r6 20480 8 
  r5 = mul r7 1 64 
  br .while.cond.i 
.while.cond.i:
  r1 = icmp eq r5 0 64 
  br r1 .while.end.i .while.body.i 
.while.body.i:
  r4 = load 8 r5 0 
  r1 = mul r4 r4 64 
  r2 = icmp ugt r1 r6 64 
  r1 = mul r5 1 64 
  r3 = mul 3 1 32 
  br r2 .cleanup.i .if.end.i 
.if.end.i:
  r1 = urem r6 r4 64 
  r2 = icmp eq r1 0 64 
  r1 = mul r5 1 64 
  r3 = mul 1 1 32 
  br r2 .cleanup.i .if.end4.i 
.if.end4.i:
  r2 = mul r5 1 64 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r3 = mul 0 1 32 
  br .cleanup.i 
.cleanup.i:
  r5 = mul r1 1 64 
  switch r3 0 .while.cond.i 3 .while.end.i .if.end5
.while.end.i:
  r4 = malloc 16 
  r1 = mul r4 1 64 
  store 8 r6 r1 0 
  r2 = mul r4 1 64 
  r1 = mul 8 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r3 = mul r4 1 64 
  r2 = load 8 20480 16 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add 20480 16 64 
  store 8 r4 r1 0 
  r1 = urem arg1 r6 64 
  r1 = icmp eq r1 0 64 
  r3 = mul 0 1 64 
  br r1 .return .if.end5 
.if.end5:
  r1 = mul r6 r6 64 
  r1 = icmp ult r1 arg1 64 
  r2 = mul r6 1 64 
  r3 = mul 1 1 64 
  br r1 .while.body .return 
.return:
  ret r3 
end add_primes

start is_prime 1:
.entry:
  r7 = load 8 20480 0 
  r5 = mul r7 1 64 
  br .while.cond.i 
.while.cond.i:
  r1 = icmp eq r5 0 64 
  br r1 .while.end.i .while.body.i 
.while.body.i:
  r3 = load 8 r5 0 
  r1 = mul r3 r3 64 
  r2 = icmp ugt r1 arg1 64 
  r1 = mul r5 1 64 
  r4 = mul 3 1 32 
  br r2 .cleanup.i .if.end.i 
.if.end.i:
  r1 = urem arg1 r3 64 
  r2 = icmp eq r1 0 64 
  r1 = mul r5 1 64 
  r4 = mul 1 1 32 
  br r2 .cleanup.i .if.end4.i 
.if.end4.i:
  r2 = mul r5 1 64 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r4 = mul 0 1 32 
  br .cleanup.i 
.cleanup.i:
  r5 = mul r1 1 64 
  r3 = mul 0 1 64 
  switch r4 0 .while.cond.i 3 .while.end.i .return
.while.end.i:
  r2 = load 8 20480 8 
  r1 = mul r2 r2 64 
  r1 = icmp ult r1 arg1 64 
  r3 = mul 1 1 64 
  br r1 .while.body.i5.lr.ph .return 
.while.body.i5.lr.ph:
  br .while.body.i5 
.while.body.i5:
  r6 = add r2 1 64 
  store 8 r6 20480 8 
  r5 = mul r7 1 64 
  br .while.cond.i.i 
.while.cond.i.i:
  r1 = icmp eq r5 0 64 
  br r1 .while.end.i.i .while.body.i.i 
.while.body.i.i:
  r4 = load 8 r5 0 
  r1 = mul r4 r4 64 
  r2 = icmp ugt r1 r6 64 
  r1 = mul r5 1 64 
  r3 = mul 3 1 32 
  br r2 .cleanup.i.i .if.end.i.i 
.if.end.i.i:
  r1 = urem r6 r4 64 
  r2 = icmp eq r1 0 64 
  r1 = mul r5 1 64 
  r3 = mul 1 1 32 
  br r2 .cleanup.i.i .if.end4.i.i 
.if.end4.i.i:
  r2 = mul r5 1 64 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r3 = mul 0 1 32 
  br .cleanup.i.i 
.cleanup.i.i:
  r5 = mul r1 1 64 
  switch r3 0 .while.cond.i.i 3 .while.end.i.i .if.end5.i
.while.end.i.i:
  r4 = malloc 16 
  r1 = mul r4 1 64 
  store 8 r6 r1 0 
  r2 = mul r4 1 64 
  r1 = mul 8 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r3 = mul r4 1 64 
  r2 = load 8 20480 16 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add 20480 16 64 
  store 8 r4 r1 0 
  r1 = urem arg1 r6 64 
  r1 = icmp eq r1 0 64 
  r3 = mul 0 1 64 
  br r1 .return .if.end5.i 
.if.end5.i:
  r1 = mul r6 r6 64 
  r1 = icmp ult r1 arg1 64 
  r2 = mul r6 1 64 
  r3 = mul 1 1 64 
  br r1 .while.body.i5 .return 
.return:
  ret r3 
end is_prime

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 8 
  r1 = malloc 8 
  r1 = malloc 8 
  r3 = malloc 16 
  r1 = mul r3 1 64 
  r2 = add 20480 0 64 
  store 8 r3 r2 0 
  store 8 2 r1 0 
  r2 = mul r3 1 64 
  r1 = mul 8 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r1 = add 20480 16 64 
  store 8 r3 r1 0 
  store 8 2 20480 8 
  r1 = call read 
  r2 = icmp eq r1 0 64 
  br r2 .while.end .if.end 
.if.end:
  r1 = call is_prime r1 
  call write r1 
  r1 = call read 
  r2 = icmp eq r1 0 64 
  br r2 .while.end .if.end 
.while.end:
  ret 0 
end main

