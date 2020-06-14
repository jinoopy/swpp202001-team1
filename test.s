start insert 2:
.entry:
  r7 = mul arg1 1 64 
  r6 = mul 0 1 64 
  br .while.cond 
.while.cond:
  r2 = load 8 r7 0 
  r1 = icmp ugt r2 arg2 64 
  br r1 .if.then .if.else 
.if.then:
  r1 = mul r4 1 64 
  r1 = load 8 r1 0 
  r3 = icmp eq r1 0 64 
  r2 = mul r1 1 64 
  r1 = mul r6 1 64 
  r5 = mul 1 1 1 
  br r3 .if.then2 .cleanup 
.if.then2:
  r2 = malloc 24 
  r1 = mul r2 1 64 
  store arg2 8 r1 0 
  store 0 8 r1 0 
  store 0 8 r1 0 
  r1 = mul r2 1 64 
  store r1 8 r4 0 
  r2 = mul r7 1 64 
  r5 = mul 0 1 1 
  r1 = mul 1 1 64 
  br .cleanup 
.if.else:
  r3 = icmp ult r2 arg2 64 
  r2 = mul r7 1 64 
  r5 = mul 0 1 1 
  r1 = mul 0 1 64 
  br r3 .if.then7 .cleanup 
.if.then7:
  r1 = mul r3 1 64 
  r1 = load 8 r1 0 
  r4 = icmp eq r1 0 64 
  r2 = mul r1 1 64 
  r1 = mul r6 1 64 
  r5 = mul 1 1 1 
  br r4 .if.then10 .cleanup 
.if.then10:
  r2 = malloc 24 
  r1 = mul r2 1 64 
  store arg2 8 r1 0 
  store 0 8 r1 0 
  store 0 8 r1 0 
  r1 = mul r2 1 64 
  store r1 8 r3 0 
  r2 = mul r7 1 64 
  r5 = mul 0 1 1 
  r1 = mul 1 1 64 
  br .cleanup 
.cleanup:
  r6 = mul r1 1 64 
  r7 = mul r2 1 64 
  br r5 .while.cond .cleanup19 
.cleanup19:
  sp = add sp 0 64 
  ret r1 
end insert

start adjust 1:
.entry:
  r1 = mul arg1 1 64 
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  r4 = mul r2 1 64 
  br r1 .if.then .while.cond 
.if.then:
  r1 = mul arg1 1 64 
  r1 = load 8 r1 0 
  br .cleanup 
.while.cond:
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  r3 = mul r4 1 64 
  r4 = mul r2 1 64 
  br r1 .while.end .while.cond 
.while.end:
  r2 = icmp eq r3 0 64 
  r1 = mul r4 1 64 
  br r2 .cleanup .if.then6 
.if.then6:
  r2 = load 8 r1 0 
  store r2 8 r1 0 
  r1 = mul r4 1 64 
  br .cleanup 
.cleanup:
  sp = add sp 0 64 
  ret r1 
end adjust

start remove 2:
.entry:
  r1 = load 8 arg1 0 
  r4 = icmp eq r1 arg2 64 
  r3 = mul r1 1 64 
  r8 = mul arg1 1 64 
  r7 = mul 0 1 64 
  r2 = mul 0 1 64 
  br r4 .cleanup24 .while.cond 
.while.cond:
  r1 = icmp ugt r3 arg2 64 
  br r1 .if.then2 .if.else 
.if.then2:
  r1 = mul r6 1 64 
  r5 = load 8 r1 0 
  r4 = icmp eq r5 0 64 
  r3 = mul r8 1 64 
  r1 = mul 1 1 32 
  r2 = mul 0 1 64 
  br r4 .cleanup .if.end5 
.if.end5:
  r1 = load 8 r5 0 
  r4 = icmp eq r1 arg2 64 
  r2 = mul r7 1 64 
  r3 = mul r5 1 64 
  r1 = mul 2 1 32 
  br r4 .if.then7 .cleanup 
.if.then7:
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  r4 = mul r2 1 64 
  br r1 .if.then.i .while.cond.i 
.if.then.i:
  r1 = load 8 r1 0 
  br .adjust.exit 
.while.cond.i:
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  r3 = mul r4 1 64 
  r4 = mul r2 1 64 
  br r1 .while.end.i .while.cond.i 
.while.end.i:
  r2 = icmp eq r3 0 64 
  r1 = mul r4 1 64 
  br r2 .adjust.exit .if.then6.i 
.if.then6.i:
  r2 = load 8 r1 0 
  store r2 8 r1 0 
  r1 = mul r4 1 64 
  br .adjust.exit 
.adjust.exit:
  store r1 8 r6 0 
  r1 = mul r5 1 64 
  0 = free r1 
  r3 = mul r8 1 64 
  r1 = mul 1 1 32 
  r2 = mul 1 1 64 
  br .cleanup 
.if.else:
  r4 = icmp ult r3 arg2 64 
  r2 = mul r7 1 64 
  r3 = mul r8 1 64 
  r1 = mul 0 1 32 
  br r4 .if.then11 .cleanup 
