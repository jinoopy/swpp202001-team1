start insert 2:
.entry:
  r6 = mul arg1 1 64 
  r5 = mul 0 1 64 
  br .while.cond 
.while.cond:
  r2 = load 8 r6 0 
  r1 = icmp ugt r2 arg2 64 
  br r1 .if.then .if.else 
.if.then:
  r2 = mul r6 1 64 
  r1 = mul 1 8 64 
  r4 = add r2 r1 64 
  r1 = mul r4 1 64 
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  br r1 .if.then2 .if.end 
.if.then2:
  r3 = malloc 24 
  r1 = mul r3 1 64 
  store 8 arg2 r1 0 
  r2 = mul r3 1 64 
  r1 = mul 8 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r2 = mul r3 1 64 
  r1 = mul 16 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r1 = mul r3 1 64 
  store 8 r1 r4 0 
  r2 = mul r6 1 64 
  r3 = mul 1 1 32 
  r1 = mul 1 1 64 
  br .cleanup 
.if.end:
  r1 = mul r5 1 64 
  r3 = mul 2 1 32 
  br .cleanup 
.if.else:
  r1 = icmp ult r2 arg2 64 
  br r1 .if.then7 .if.else17 
.if.then7:
  r2 = mul r6 1 64 
  r1 = mul 2 8 64 
  r4 = add r2 r1 64 
  r1 = mul r4 1 64 
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  br r1 .if.then10 .if.end16 
.if.then10:
  r3 = malloc 24 
  r1 = mul r3 1 64 
  store 8 arg2 r1 0 
  r2 = mul r3 1 64 
  r1 = mul 8 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r2 = mul r3 1 64 
  r1 = mul 16 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r1 = mul r3 1 64 
  store 8 r1 r4 0 
  r2 = mul r6 1 64 
  r3 = mul 1 1 32 
  r1 = mul 1 1 64 
  br .cleanup 
.if.end16:
  r1 = mul r5 1 64 
  r3 = mul 2 1 32 
  br .cleanup 
.if.else17:
  r2 = mul r6 1 64 
  r3 = mul 1 1 32 
  r1 = mul 0 1 64 
  br .cleanup 
.cleanup:
  r5 = mul r1 1 64 
  r6 = mul r2 1 64 
switch r3 2 .while.cond .cleanup19
.cleanup19:
  ret r1 
end insert

start adjust 1:
.entry:
  r2 = mul arg1 1 64 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  br r1 .if.then .if.end 
.if.then:
  r2 = mul arg1 1 64 
  r1 = mul 2 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  br .cleanup 
.if.end:
  r5 = mul r2 1 64 
  br .while.cond 
.while.cond:
  r2 = mul r5 1 64 
  r1 = mul 2 8 64 
  r1 = add r2 r1 64 
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  br r1 .while.end .while.body 
.while.body:
  r4 = mul r5 1 64 
  r5 = mul r2 1 64 
  br .while.cond 
.while.end:
  r1 = icmp eq r4 0 64 
  br r1 .if.end9 .if.then6 
.if.then6:
  r2 = mul r5 1 64 
  r1 = mul 1 8 64 
  r1 = add r2 r1 64 
  r3 = load 8 r1 0 
  r2 = mul r4 1 64 
  r1 = mul 2 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  br .if.end9 
.if.end9:
  r1 = mul r5 1 64 
  br .cleanup 
.cleanup:
  ret r1 
end adjust

start remove 2:
.entry:
  r1 = load 8 arg1 0 
  r1 = icmp eq r1 arg2 64 
  br r1 .if.then .if.end 
.if.then:
  r1 = mul 0 1 64 
  br .cleanup24 
.if.end:
  r5 = mul arg1 1 64 
  r4 = mul 0 1 64 
  br .while.cond 
.while.cond:
  r2 = load 8 r5 0 
  r1 = icmp ugt r2 arg2 64 
  br r1 .if.then2 .if.else 
