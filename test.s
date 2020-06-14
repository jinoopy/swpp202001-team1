start main 1:
.entry:
switch arg1 0 .BB1 1 .BB2 .defa
.BB1:
  ret 0 
.BB2:
  ret 1 
.defa:
  ret 4294967295 
end main

