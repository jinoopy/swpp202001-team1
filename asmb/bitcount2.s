start countSetBits 1:
.entry:
  r1 = icmp eq arg1 0 32 
  r5 = mul arg1 1 32 
  r4 = mul 0 1 32 
  r2 = mul 0 1 32 
  br r1 .return .if.else 
.if.else:
  r1 = srem r5 2 32 
  r3 = sdiv r5 2 32 
  r2 = add r1 r4 32 
  r1 = add r5 1 32 
  r1 = icmp ult r1 3 32 
  r4 = mul r2 1 32 
  r5 = mul r3 1 32 
  br r1 .return .if.else 
.return:
  ret r2 
end countSetBits

start main 0:
.entry:
  r1 = call read 
  r2 = mul r1 1 32 
  r1 = icmp eq r2 0 32 
  r5 = mul r2 1 32 
  r4 = mul 0 1 32 
  r2 = mul 0 1 64 
  br r1 .countSetBits.exit .if.else.i 
.if.else.i:
  r1 = srem r5 2 32 
  r3 = sdiv r5 2 32 
  r2 = add r1 r4 32 
  r1 = add r5 1 32 
  r1 = icmp ult r1 3 32 
  r4 = mul r2 1 32 
  r5 = mul r3 1 32 
  br r1 .tailrecurse.i.countSetBits.exit_crit_edge .if.else.i 
.tailrecurse.i.countSetBits.exit_crit_edge:
  r2 = mul r1 1 64 
  br .countSetBits.exit 
.countSetBits.exit:
  call write r2 
  ret 0 
end main

