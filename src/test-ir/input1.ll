define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [1024 x i32], align 16
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  store i64 1024, i64* %3, align 8
  store i32 0, i32* %4, align 4
  store i64 0, i64* %5, align 8
  br label %7

7:                                                ; preds = %11, %0
  %8 = load i64, i64* %5, align 8
  %9 = load i64, i64* %3, align 8
  %10 = icmp ult i64 %8, %9
  br i1 %10, label %11, label %44

11:                                               ; preds = %7
  %12 = load i64, i64* %5, align 8
  %13 = load i64, i64* %5, align 8
  %14 = mul i64 %12, %13
  %15 = trunc i64 %14 to i32
  %16 = load i64, i64* %5, align 8
  %17 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %16
  store i32 %15, i32* %17, align 4
  %18 = load i64, i64* %5, align 8
  %19 = add i64 %18, 1
  store i64 %19, i64* %5, align 8
  %20 = load i64, i64* %5, align 8
  %21 = load i64, i64* %5, align 8
  %22 = mul i64 %20, %21
  %23 = trunc i64 %22 to i32
  %24 = load i64, i64* %5, align 8
  %25 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %24
  store i32 %23, i32* %25, align 4
  %26 = load i64, i64* %5, align 8
  %27 = add i64 %26, 1
  store i64 %27, i64* %5, align 8
  %28 = load i64, i64* %5, align 8
  %29 = load i64, i64* %5, align 8
  %30 = mul i64 %28, %29
  %31 = trunc i64 %30 to i32
  %32 = load i64, i64* %5, align 8
  %33 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %32
  store i32 %31, i32* %33, align 4
  %34 = load i64, i64* %5, align 8
  %35 = add i64 %34, 1
  store i64 %35, i64* %5, align 8
  %36 = load i64, i64* %5, align 8
  %37 = load i64, i64* %5, align 8
  %38 = mul i64 %36, %37
  %39 = trunc i64 %38 to i32
  %40 = load i64, i64* %5, align 8
  %41 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %40
  store i32 %39, i32* %41, align 4
  %42 = load i64, i64* %5, align 8
  %43 = add i64 %42, 1
  store i64 %43, i64* %5, align 8
  br label %7

44:                                               ; preds = %7
  store i64 0, i64* %6, align 8
  br label %45

45:                                               ; preds = %49, %44
  %46 = load i64, i64* %6, align 8
  %47 = load i64, i64* %3, align 8
  %48 = icmp ult i64 %46, %47
  br i1 %48, label %49, label %78

49:                                               ; preds = %45
  %50 = load i64, i64* %6, align 8
  %51 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %50
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* %4, align 4
  %54 = add nsw i32 %53, %52
  store i32 %54, i32* %4, align 4
  %55 = load i64, i64* %6, align 8
  %56 = add i64 %55, 1
  store i64 %56, i64* %6, align 8
  %57 = load i64, i64* %6, align 8
  %58 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %57
  %59 = load i32, i32* %58, align 4
  %60 = load i32, i32* %4, align 4
  %61 = add nsw i32 %60, %59
  store i32 %61, i32* %4, align 4
  %62 = load i64, i64* %6, align 8
  %63 = add i64 %62, 1
  store i64 %63, i64* %6, align 8
  %64 = load i64, i64* %6, align 8
  %65 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %64
  %66 = load i32, i32* %65, align 4
  %67 = load i32, i32* %4, align 4
  %68 = add nsw i32 %67, %66
  store i32 %68, i32* %4, align 4
  %69 = load i64, i64* %6, align 8
  %70 = add i64 %69, 1
  store i64 %70, i64* %6, align 8
  %71 = load i64, i64* %6, align 8
  %72 = getelementptr inbounds [1024 x i32], [1024 x i32]* %2, i64 0, i64 %71
  %73 = load i32, i32* %72, align 4
  %74 = load i32, i32* %4, align 4
  %75 = add nsw i32 %74, %73
  store i32 %75, i32* %4, align 4
  %76 = load i64, i64* %6, align 8
  %77 = add i64 %76, 1
  store i64 %77, i64* %6, align 8
  br label %45

78:                                               ; preds = %45
  %79 = load i32, i32* %4, align 4
  ret i32 %79
}
