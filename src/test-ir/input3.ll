define i32 @main() {
entry:
  %r0 = add i32 10, 5
  %r1 = add i32 3, 4
  %r2 = call i32 @foo(i32 %r0, i32 %r1)
  %r3 = urem i32 %r2, 2
  %r4 = icmp eq i32 %r3, 0
  br i1 %r4, label %BB1, label %BB2
BB1:
  ret i32 0
BB2:
  ret i32 %r2
}

define i32 @foo(i32 %r5, i32 %r6) {
  %r7 = add i32 %r5, %r6
  %r8 = mul i32 %r5, %r6
  %r9 = sub i32 %r8, %r7
  ret i32 %r9
}
