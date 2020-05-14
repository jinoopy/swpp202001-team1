
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [100 x i16], align 16
  %3 = alloca [100 x i16], align 16
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  store i64 100, i64* %5, align 8
  store i64 0, i64* %4, align 8
  br label %6

6:                                                ; preds = %16, %0
  %7 = load i64, i64* %4, align 8
  %8 = load i64, i64* %5, align 8
  %9 = icmp ult i64 %7, %8
  br i1 %9, label %10, label %19

10:                                               ; preds = %6
  %11 = load i64, i64* %4, align 8
  %12 = getelementptr inbounds [100 x i16], [100 x i16]* %3, i64 0, i64 %11
  %13 = load i16, i16* %12, align 2
  %14 = load i64, i64* %4, align 8
  %15 = getelementptr inbounds [100 x i16], [100 x i16]* %2, i64 0, i64 %14
  store i16 %13, i16* %15, align 2
  br label %16

16:                                               ; preds = %10
  %17 = load i64, i64* %4, align 8
  %18 = add i64 %17, 1
  store i64 %18, i64* %4, align 8
  br label %6

19:                                               ; preds = %6
  ret i32 0
}