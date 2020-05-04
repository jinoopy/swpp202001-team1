define i32 @main() #0 {
entry:
  %r0 = alloca [10 x i32], align 16
  br label %BB1
BB1: 
  %r1 = phi i32 [ 0, %entry ], [ %r9, %BB3 ]
  %r3 = icmp slt i32 %r1, 5
  br i1 %r3, label %BB2, label %BB4
BB2:
  %r5 = sub nsw i32 %r1, 2
  %r6 = sext i32 %r1 to i64
  %r7 = getelementptr inbounds [10 x i32], [10 x i32]* %r0, i64 0, i64 %r6
  store i32 %r5, i32* %r7, align 4
  br label %BB3
BB3:
  %r9 = add nsw i32 %r1, 1
  br label %BB1
BB4:
  %r11 = add nsw i32 5, 3
  %r12 = ashr i32 %r11, 1
  %r13 = sext i32 %r12 to i64
  %r14 = getelementptr inbounds [10 x i32], [10 x i32]* %r0, i64 0, i64 %r13
  %r15 = load i32, i32* %r14, align 4
  ret i32 %r15
}
