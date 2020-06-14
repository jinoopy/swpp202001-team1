start countSetBits 1:
.entry:
  r1 = srem arg1 256 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r3 = load 4 r1 0 
  r1 = sdiv arg1 256 32 
  r1 = srem r1 256 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r3 = add r1 r3 32 
  r1 = sdiv arg1 65536 32 
  r1 = srem r1 256 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r3 = add r3 r1 32 
  r1 = sdiv arg1 16777216 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r1 = add r3 r1 32 
  ret r1 
end countSetBits

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 1024 
  store 4 0 r1 0 
  r5 = mul 0 1 64 
  br .for.body 
.for.cond.cleanup:
  r1 = call read 
  r4 = mul r1 1 32 
  r1 = srem r4 256 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r3 = load 4 r1 0 
  r1 = sdiv r4 256 32 
  r1 = srem r1 256 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r3 = add r1 r3 32 
  r1 = sdiv r4 65536 32 
  r1 = srem r1 256 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r3 = add r3 r1 32 
  r1 = sdiv r4 16777216 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r1 = add r3 r1 32 
  call write r1 
  ret 0 
.for.body:
  r1 = mul r5 1 32 
  r1 = sdiv r1 2 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r3 = load 4 r1 0 
  r2 = mul r5 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r4 = or r5 1 64 
  r1 = mul r4 1 32 
  r1 = sdiv r1 2 32 
  r2 = mul r1 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r3 = add r1 1 32 
  r2 = mul r4 4 64 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r1 = add r5 2 64 
  r2 = icmp eq r1 256 64 
  r5 = mul r1 1 64 
  br r2 .for.cond.cleanup .for.body 
end main

