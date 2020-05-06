define i32 @main(i32 %n) {
entry:
  %r0 = icmp eq i32 %n, 0
  %r1 = icmp eq i32 %n, 1
  %r2 = or i1 %r0, %r1
  br i1 %r2, label %ret1, label %BB1
ret1:
  ret i32 1
BB1:
  %r3 = sub i32 %n, 1
  %r4 = call i32 @main(i32 %r3)
  %r5 = sub i32 %n, 2
  %r6 = call i32 @main(i32 %r5)
  %r7 = add i32 %r4, %r6
  ret i32 %r7
}
