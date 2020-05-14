; ModuleID = 'input4.ll'
source_filename = "input4.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline norecurse nounwind uwtable
define i32 @main() #0 {
  %1 = alloca [100 x i16], align 16
  br label %2

2:                                                ; preds = %2, %0
  %.01 = phi i64 [ 0, %0 ], [ %32, %2 ]
  %3 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %.01
  %4 = load i16, i16* %3, align 2
  %5 = sext i16 %4 to i32
  %6 = mul nsw i32 %5, 2
  %7 = trunc i32 %6 to i16
  store i16 %7, i16* %3, align 2
  %8 = add nuw nsw i64 %.01, 1
  %9 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %8
  %10 = load i16, i16* %9, align 2
  %11 = sext i16 %10 to i32
  %12 = mul nsw i32 %11, 2
  %13 = trunc i32 %12 to i16
  store i16 %13, i16* %9, align 2
  %14 = add nuw nsw i64 %8, 1
  %15 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %14
  %16 = load i16, i16* %15, align 2
  %17 = sext i16 %16 to i32
  %18 = mul nsw i32 %17, 2
  %19 = trunc i32 %18 to i16
  store i16 %19, i16* %15, align 2
  %20 = add nuw nsw i64 %14, 1
  %21 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %20
  %22 = load i16, i16* %21, align 2
  %23 = sext i16 %22 to i32
  %24 = mul nsw i32 %23, 2
  %25 = trunc i32 %24 to i16
  store i16 %25, i16* %21, align 2
  %26 = add nuw nsw i64 %20, 1
  %27 = getelementptr inbounds [100 x i16], [100 x i16]* %1, i64 0, i64 %26
  %28 = load i16, i16* %27, align 2
  %29 = sext i16 %28 to i32
  %30 = mul nsw i32 %29, 2
  %31 = trunc i32 %30 to i16
  store i16 %31, i16* %27, align 2
  %32 = add nuw nsw i64 %26, 1
  %exitcond.4 = icmp ne i64 %32, 100
  br i1 %exitcond.4, label %2, label %33

33:                                               ; preds = %2
  ret i32 0
}

attributes #0 = { noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
