define i32 @main() {
entry:
  %x = add i32 5, 3
  %cmp = icmp eq i32 %x, 0
  br i1 %cmp, label %BB1, label %BB2
BB1:
  %y = phi i32 [ %x, %entry ], [ %x.1, %BB3 ]
  br label %BB3
BB2:
  %z = phi i32 [ %x, %entry ], [ %x.1, %BB3 ]
  br label %BB3
BB3:
  %x.1 = sub i32 %x, 1
  %cmp.1 = icmp eq i32 %x.1, 0
  br i1 %cmp.1, label %BB1, label %BB2
}