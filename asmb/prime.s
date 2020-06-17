start check_with_primes 1:
.entry:
  r1 = load 8 20480 0 
  r3 = mul r1 1 64 
  br .while.cond 
.while.cond:
  r1 = icmp eq r3 0 64 
  br r1 .while.end .while.body 
.while.body:
  r2 = load 8 r3 0 
  r1 = mul r2 r2 64 
  r1 = icmp ugt r1 arg1 64 
  br r1 .if.then .if.end 
.if.then:
  r2 = mul 3 1 32 
  br .cleanup 
.if.end:
  r1 = urem arg1 r2 64 
  r1 = icmp eq r1 0 64 
  br r1 .if.then3 .if.end4 
.if.then3:
  r2 = mul 1 1 32 
  br .cleanup 
.if.end4:
  r2 = mul r3 1 64 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  r3 = mul r1 1 64 
  r2 = mul 0 1 32 
  br .cleanup 
.cleanup:
  r1 = mul 0 1 64 
switch r2 0 .cleanup.cont 3 .while.end .cleanup5
.cleanup.cont:
  br .while.cond 
.while.end:
  r1 = mul 1 1 64 
  br .cleanup5 
.cleanup5:
  ret r1 
end check_with_primes

start add_primes 1:
.entry:
  br .while.cond 
.while.cond:
  r2 = load 8 20480 8 
  r1 = mul r2 r2 64 
  r1 = icmp ult r1 arg1 64 
  br r1 .while.body .while.end 
.while.body:
  r1 = add r2 1 64 
  store 8 r1 20480 8 
  r1 = call check_with_primes r1 
  r1 = icmp eq r1 0 64 
  br r1 .if.end5 .if.then 
.if.then:
  r5 = malloc 16 
  r1 = mul r5 1 64 
  r4 = load 8 20480 8 
  store 8 r4 r1 0 
  r2 = mul r5 1 64 
  r1 = mul 8 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r3 = mul r5 1 64 
  r2 = load 8 20480 16 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add 20480 16 64 
  store 8 r5 r1 0 
  r1 = urem arg1 r4 64 
  r1 = icmp eq r1 0 64 
  br r1 .if.then4 .if.end 
.if.then4:
  r2 = mul 1 1 1 
  br .cleanup 
.if.end:
  r2 = mul 0 1 1 
  br .cleanup 
.cleanup:
  r1 = mul 0 1 64 
switch r2 0 .cleanup.cont 1 .return .unreachable
.cleanup.cont:
  br .if.end5 
.if.end5:
  br .while.cond 
.while.end:
  r1 = mul 1 1 64 
  br .return 
.return:
  ret r1 
.unreachable:
  ret 0 
end add_primes

start is_prime 1:
.entry:
  r1 = call check_with_primes arg1 
  r1 = icmp eq r1 0 64 
  br r1 .if.then .if.end 
.if.then:
  r1 = mul 0 1 64 
  br .return 
.if.end:
  r1 = call add_primes arg1 
  br .return 
.return:
  ret r1 
end is_prime

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 8 
  r1 = malloc 8 
  r1 = malloc 8 
  r3 = malloc 16 
  r2 = mul r3 1 64 
  r1 = add 20480 0 64 
  store 8 r3 r1 0 
  store 8 2 r2 0 
  r2 = mul r3 1 64 
  r1 = mul 8 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r1 = add 20480 16 64 
  store 8 r3 r1 0 
  store 8 2 20480 8 
  br .while.body 
.while.body:
  r2 = call read 
  r1 = icmp eq r2 0 64 
  br r1 .if.then .if.end 
.if.then:
  r1 = mul 3 1 32 
  br .cleanup 
.if.end:
  r1 = call is_prime r2 
  call write r1 
  r1 = mul 0 1 32 
  br .cleanup 
.cleanup:
switch r1 0 .cleanup.cont 3 .while.end .unreachable
.cleanup.cont:
  br .while.body 
.while.end:
  ret 0 
.unreachable:
  ret 0 
end main

