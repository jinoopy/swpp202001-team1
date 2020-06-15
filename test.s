start countSetBitsRec 1:
.entry:
  r1 = icmp eq arg1 0 32 
  br r1 .cleanup .if.end 
.if.end:
  r1 = mul arg1 4 32 
  r2 = and r1 60 32 
  r1 = add 20480 0 64 
  r1 = add r2 r1 64 
  r2 = load 4 r1 0 
  r1 = udiv arg1 16 32 
  r1 = call countSetBitsRec r1 
  r1 = add r1 r2 32 
  ret r1 
.cleanup:
  r1 = load 4 r1 0 
  ret r1 
end countSetBitsRec

start main 0:
.entry:
  ; Init global variables
  r1 = malloc 64 
  store 4 0 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 4 64 
  store 4 1 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 8 64 
  store 4 1 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 12 64 
  store 4 2 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 16 64 
  store 4 1 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 20 64 
  store 4 2 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 24 64 
  store 4 2 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 28 64 
  store 4 3 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 32 64 
  store 4 1 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 36 64 
  store 4 2 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 40 64 
  store 4 2 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 44 64 
  store 4 3 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 48 64 
  store 4 2 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 52 64 
  store 4 3 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 56 64 
  store 4 3 r1 0 
  r1 = add 20480 0 64 
  r1 = add r1 60 64 
  store 4 4 r1 0 
  r1 = call read 
  r1 = call countSetBitsRec r1 
  call write r1 
  ret 0 
end main

