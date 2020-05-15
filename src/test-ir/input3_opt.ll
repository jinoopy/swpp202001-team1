; ModuleID = 'input3.ll'
source_filename = "input3.ll"

define void @_Z1fv() {
  %1 = alloca [100 x i16], align 16
  br label %2

2:                                                ; preds = %0, %2
  %.01 = phi i64 [ 0, %0 ], [ %18, %2 ]
  %3 = urem i64 %.01, 3
  %4 = trunc i64 %3 to i16
  %5 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %.01
  store i16 %4, i16* %5, align 2
  %6 = add nuw nsw i64 %.01, 1
  %7 = urem i64 %6, 3
  %8 = trunc i64 %7 to i16
  %9 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %6
  store i16 %8, i16* %9, align 2
  %10 = add nuw nsw i64 %6, 1
  %11 = urem i64 %10, 3
  %12 = trunc i64 %11 to i16
  %13 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %10
  store i16 %12, i16* %13, align 2
  %14 = add nuw nsw i64 %10, 1
  %15 = urem i64 %14, 3
  %16 = trunc i64 %15 to i16
  %17 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %14
  store i16 %16, i16* %17, align 2
  %18 = add nuw nsw i64 %14, 1
  %19 = icmp ult i64 %18, 100
  br i1 %19, label %2, label %20

20:                                               ; preds = %2
  ret void
}
