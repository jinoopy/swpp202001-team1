start countSetBitsRec 1:
.entry:
  r1 = icmp eq arg1 0 32 
  br r1 .if.then .if.end 
.if.then:
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 0 4 64 
  r1 = add r2 r1 64 
  r1 = load 4 r1 0 
  ret r1 
.if.end:
  r3 = urem arg1 16 32 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul r3 4 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = udiv arg1 16 32 
  r1 = call countSetBitsRec r1 
  r1 = add r1 r2 32 
  ret r1 
end countSetBitsRec

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 64 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 0 4 64 
  r1 = add r2 r1 64 
  store 4 0 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 1 4 64 
  r1 = add r2 r1 64 
  store 4 1 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 2 4 64 
  r1 = add r2 r1 64 
  store 4 1 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 3 4 64 
  r1 = add r2 r1 64 
  store 4 2 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 4 4 64 
  r1 = add r2 r1 64 
  store 4 1 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r1 = add r2 r1 64 
  r2 = mul 5 4 64 
  r1 = add r1 r2 64 
  store 4 2 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 6 4 64 
  r1 = add r2 r1 64 
  store 4 2 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 7 4 64 
  r1 = add r2 r1 64 
  store 4 3 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 8 4 64 
  r1 = add r2 r1 64 
  store 4 1 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 9 4 64 
  r1 = add r2 r1 64 
  store 4 2 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 10 4 64 
  r1 = add r2 r1 64 
  store 4 2 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 11 4 64 
  r1 = add r2 r1 64 
  store 4 3 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 12 4 64 
  r1 = add r2 r1 64 
  store 4 2 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 13 4 64 
  r1 = add r2 r1 64 
  store 4 3 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 14 4 64 
  r1 = add r2 r1 64 
  store 4 3 r1 0 
  r2 = add 20480 0 64 
  r1 = mul 0 64 64 
  r2 = add r2 r1 64 
  r1 = mul 15 4 64 
  r1 = add r2 r1 64 
  store 4 4 r1 0 
  r1 = call read 
  r1 = call countSetBitsRec r1 
  call write r1 
  ret 0 
end main

