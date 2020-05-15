; ModuleID = 'input2.ll'
source_filename = "input2.ll"

define i32 @main() {
  %1 = alloca [1024 x i32], align 16
  br label %2

.preheader:                                       ; preds = %2
  br i1 true, label %.lr.ph, label %.preheader._crit_edge

.preheader._crit_edge:                            ; preds = %.preheader
  br label %42

.lr.ph:                                           ; preds = %.preheader
  br label %16

2:                                                ; preds = %0, %2
  %.02 = phi i64 [ 0, %0 ], [ %14, %2 ]
  %3 = trunc i64 %.02 to i32
  %4 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %.02
  store i32 %3, i32* %4, align 4
  %5 = add nuw nsw i64 %.02, 1
  %6 = trunc i64 %5 to i32
  %7 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %5
  store i32 %6, i32* %7, align 4
  %8 = add nuw nsw i64 %5, 1
  %9 = trunc i64 %8 to i32
  %10 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %8
  store i32 %9, i32* %10, align 4
  %11 = add nuw nsw i64 %8, 1
  %12 = trunc i64 %11 to i32
  %13 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %11
  store i32 %12, i32* %13, align 4
  %14 = add nuw nsw i64 %11, 1
  %15 = icmp ult i64 %14, 1024
  br i1 %15, label %2, label %.preheader

16:                                               ; preds = %.lr.ph, %16
  %.11 = phi i64 [ 0, %.lr.ph ], [ %40, %16 ]
  %17 = sub nuw nsw i64 1024, %.11
  %18 = sub nuw nsw i64 %17, 1
  %19 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %18
  %20 = load i32, i32* %19, align 4
  %21 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %.11
  store i32 %20, i32* %21, align 4
  %22 = add nuw nsw i64 %.11, 1
  %23 = sub nuw nsw i64 1024, %22
  %24 = sub nuw nsw i64 %23, 1
  %25 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %24
  %26 = load i32, i32* %25, align 4
  %27 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %22
  store i32 %26, i32* %27, align 4
  %28 = add nuw nsw i64 %22, 1
  %29 = sub nuw nsw i64 1024, %28
  %30 = sub nuw nsw i64 %29, 1
  %31 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %30
  %32 = load i32, i32* %31, align 4
  %33 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %28
  store i32 %32, i32* %33, align 4
  %34 = add nuw nsw i64 %28, 1
  %35 = sub nuw nsw i64 1024, %34
  %36 = sub nuw nsw i64 %35, 1
  %37 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %36
  %38 = load i32, i32* %37, align 4
  %39 = getelementptr inbounds [1024 x i32], [1024 x i32]* %1, i64 0, i64 %34
  store i32 %38, i32* %39, align 4
  %40 = add nuw nsw i64 %34, 1
  %41 = icmp ult i64 %40, 512
  br i1 %41, label %16, label %._crit_edge

._crit_edge:                                      ; preds = %16
  br label %42

42:                                               ; preds = %.preheader._crit_edge, %._crit_edge
  ret i32 0
}
