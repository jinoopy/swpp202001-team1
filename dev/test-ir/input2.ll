define dso_local i32 @main(i32 %argn, i8** %argv) {
entry:
  %color3 = alloca i64
  %color2 = alloca i64
  br label %header

header:                                           ; preds = %entry
  %r1 = phi i32 [ 0, %entry ], [ %r9, %BB4 ]
  %r2 = phi i32 [ 0, %entry ], [ %r8, %BB4 ]
  %r1.temp.s = zext i32 %r1 to i64
  store i64 %r1.temp.s, i64* %color2
  br label %BB1

BB1:                                              ; preds = %BB2, %header
  %r3 = phi i32 [ 0, %header ], [ %r6, %BB2 ]
  %r4 = phi i32 [ %r2, %header ], [ %r5, %BB2 ]
  %r5 = add nsw i32 %r4, %r3
  br label %BB2

BB2:                                              ; preds = %BB1
  %r6 = add nsw i32 %r3, 1
  %r7 = icmp slt i32 %r6, 100
  %r7.temp.s = zext i1 %r7 to i64
  store i64 %r7.temp.s, i64* %color3
  %r7.temp.l = load i64, i64* %color3
  %r7.temp.l1 = trunc i64 %r7.temp.l to i1
  br i1 %r7.temp.l1, label %BB1, label %BB3

BB3:                                              ; preds = %BB2
  %r8 = phi i32 [ %r5, %BB2 ]
  br label %BB4

BB4:                                              ; preds = %BB3
  %r1.temp.l = load i64, i64* %color2
  %r1.temp.l2 = trunc i64 %r1.temp.l to i32
  %r9 = add nsw i32 %r1.temp.l2, 1
  %r10 = icmp slt i32 %r9, 100
  br i1 %r10, label %header, label %BB5

BB5:                                              ; preds = %BB4
  %r11 = phi i32 [ %r8, %BB4 ]
  ret i32 %r11
}