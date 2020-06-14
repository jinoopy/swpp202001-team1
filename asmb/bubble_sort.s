start get_inputs 1:
.entry:
  r2 = icmp eq arg1 0 64 
  br r2 .return .if.end 
.if.end:
  r1 = mul arg1 8 64 
  r5 = malloc r1 
  r4 = mul r5 1 64 
  r6 = mul 0 1 64 
  br .for.body 
.for.body:
  r3 = call read 
  r2 = mul r5 1 64 
  r1 = mul r6 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r6 1 64 
  r2 = icmp eq r1 arg1 64 
  r6 = mul r1 1 64 
  r1 = mul r4 1 64 
  br r2 .return .for.body 
.return:
  ret r1 
end get_inputs

start sort 2:
.entry:
  r1 = icmp eq arg1 0 64 
  br r1 .for.end15 .for.cond2.preheader.lr.ph 
.for.cond2.preheader.lr.ph:
  r11 = add arg1 18446744073709551615 64 
  r10 = add arg1 18446744073709551614 64 
  r9 = mul 0 1 64 
  br .for.cond2.preheader 
.for.cond2.preheader:
  r1 = icmp ugt r11 r9 64 
  br r1 .for.body5.preheader .for.cond.cleanup4 
.for.body5.preheader:
  r1 = sub r11 r9 64 
  r1 = srem r1 2 64 
  r1 = icmp eq r1 0 64 
  r3 = mul arg1 1 64 
  r4 = mul r11 1 64 
  br r1 .for.body5.prol.loopexit .for.body5.prol 
.for.body5.prol:
  r2 = mul arg2 1 64 
  r1 = mul r11 8 64 
  r4 = add r1 r2 64 
  r3 = load 8 r4 0 
  r2 = mul arg2 1 64 
  r1 = mul r10 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r5 = icmp ult r3 r1 64 
  br r5 .if.then9.prol .if.end13.prol 
.if.then9.prol:
  store 8 r1 r4 0 
  store 8 r3 r2 0 
  br .if.end13.prol 
.if.end13.prol:
  r3 = mul r11 1 64 
  r4 = mul r10 1 64 
  br .for.body5.prol.loopexit 
.for.body5.prol.loopexit:
  r1 = icmp eq r10 r9 64 
  br r1 .for.cond.cleanup4 .for.body5.prol.loopexit.for.body5_crit_edge 
.for.body5.prol.loopexit.for.body5_crit_edge:
  r2 = mul arg2 1 64 
  r1 = mul r4 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r5 = mul r1 1 64 
  r6 = mul r4 1 64 
  br .for.body5 
.for.cond.cleanup4:
  r1 = add r9 1 64 
  r2 = icmp eq r1 arg1 64 
  r9 = mul r1 1 64 
  br r2 .for.end15 .for.cond2.preheader 
.for.body5:
  r2 = mul arg2 1 64 
  r1 = mul r3 8 64 
  r1 = add r1 18446744073709551600 64 
  r4 = add r1 r2 64 
  r3 = load 8 r4 0 
  r1 = icmp ult r5 r3 64 
  br r1 .if.then9 .if.end13 
.if.then9:
  r1 = mul r6 8 64 
  r2 = mul arg2 1 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  store 8 r5 r4 0 
  br .if.end13 
.if.end13:
  r7 = add r6 18446744073709551615 64 
  r2 = mul arg2 1 64 
  r1 = mul r7 8 64 
  r8 = add r1 r2 64 
  r5 = load 8 r8 0 
  r4 = add r6 18446744073709551614 64 
  r2 = mul arg2 1 64 
  r1 = mul r4 8 64 
  r3 = add r1 r2 64 
  r2 = load 8 r3 0 
  r1 = icmp ult r5 r2 64 
  br r1 .if.then9.1 .if.end13.1 
.for.end15:
  ret 0 
.if.then9.1:
  store 8 r2 r8 0 
  store 8 r5 r3 0 
  r2 = mul r5 1 64 
  br .if.end13.1 
.if.end13.1:
  r1 = icmp ugt r4 r9 64 
  r3 = mul r7 1 64 
  r5 = mul r2 1 64 
  r6 = mul r4 1 64 
  br r1 .for.body5 .for.cond.cleanup4 
end sort

start put_inputs 2:
.entry:
  r1 = icmp eq arg1 0 64 
  r3 = mul 0 1 64 
  br r1 .for.end .for.body 
.for.body:
  r2 = mul arg2 1 64 
  r1 = mul r3 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r3 1 64 
  r2 = icmp eq r1 arg1 64 
  r3 = mul r1 1 64 
  br r2 .for.end .for.body 
