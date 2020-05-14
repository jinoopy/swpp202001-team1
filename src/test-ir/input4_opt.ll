; ModuleID = 'input4.ll'
source_filename = "input4.ll"

define i32 @main() {
  %1 = alloca [100 x i16], align 16
  %2 = alloca [100 x i16], align 16
  br label %3

3:                                                ; preds = %0, %3
  %.01 = phi i64 [ 0, %0 ], [ %7, %3 ]
  %4 = getelementptr inbounds [100 x i16], [100 x i16]* %2, i64 0, i64 %.01
  %5 = load i16, i16* %4, align 2
  %6 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %.01
  store i16 %5, i16* %6, align 2
  %7 = add i64 %.01, 1
  %8 = icmp ult i64 %7, 100
  br i1 %8, label %3, label %9

9:                                                ; preds = %3
  ret i32 0
}
