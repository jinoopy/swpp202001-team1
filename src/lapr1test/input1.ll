define i32 @main() #0 {
  %r0 = alloca [10 x i32], align 16
  br label %2
2:                                                ; preds = %8, %0
  %r1 = phi i32 [ 0, %0 ], [ %r9, %8 ]
  %r3 = icmp slt i32 %r1, 5
  br i1 %r3, label %4, label %10
4:                                                ; preds = %2
  %r5 = sub nsw i32 %r1, 2
  %r6 = sext i32 %r1 to i64
  %r7 = getelementptr inbounds [10 x i32], [10 x i32]* %r0, i64 0, i64 %r6
  store i32 %r5, i32* %r7, align 4
  br label %8
8:                                                ; preds = %4
  %r9 = add nsw i32 %r1, 1
  br label %2
10:                                               ; preds = %2
  %r11 = add nsw i32 5, 3
  %r12 = ashr i32 %r11, 1
  %r13 = sext i32 %r12 to i64
  %r14 = getelementptr inbounds [10 x i32], [10 x i32]* %r0, i64 0, i64 %r13
  %r15 = load i32, i32* %r14, align 4
  ret i32 %r15
}
