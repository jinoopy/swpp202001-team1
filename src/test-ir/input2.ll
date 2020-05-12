
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [1024 x i32], align 16
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  store i64 1024, i64* %3, align 8
  store i64 0, i64* %4, align 8
  br label %5

5:                                                ; preds = %9, %0
  %6 = load i64, i64* %4, align 8
  %7 = load i64, i64* %3, align 8
  %8 = icmp ult i64 %6, %7
  br i1 %8, label %9, label %34

9:                                                ; preds = %5
  %10 = load i64, i64* %4, align 8
  %11 = trunc i64 %10 to i32
  %12 = load i64, i64* %4, align 8
  %13 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %12
  store i32 %11, i32* %13, align 4
  %14 = load i64, i64* %4, align 8
  %15 = add i64 %14, 1
  store i64 %15, i64* %4, align 8
  %16 = load i64, i64* %4, align 8
  %17 = trunc i64 %16 to i32
  %18 = load i64, i64* %4, align 8
  %19 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %18
  store i32 %17, i32* %19, align 4
  %20 = load i64, i64* %4, align 8
  %21 = add i64 %20, 1
  store i64 %21, i64* %4, align 8
  %22 = load i64, i64* %4, align 8
  %23 = trunc i64 %22 to i32
  %24 = load i64, i64* %4, align 8
  %25 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %24
  store i32 %23, i32* %25, align 4
  %26 = load i64, i64* %4, align 8
  %27 = add i64 %26, 1
  store i64 %27, i64* %4, align 8
  %28 = load i64, i64* %4, align 8
  %29 = trunc i64 %28 to i32
  %30 = load i64, i64* %4, align 8
  %31 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %30
  store i32 %29, i32* %31, align 4
  %32 = load i64, i64* %4, align 8
  %33 = add i64 %32, 1
  store i64 %33, i64* %4, align 8
  br label %5

34:                                               ; preds = %5
  store i64 0, i64* %4, align 8
  br label %35

35:                                               ; preds = %40, %34
  %36 = load i64, i64* %4, align 8
  %37 = load i64, i64* %3, align 8
  %38 = udiv i64 %37, 2
  %39 = icmp ult i64 %36, %38
  br i1 %39, label %40, label %81

40:                                               ; preds = %35
  %41 = load i64, i64* %3, align 8
  %42 = load i64, i64* %4, align 8
  %43 = sub i64 %41, %42
  %44 = sub i64 %43, 1
  %45 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %44
  %46 = load i32, i32* %45, align 4
  %47 = load i64, i64* %4, align 8
  %48 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %47
  store i32 %46, i32* %48, align 4
  %49 = load i64, i64* %4, align 8
  %50 = add i64 %49, 1
  store i64 %50, i64* %4, align 8
  %51 = load i64, i64* %3, align 8
  %52 = load i64, i64* %4, align 8
  %53 = sub i64 %51, %52
  %54 = sub i64 %53, 1
  %55 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %54
  %56 = load i32, i32* %55, align 4
  %57 = load i64, i64* %4, align 8
  %58 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %57
  store i32 %56, i32* %58, align 4
  %59 = load i64, i64* %4, align 8
  %60 = add i64 %59, 1
  store i64 %60, i64* %4, align 8
  %61 = load i64, i64* %3, align 8
  %62 = load i64, i64* %4, align 8
  %63 = sub i64 %61, %62
  %64 = sub i64 %63, 1
  %65 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %64
  %66 = load i32, i32* %65, align 4
  %67 = load i64, i64* %4, align 8
  %68 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %67
  store i32 %66, i32* %68, align 4
  %69 = load i64, i64* %4, align 8
  %70 = add i64 %69, 1
  store i64 %70, i64* %4, align 8
  %71 = load i64, i64* %3, align 8
  %72 = load i64, i64* %4, align 8
  %73 = sub i64 %71, %72
  %74 = sub i64 %73, 1
  %75 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %74
  %76 = load i32, i32* %75, align 4
  %77 = load i64, i64* %4, align 8
  %78 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %77
  store i32 %76, i32* %78, align 4
  %79 = load i64, i64* %4, align 8
  %80 = add i64 %79, 1
  store i64 %80, i64* %4, align 8
  br label %35

81:                                               ; preds = %35
  ret i32 0
}