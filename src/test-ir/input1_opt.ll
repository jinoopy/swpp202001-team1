; ModuleID = 'input1.ll'
source_filename = "input1.ll"

define i32 @main() {
  %1 = alloca [1024 x i32], align 16
  br label %2

.preheader:                                       ; preds = %2
  br label %20

2:                                                ; preds = %0, %2
  %.015 = phi i64 [ 0, %0 ], [ %18, %2 ]
  %3 = mul i64 %.015, %.015
  %4 = trunc i64 %3 to i32
  %5 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %.015
  store i32 %4, i32* %5, align 4
  %6 = add nuw nsw i64 %.015, 1
  %7 = mul i64 %6, %6
  %8 = trunc i64 %7 to i32
  %9 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %6
  store i32 %8, i32* %9, align 4
  %10 = add nuw nsw i64 %6, 1
  %11 = mul i64 %10, %10
  %12 = trunc i64 %11 to i32
  %13 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %10
  store i32 %12, i32* %13, align 4
  %14 = add nuw nsw i64 %10, 1
  %15 = mul i64 %14, %14
  %16 = trunc i64 %15 to i32
  %17 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %14
  store i32 %16, i32* %17, align 4
  %18 = add nuw nsw i64 %14, 1
  %19 = icmp ult i64 %18, 1024
  br i1 %19, label %2, label %.preheader

20:                                               ; preds = %.preheader, %20
  %.04 = phi i64 [ 0, %.preheader ], [ %36, %20 ]
  %.023 = phi i32 [ 0, %.preheader ], [ %35, %20 ]
  %21 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %.04
  %22 = load i32, i32* %21, align 4
  %23 = add nsw i32 %.023, %22
  %24 = add nuw nsw i64 %.04, 1
  %25 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %24
  %26 = load i32, i32* %25, align 4
  %27 = add nsw i32 %23, %26
  %28 = add nuw nsw i64 %24, 1
  %29 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %28
  %30 = load i32, i32* %29, align 4
  %31 = add nsw i32 %27, %30
  %32 = add nuw nsw i64 %28, 1
  %33 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %32
  %34 = load i32, i32* %33, align 4
  %35 = add nsw i32 %31, %34
  %36 = add nuw nsw i64 %32, 1
  %37 = icmp ult i64 %36, 1024
  br i1 %37, label %20, label %38

38:                                               ; preds = %20
  %.02.lcssa = phi i32 [ %35, %20 ]
  ret i32 %.02.lcssa
}
