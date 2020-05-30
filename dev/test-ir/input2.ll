define dso_local i32 @main() {
entry:
  br label %header
header:
  %r1 = phi i32 [ 0, %entry ], [ %r9, %BB4 ]
  %r2 = phi i32 [ 0, %entry ], [ %r8, %BB4 ]
  br label %BB1

BB1:                                                ; preds = %1, %4
  %r3 = phi i32 [ 0, %header ], [ %r6, %BB2 ]
  %r4 = phi i32 [ %r2, %header ], [ %r5, %BB2 ]
  %r5 = add nsw i32 %r4, %r3
  br label %BB2

BB2:                                                ; preds = %2
  %r6 = add nsw i32 %r3, 1
  %r7 = icmp slt i32 %r6, 100
  br i1 %r7, label %BB1, label %BB3

BB3:                                                ; preds = %4
  %r8 = phi i32 [ %r5, %BB2 ]
  br label %BB4

BB4:                                                ; preds = %7
  %r9 = add nsw i32 %r1, 1
  %r10 = icmp slt i32 %r9, 100
  br i1 %r10, label %entry, label %BB5

BB5:                                               ; preds = %8
  %r11 = phi i32 [ %r8, %BB4 ]
  ret i32 %r11
}