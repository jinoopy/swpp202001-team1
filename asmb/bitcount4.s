start countSetBits 1:
.entry:
  r3 = urem arg1 256 32 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r4 = load 4 r1 0 
  r1 = udiv arg1 256 32 
  r3 = urem r1 256 32 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r4 = add r1 r4 32 
  r1 = udiv arg1 65536 32 
  r3 = urem r1 256 32 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r4 = add r4 r1 32 
  r3 = sdiv arg1 16777216 32 
  r3 = mul r3 4294967296 64 
  r3 = sdiv r3 4294967296 64 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r1 = add r4 r1 32 
  ret r1 
end countSetBits

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 1024 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul 0 4 64 
  r1 = add r2 r1 64 
  store 4 0 r1 0 
  r5 = mul 0 1 64 
  br .for.body 
.for.cond.cleanup:
  r6 = call read 
  r5 = mul r6 1 32 
  r3 = urem r6 256 64 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r4 = load 4 r1 0 
  r1 = udiv r6 256 64 
  r3 = urem r1 256 64 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r4 = add r1 r4 32 
  r1 = udiv r6 65536 64 
  r3 = urem r1 256 64 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r4 = add r4 r1 32 
  r3 = sdiv r5 16777216 32 
  r3 = mul r3 4294967296 64 
  r3 = sdiv r3 4294967296 64 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r1 = add r4 r1 32 
  r1 = mul r1 4294967296 64 
  r1 = sdiv r1 4294967296 64 
  call write r1 
  ret 0 
.for.body:
  r1 = mul r5 1 32 
  r4 = urem r1 2 32 
  r1 = udiv r5 2 64 
  r3 = urem r1 2147483648 64 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  r3 = add r4 r1 32 
  r2 = add 20480 0 64 
  r1 = mul 0 1024 64 
  r2 = add r2 r1 64 
  r1 = mul r5 4 64 
  r1 = add r2 r1 64 
  store 4 r3 r1 0 
  r1 = add r5 1 64 
  r2 = icmp eq r1 256 64 
  r5 = mul r1 1 64 
  br r2 .for.cond.cleanup .for.body 
end main

