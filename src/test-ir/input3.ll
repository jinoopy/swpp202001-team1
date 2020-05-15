
define void @_Z1fv() #0 {
  %1 = alloca [100 x i16], align 16
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  store i64 100, i64* %3, align 8
  store i64 0, i64* %2, align 8
  br label %4

4:                                                ; preds = %8, %0
  %5 = load i64, i64* %2, align 8
  %6 = load i64, i64* %3, align 8
  %7 = icmp ult i64 %5, %6
  br i1 %7, label %8, label %37

8:                                                ; preds = %4
  %9 = load i64, i64* %2, align 8
  %10 = urem i64 %9, 3
  %11 = trunc i64 %10 to i16
  %12 = load i64, i64* %2, align 8
  %13 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %12
  store i16 %11, i16* %13, align 2
  %14 = load i64, i64* %2, align 8
  %15 = add i64 %14, 1
  store i64 %15, i64* %2, align 8
  %16 = load i64, i64* %2, align 8
  %17 = urem i64 %16, 3
  %18 = trunc i64 %17 to i16
  %19 = load i64, i64* %2, align 8
  %20 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %19
  store i16 %18, i16* %20, align 2
  %21 = load i64, i64* %2, align 8
  %22 = add i64 %21, 1
  store i64 %22, i64* %2, align 8
  %23 = load i64, i64* %2, align 8
  %24 = urem i64 %23, 3
  %25 = trunc i64 %24 to i16
  %26 = load i64, i64* %2, align 8
  %27 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %26
  store i16 %25, i16* %27, align 2
  %28 = load i64, i64* %2, align 8
  %29 = add i64 %28, 1
  store i64 %29, i64* %2, align 8
  %30 = load i64, i64* %2, align 8
  %31 = urem i64 %30, 3
  %32 = trunc i64 %31 to i16
  %33 = load i64, i64* %2, align 8
  %34 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %33
  store i16 %32, i16* %34, align 2
  %35 = load i64, i64* %2, align 8
  %36 = add i64 %35, 1
  store i64 %36, i64* %2, align 8
  br label %4

37:                                               ; preds = %4
  ret void
}
