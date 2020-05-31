; ModuleID = 'dev/test/cpp/test5.cpp'
source_filename = "dev/test/cpp/test5.cpp"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: noinline nounwind  ssp uwtable
define i32 @_Z3fooi(i32) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8, align 1
  store i32 %0, i32* %2, align 4
  %6 = load i32, i32* %2, align 4
  %7 = load i32, i32* %2, align 4
  %8 = load i32, i32* %2, align 4
  %9 = sub nsw i32 %7, %8
  %10 = sub nsw i32 %9, 1
  %11 = and i32 %6, %10
  store i32 %11, i32* %3, align 4
  %12 = load i32, i32* %2, align 4
  %13 = ashr i32 %12, 2
  store i32 %13, i32* %4, align 4
  %14 = load i32, i32* %3, align 4
  %15 = icmp sgt i32 %14, 10
  %16 = zext i1 %15 to i32
  %17 = load i32, i32* %4, align 4
  %18 = icmp slt i32 %17, 3
  br i1 %18, label %22, label %19

19:                                               ; preds = %1
  %20 = load i32, i32* %4, align 4
  %21 = icmp eq i32 %20, 10
  br label %22

22:                                               ; preds = %19, %1
  %23 = phi i1 [ true, %1 ], [ %21, %19 ]
  %24 = zext i1 %23 to i32
  %25 = and i32 %16, %24
  %26 = icmp ne i32 %25, 0
  %27 = zext i1 %26 to i8
  store i8 %27, i8* %5, align 1
  %28 = load i8, i8* %5, align 1
  %29 = trunc i8 %28 to i1
  %30 = zext i1 %29 to i32
  ret i32 %30
}

attributes #0 = { noinline nounwind  ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [3 x i32] [i32 10, i32 15, i32 4]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"Apple clang version 11.0.3 (clang-1103.0.32.62)"}