.if.then11:
  r1 = mul r6 1 64 
  r5 = load 8 r1 0 
  r4 = icmp eq r5 0 64 
  r3 = mul r8 1 64 
  r1 = mul 1 1 32 
  r2 = mul 0 1 64 
  br r4 .cleanup .if.end15 
.if.end15:
  r1 = load 8 r5 0 
  r4 = icmp eq r1 arg2 64 
  r2 = mul r7 1 64 
  r3 = mul r5 1 64 
  r1 = mul 2 1 32 
  br r4 .if.then17 .cleanup 
.if.then17:
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  r4 = mul r2 1 64 
  br r1 .if.then.i4 .while.cond.i10 
.if.then.i4:
  r1 = load 8 r1 0 
  br .adjust.exit19 
.while.cond.i10:
  r2 = load 8 r1 0 
  r1 = icmp eq r2 0 64 
  r3 = mul r4 1 64 
  r4 = mul r2 1 64 
  br r1 .while.end.i13 .while.cond.i10 
.while.end.i13:
  r2 = icmp eq r3 0 64 
  r1 = mul r4 1 64 
  br r2 .adjust.exit19 .if.then6.i16 
.if.then6.i16:
  r2 = load 8 r1 0 
  store r2 8 r1 0 
  r1 = mul r4 1 64 
  br .adjust.exit19 
.adjust.exit19:
  store r1 8 r6 0 
  r1 = mul r5 1 64 
  0 = free r1 
  r3 = mul r8 1 64 
  r1 = mul 1 1 32 
  r2 = mul 1 1 64 
  br .cleanup 
.cleanup:
.while.cond.backedge:
  r1 = load 8 r3 0 
  r7 = mul r2 1 64 
  r8 = mul r3 1 64 
  r3 = mul r1 1 64 
  br .while.cond 
.cleanup24:
  sp = add sp 0 64 
  ret r2 
end remove

start traverse 1:
.entry:
  r1 = icmp eq arg1 0 64 
  r2 = mul arg1 1 64 
  br r1 .return .if.end 
.if.end:
  r4 = load 8 r2 0 
  r3 = load 8 r1 0 
  r2 = load 8 r1 0 
  call traverse r3 
  call write r4 
  r1 = icmp eq r2 0 64 
  br r1 .return .if.end 
.return:
  sp = add sp 0 64 
  ret 0 
end traverse

start main 0:
.entry:
  r2 = malloc 24 
  r8 = mul r2 1 64 
  r1 = call read 
  store r1 8 r8 0 
  store 0 8 r1 0 
  store 0 8 r1 0 
  r7 = call read 
  r1 = icmp eq r7 0 64 
  r6 = mul 0 1 64 
  br r1 .for.cond.cleanup .for.body 
.for.cond.cleanup:
  call traverse r8 
  sp = add sp 0 64 
  ret 0 
.for.body:
  r1 = call read 
  r5 = call read 
  r1 = icmp eq r1 0 64 
  r4 = mul r8 1 64 
  br r1 .while.cond.i .if.else 
.while.cond.i:
  r2 = load 8 r4 0 
  r1 = icmp ugt r2 r5 64 
  br r1 .if.then.i .if.else.i 
.if.then.i:
  r1 = mul r3 1 64 
  r1 = load 8 r1 0 
  r2 = icmp eq r1 0 64 
  r3 = mul 1 1 1 
  br r2 .if.then2.i .cleanup.i 
.if.then2.i:
  r2 = malloc 24 
  r1 = mul r2 1 64 
  store r5 8 r1 0 
  store 0 8 r1 0 
  store 0 8 r1 0 
  r1 = mul r2 1 64 
  store r1 8 r3 0 
  r1 = mul r4 1 64 
  r3 = mul 0 1 1 
  br .cleanup.i 
.if.else.i:
  r2 = icmp ult r2 r5 64 
  r1 = mul r4 1 64 
  r3 = mul 0 1 1 
  br r2 .if.then7.i .cleanup.i 
.if.then7.i:
  r1 = mul r3 1 64 
  r1 = load 8 r1 0 
  r2 = icmp eq r1 0 64 
  r3 = mul 1 1 1 
  br r2 .if.then10.i .cleanup.i 
.if.then10.i:
  r2 = malloc 24 
  r1 = mul r2 1 64 
  store r5 8 r1 0 
  store 0 8 r1 0 
  store 0 8 r1 0 
  r1 = mul r2 1 64 
  store r1 8 r3 0 
  r1 = mul r4 1 64 
  r3 = mul 0 1 1 
  br .cleanup.i 
.cleanup.i:
  r4 = mul r1 1 64 
  br r3 .while.cond.i .if.end 
.if.else:
  r1 = call remove r8 r5 
  br .if.end 
.if.end:
  r1 = add r6 1 64 
  r2 = icmp eq r1 r7 64 
  r6 = mul r1 1 64 
  br r2 .for.cond.cleanup .for.body 
end main