.for.end:
  ret 0 
end put_inputs

start main 0:
.entry:
  r13 = call read 
  r1 = icmp eq r13 0 64 
  br r1 .cleanup .if.end.i 
.if.end.i:
  r1 = mul r13 8 64 
  r12 = malloc r1 
  r4 = mul 0 1 64 
  br .for.body.i 
.for.cond2.i.preheader.lr.ph:
  r11 = add r13 18446744073709551615 64 
  r10 = add r13 18446744073709551614 64 
  r9 = mul 0 1 64 
  br .for.cond2.i.preheader 
.for.body.i:
  r3 = call read 
  r2 = mul r12 1 64 
  r1 = mul r4 8 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r13 64 
  r4 = mul r1 1 64 
  br r2 .for.cond2.i.preheader.lr.ph .for.body.i 
.for.cond2.i.preheader:
  r1 = icmp ugt r11 r9 64 
  br r1 .for.body5.i.preheader .for.cond.cleanup4.i 
.for.body5.i.preheader:
  r1 = sub r11 r9 64 
  r1 = srem r1 2 64 
  r1 = icmp eq r1 0 64 
  r3 = mul r13 1 64 
  r4 = mul r11 1 64 
  br r1 .for.body5.i.prol.loopexit .for.body5.i.prol 
.for.body5.i.prol:
  r2 = mul r12 1 64 
  r1 = mul r11 8 64 
  r4 = add r1 r2 64 
  r3 = load 8 r4 0 
  r2 = mul r12 1 64 
  r1 = mul r10 8 64 
  r2 = add r1 r2 64 
  r1 = load 8 r2 0 
  r5 = icmp ult r3 r1 64 
  br r5 .if.then9.i.prol .if.end13.i.prol 
.if.then9.i.prol:
  store 8 r1 r4 0 
  store 8 r3 r2 0 
  br .if.end13.i.prol 
.if.end13.i.prol:
  r3 = mul r11 1 64 
  r4 = mul r10 1 64 
  br .for.body5.i.prol.loopexit 
.for.body5.i.prol.loopexit:
  r1 = icmp eq r10 r9 64 
  br r1 .for.cond.cleanup4.i .for.body5.i.prol.loopexit.for.body5.i_crit_edge 
.for.body5.i.prol.loopexit.for.body5.i_crit_edge:
  r2 = mul r12 1 64 
  r1 = mul r4 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  r5 = mul r1 1 64 
  r6 = mul r4 1 64 
  br .for.body5.i 
.for.cond.cleanup4.i:
  r1 = add r9 1 64 
  r2 = icmp eq r1 r13 64 
  r9 = mul r1 1 64 
  r3 = mul 0 1 64 
  br r2 .for.body.i20 .for.cond2.i.preheader 
.for.body5.i:
  r2 = mul r12 1 64 
  r1 = mul r3 8 64 
  r1 = add r1 18446744073709551600 64 
  r4 = add r1 r2 64 
  r3 = load 8 r4 0 
  r1 = icmp ult r5 r3 64 
  br r1 .if.then9.i .if.end13.i 
.if.then9.i:
  r1 = mul r6 8 64 
  r2 = mul r12 1 64 
  r1 = add r1 r2 64 
  store 8 r3 r1 0 
  store 8 r5 r4 0 
  br .if.end13.i 
.if.end13.i:
  r7 = add r6 18446744073709551615 64 
  r2 = mul r12 1 64 
  r1 = mul r7 8 64 
  r8 = add r1 r2 64 
  r5 = load 8 r8 0 
  r4 = add r6 18446744073709551614 64 
  r2 = mul r12 1 64 
  r1 = mul r4 8 64 
  r3 = add r1 r2 64 
  r2 = load 8 r3 0 
  r1 = icmp ult r5 r2 64 
  r3 = mul r2 1 64 
  br r1 .if.then9.i.1 .if.end13.i.1 
.for.body.i20:
  r2 = mul r12 1 64 
  r1 = mul r3 8 64 
  r1 = add r1 r2 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r3 1 64 
  r2 = icmp eq r1 r13 64 
  r3 = mul r1 1 64 
  br r2 .cleanup .for.body.i20 
.cleanup:
  ret 0 
.if.then9.i.1:
  store 8 r2 r8 0 
  store 8 r5 r3 0 
  r3 = mul r5 1 64 
  br .if.end13.i.1 
.if.end13.i.1:
  r1 = icmp ugt r4 r9 64 
  r5 = mul r3 1 64 
  r6 = mul r4 1 64 
  r3 = mul r7 1 64 
  br r1 .for.body5.i .for.cond.cleanup4.i 
end main