.if.then2:
  r2 = mul r5 1 64 
  r1 = mul 1 8 64 
  r3 = add r2 r1 64 
  r1 = mul r3 1 64 
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  br r1 .if.then4 .if.end5 
.if.then4:
  r2 = mul r5 1 64 
  r3 = mul 1 1 32 
  r1 = mul 0 1 64 
  br .cleanup 
.if.end5:
  r1 = load 8 r2 0 
  r1 = icmp eq r1 arg2 64 
  br r1 .if.then7 .if.end9 
.if.then7:
  r1 = call adjust r2 
  store 8 r1 r3 0 
  r1 = mul r2 1 64 
  free r1 
  r2 = mul r5 1 64 
  r3 = mul 1 1 32 
  r1 = mul 1 1 64 
  br .cleanup 
.if.end9:
  r1 = mul r4 1 64 
  r3 = mul 2 1 32 
  br .cleanup 
.if.else:
  r1 = icmp ult r2 arg2 64 
  br r1 .if.then11 .if.end21 
.if.then11:
  r2 = mul r5 1 64 
  r1 = mul 2 8 64 
  r3 = add r2 r1 64 
  r1 = mul r3 1 64 
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  br r1 .if.then14 .if.end15 
.if.then14:
  r2 = mul r5 1 64 
  r3 = mul 1 1 32 
  r1 = mul 0 1 64 
  br .cleanup 
.if.end15:
  r1 = load 8 r2 0 
  r1 = icmp eq r1 arg2 64 
  br r1 .if.then17 .if.end20 
.if.then17:
  r1 = call adjust r2 
  store 8 r1 r3 0 
  r1 = mul r2 1 64 
  free r1 
  r2 = mul r5 1 64 
  r3 = mul 1 1 32 
  r1 = mul 1 1 64 
  br .cleanup 
.if.end20:
  r1 = mul r4 1 64 
  r3 = mul 2 1 32 
  br .cleanup 
.if.end21:
  r1 = mul r4 1 64 
  r2 = mul r5 1 64 
  r3 = mul 0 1 32 
  br .cleanup 
.cleanup:
  r4 = mul r1 1 64 
  r5 = mul r2 1 64 
switch r3 0 .cleanup.cont 2 .while.cond .cleanup24
.cleanup.cont:
  r4 = mul r1 1 64 
  r5 = mul r2 1 64 
  br .while.cond 
.cleanup24:
  ret r1 
end remove

start traverse 1:
.entry:
  r2 = mul arg1 1 64 
  br .tailrecurse 
.tailrecurse:
  r1 = icmp eq r2 0 64 
  br r1 .if.then .if.end 
.if.then:
  ret 0 
.if.end:
  r4 = load 8 r2 0 
  r3 = mul r2 1 64 
  r1 = mul 1 8 64 
  r1 = add r3 r1 64 
  r3 = load 8 r1 0 
  r1 = mul 2 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  call traverse r3 
  call write r4 
  r2 = mul r1 1 64 
  br .tailrecurse 
end traverse

start main 0:
.entry:
  r2 = malloc 24 
  r5 = mul r2 1 64 
  r1 = call read 
  store 8 r1 r5 0 
  r3 = mul r2 1 64 
  r1 = mul 8 1 64 
  r1 = add r3 r1 64 
  store 8 0 r1 0 
  r1 = mul 16 1 64 
  r1 = add r2 r1 64 
  store 8 0 r1 0 
  r4 = call read 
  r3 = mul 0 1 64 
  br .for.cond 
.for.cond:
  r1 = icmp ult r3 r4 64 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  call traverse r5 
  ret 0 
.for.body:
  r1 = call read 
  r2 = call read 
  r1 = icmp eq r1 0 64 
  br r1 .if.then .if.else 
.if.then:
  r1 = call insert r5 r2 
  br .if.end 
.if.else:
  r1 = call remove r5 r2 
  br .if.end 
.if.end:
  r1 = add r3 1 64 
  r3 = mul r1 1 64 
  br .for.cond 
end main

