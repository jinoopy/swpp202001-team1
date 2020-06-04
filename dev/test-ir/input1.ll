define i32 @main() {
entry:
  %r0 = alloca [10 x i32], align 16
  br label %BB1

BB1:                                              ; preds = %BB3, %entry
  %r1 = phi i32 [ 0, %entry ], [ %r6, %BB3 ]
  %r2 = icmp slt i32 %r1, 5
  br i1 %r2, label %BB2, label %BB4

BB2:                                              ; preds = %BB1
  %r3 = sub nsw i32 %r1, 2
  %r4 = sext i32 %r1 to i64
  %r5 = getelementptr inbounds [10 x i32], [10 x i32]* %r0, i64 0, i64 %r4
  store i32 %r3, i32* %r5, align 4
  br label %BB3

BB3:                                              ; preds = %BB2
  %r6 = add nsw i32 %r1, 1
  br label %BB1

BB4:                                              ; preds = %BB1
  %r7 = add nsw i32 5, 3
  %r8 = ashr i32 %r7, 1
  %r9 = sext i32 %r8 to i64
  %r10 = getelementptr inbounds [10 x i32], [10 x i32]* %r0, i64 0, i64 %r9
  %r11 = load i32, i32* %r10, align 4
  ret i32 %r11
}