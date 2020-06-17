start get_inputs 1:
.entry:
  r1 = icmp eq arg1 0 64 
  br r1 .if.then .if.end 
.if.then:
  br .return 
.if.end:
  r1 = mul arg1 8 64 
  r5 = malloc r1 
  r4 = mul 0 1 64 
  br .for.cond 
.for.cond:
  r1 = icmp ult r4 arg1 64 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  r1 = mul r5 1 64 
  br .return 
.for.body:
  r3 = call read 
  r2 = mul r5 1 64 
  r1 = mul r4 8 64 
  r1 = add r2 r1 64 
  store 8 r3 r1 0 
  r1 = add r4 1 64 
  r4 = mul r1 1 64 
  br .for.cond 
.return:
  ret r1 
end get_inputs

start sort 2:
.entry:
  r1 = icmp eq arg1 0 64 
  br r1 .if.then .if.end 
.if.then:
  br .for.end15 
.if.end:
  r6 = mul 0 1 64 
  br .for.cond 
.for.cond:
  r1 = icmp ult r6 arg1 64 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  br .for.end15 
.for.body:
  r3 = mul arg1 1 64 
  br .for.cond2 
.for.cond2:
  r5 = add r3 18446744073709551615 64 
  r1 = icmp ugt r5 r6 64 
  br r1 .for.body5 .for.cond.cleanup4 
.for.cond.cleanup4:
  r1 = add r6 1 64 
  r6 = mul r1 1 64 
  br .for.cond 
.for.body5:
  r2 = mul arg2 1 64 
  r1 = mul r5 8 64 
  r7 = add r2 r1 64 
  r4 = load 8 r7 0 
  r1 = add r3 18446744073709551614 64 
  r2 = mul arg2 1 64 
  r1 = mul r1 8 64 
  r3 = add r2 r1 64 
  r2 = load 8 r3 0 
  r1 = icmp ult r4 r2 64 
  br r1 .if.then9 .if.end13 
.if.then9:
  store 8 r2 r7 0 
  store 8 r4 r3 0 
  br .if.end13 
.if.end13:
  r3 = mul r5 1 64 
  br .for.cond2 
.for.end15:
  ret 0 
end sort

start put_inputs 2:
.entry:
  r1 = icmp eq arg1 0 64 
  br r1 .if.then .if.end 
.if.then:
  br .for.end 
.if.end:
  r2 = mul 0 1 64 
  br .for.cond 
.for.cond:
  r1 = icmp ult r2 arg1 64 
  br r1 .for.body .for.cond.cleanup 
.for.cond.cleanup:
  br .for.end 
.for.body:
  r3 = mul arg2 1 64 
  r1 = mul r2 8 64 
  r1 = add r3 r1 64 
  r1 = load 8 r1 0 
  call write r1 
  r1 = add r2 1 64 
  r2 = mul r1 1 64 
  br .for.cond 
.for.end:
  ret 0 
end put_inputs

start main 0:
.entry:
  r2 = call read 
  r1 = icmp eq r2 0 64 
  br r1 .if.then .if.end 
.if.then:
  br .cleanup 
.if.end:
  r1 = call get_inputs r2 
  call sort r2 r1 
  call put_inputs r2 r1 
  br .cleanup 
.cleanup:
  ret 0 
end main

