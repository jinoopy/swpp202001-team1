define i32 @main() #0 {
entry:
  br label %BB1
BB1:
  %r0 = phi i32 [ 16, %entry ], [ %r8, %BB5 ]
  %r1 = phi i32 [ 0, %entry ], [ %r9, %BB5 ]
  %r2 = icmp sgt i32 %r0, 1
  br i1 %r2, label %BB2, label %BB6
BB2:
  %r3 = srem i32 %r0, 2
  %r4 = icmp eq i32 %r3, 0
  br i1 %r4, label %BB3, label %BB4
BB3:
  %r5 = sdiv i32 %r0, 2
  br label %BB5
BB4:
  %r6 = mul nsw i32 %r0, 3
  %r7 = add nsw i32 %r6, 1
  br label %BB5
BB5:
  %r8 = phi i32 [ %r5, %BB3 ], [ %r7, %BB4 ]
  %r9 = add nsw i32 %r1, 1
  br label %BB1
BB6:
  ret i32 %r1
}
