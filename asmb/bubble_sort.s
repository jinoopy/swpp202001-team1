start get_inputs 1:
.entry:
  r2 = icmp eq arg1 0 64 
  br r2 .return .if.end 
.if.end:
  r1 = mul arg1 8 64 
  r4 = malloc r1 
  r5 = mul 0 1 64 
  br .for.body 
.for.body:
  r3 = call read 
  r2 = mul r4 1 64 
  r1 = mul r5 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r5 1 64 
  r2 = icmp eq r1 arg1 64 
  r5 = mul r1 1 64 
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
  r8 = add arg1 18446744073709551615 64 
  r7 = mul 0 1 64 
  br .for.cond2.preheader 
.for.cond2.preheader:
  r1 = icmp ugt r8 r7 64 
  r3 = mul arg1 1 64 
  r6 = mul r8 1 64 
  br r1 .for.body5 .for.cond.cleanup4 
.for.cond.cleanup4:
  r1 = add r7 1 64 
  r2 = icmp eq r1 arg1 64 
  r7 = mul r1 1 64 
  br r2 .for.end15 .for.cond2.preheader 
.for.body5:
  r2 = mul arg2 1 64 
  r1 = mul r6 8 64 
  r5 = add r2 r1 64 
  r4 = load 8 r5 0 
  r1 = add r3 18446744073709551614 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r3 = add r2 r1 64 
  r2 = load 8 r3 0 
  r1 = icmp ult r4 r2 64 
  br r1 .if.then9 .if.end13 
.if.then9:
  store 8 r2 r5 0 
  store 8 r4 r3 0 
  br .if.end13 
.if.end13:
  r1 = add r6 18446744073709551615 64 
  r2 = icmp ugt r1 r7 64 
  r3 = mul r6 1 64 
  r6 = mul r1 1 64 
  br r2 .for.body5 .for.cond.cleanup4 
.for.end15:
  ret 0 
end sort

start put_inputs 2:
.entry:
  r1 = icmp eq arg1 0 64 
  r3 = mul 0 1 64 
  br r1 .for.end .for.body 
.for.body:
  r2 = mul arg2 1 64 
  r1 = mul r3 8 64 
  r1 = add r2 r1 64 
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
  r9 = call read 
  r1 = icmp eq r9 0 64 
  br r1 .cleanup .if.end.i 
.if.end.i:
  r1 = mul r9 8 64 
  r10 = malloc r1 
  r4 = mul 0 1 64 
  br .for.body.i 
.for.cond2.i.preheader.lr.ph:
  r8 = add r9 18446744073709551615 64 
  r7 = mul 0 1 64 
  br .for.cond2.i.preheader 
.for.body.i:
  r3 = call read 
  r2 = mul r10 1 64 
  r1 = mul r4 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r2 = icmp eq r1 r9 64 
  r4 = mul r1 1 64 
  br r2 .for.cond2.i.preheader.lr.ph .for.body.i 
.for.cond2.i.preheader:
  r1 = icmp ugt r8 r7 64 
  r3 = mul r9 1 64 
  r6 = mul r8 1 64 
  br r1 .for.body5.i .for.cond.cleanup4.i 
.for.cond.cleanup4.i:
  r1 = add r7 1 64 
  r2 = icmp eq r1 r9 64 
  r7 = mul r1 1 64 
  r3 = mul 0 1 64 
  br r2 .for.body.i20 .for.cond2.i.preheader 
.for.body5.i:
  r2 = mul r10 1 64 
  r1 = mul r6 8 64 
  r5 = add r2 r1 64 
  r4 = load 8 r5 0 
  r1 = add r3 18446744073709551614 64 
  r2 = mul r10 1 64 
  r1 = mul r1 8 64 
  r3 = add r2 r1 64 
  r2 = load 8 r3 0 
  r1 = icmp ult r4 r2 64 
  br r1 .if.then9.i .if.end13.i 
.if.then9.i:
  store 8 r2 r5 0 
  store 8 r4 r3 0 
  br .if.end13.i 
.if.end13.i:
  r1 = add r6 18446744073709551615 64 
  r2 = icmp ugt r1 r7 64 
  r3 = mul r6 1 64 
  r6 = mul r1 1 64 
  br r2 .for.body5.i .for.cond.cleanup4.i 
.for.body.i20:
  r2 = mul r10 1 64 
  r1 = mul r3 8 64 
  r1 = add r2 r1 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r3 1 64 
  r2 = icmp eq r1 r9 64 
  r3 = mul r1 1 64 
  br r2 .cleanup .for.body.i20 
.cleanup:
  ret 0 
end main

