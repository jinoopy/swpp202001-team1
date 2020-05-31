; ModuleID = 'dev/test/cpp/test9.cpp'
source_filename = "dev/test/cpp/test9.cpp"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: noinline nounwind  ssp uwtable
define i32 @_Z3fooii(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i8, align 1
  %9 = alloca i8, align 1
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i8, align 1
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i8, align 1
  %17 = alloca i8, align 1
  %18 = alloca i8, align 1
  %19 = alloca i8, align 1
  %20 = alloca i8, align 1
  %21 = alloca i32, align 4
  %22 = alloca i8, align 1
  %23 = alloca i32, align 4
  %24 = alloca i8, align 1
  %25 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %26 = load i32, i32* %3, align 4
  %27 = icmp slt i32 %26, 1
  %28 = zext i1 %27 to i32
  store i32 %28, i32* %5, align 4
  %29 = load i32, i32* %4, align 4
  %30 = icmp sgt i32 %29, 1
  %31 = zext i1 %30 to i32
  store i32 %31, i32* %6, align 4
  %32 = load i32, i32* %5, align 4
  %33 = load i32, i32* %6, align 4
  %34 = and i32 %32, %33
  store i32 %34, i32* %7, align 4
  %35 = load i32, i32* %3, align 4
  %36 = icmp slt i32 %35, 2
  %37 = zext i1 %36 to i8
  store i8 %37, i8* %8, align 1
  %38 = load i32, i32* %4, align 4
  %39 = icmp sgt i32 %38, 2
  %40 = zext i1 %39 to i8
  store i8 %40, i8* %9, align 1
  %41 = load i8, i8* %8, align 1
  %42 = trunc i8 %41 to i1
  %43 = zext i1 %42 to i32
  %44 = load i8, i8* %9, align 1
  %45 = trunc i8 %44 to i1
  %46 = zext i1 %45 to i32
  %47 = and i32 %43, %46
  store i32 %47, i32* %10, align 4
  %48 = load i32, i32* %3, align 4
  %49 = icmp slt i32 %48, 3
  %50 = zext i1 %49 to i32
  store i32 %50, i32* %11, align 4
  %51 = load i32, i32* %4, align 4
  %52 = icmp sgt i32 %51, 3
  %53 = zext i1 %52 to i8
  store i8 %53, i8* %12, align 1
  %54 = load i32, i32* %11, align 4
  %55 = load i8, i8* %12, align 1
  %56 = trunc i8 %55 to i1
  %57 = zext i1 %56 to i32
  %58 = and i32 %54, %57
  store i32 %58, i32* %13, align 4
  %59 = load i32, i32* %3, align 4
  %60 = icmp slt i32 %59, 4
  %61 = zext i1 %60 to i32
  store i32 %61, i32* %14, align 4
  %62 = load i32, i32* %4, align 4
  %63 = icmp sgt i32 %62, 4
  %64 = zext i1 %63 to i32
  store i32 %64, i32* %15, align 4
  %65 = load i32, i32* %14, align 4
  %66 = load i32, i32* %15, align 4
  %67 = and i32 %65, %66
  %68 = icmp ne i32 %67, 0
  %69 = zext i1 %68 to i8
  store i8 %69, i8* %16, align 1
  %70 = load i32, i32* %3, align 4
  %71 = icmp slt i32 %70, 5
  %72 = zext i1 %71 to i8
  store i8 %72, i8* %17, align 1
  %73 = load i32, i32* %4, align 4
  %74 = icmp sgt i32 %73, 5
  %75 = zext i1 %74 to i8
  store i8 %75, i8* %18, align 1
  %76 = load i8, i8* %17, align 1
  %77 = trunc i8 %76 to i1
  %78 = zext i1 %77 to i32
  %79 = load i8, i8* %18, align 1
  %80 = trunc i8 %79 to i1
  %81 = zext i1 %80 to i32
  %82 = and i32 %78, %81
  %83 = icmp ne i32 %82, 0
  %84 = zext i1 %83 to i8
  store i8 %84, i8* %19, align 1
  %85 = load i32, i32* %3, align 4
  %86 = icmp slt i32 %85, 6
  %87 = zext i1 %86 to i8
  store i8 %87, i8* %20, align 1
  %88 = load i32, i32* %4, align 4
  %89 = icmp sgt i32 %88, 6
  %90 = zext i1 %89 to i32
  store i32 %90, i32* %21, align 4
  %91 = load i8, i8* %20, align 1
  %92 = trunc i8 %91 to i1
  %93 = zext i1 %92 to i32
  %94 = load i32, i32* %21, align 4
  %95 = and i32 %93, %94
  %96 = icmp ne i32 %95, 0
  %97 = zext i1 %96 to i8
  store i8 %97, i8* %22, align 1
  %98 = load i32, i32* %3, align 4
  %99 = icmp slt i32 %98, 7
  %100 = zext i1 %99 to i32
  %101 = load i32, i32* %4, align 4
  %102 = icmp sgt i32 %101, 7
  %103 = zext i1 %102 to i32
  %104 = and i32 %100, %103
  store i32 %104, i32* %23, align 4
  %105 = load i32, i32* %3, align 4
  %106 = icmp slt i32 %105, 8
  %107 = zext i1 %106 to i32
  %108 = load i32, i32* %4, align 4
  %109 = icmp sgt i32 %108, 8
  %110 = zext i1 %109 to i32
  %111 = and i32 %107, %110
  %112 = icmp ne i32 %111, 0
  %113 = zext i1 %112 to i8
  store i8 %113, i8* %24, align 1
  %114 = load i32, i32* %3, align 4
  %115 = load i32, i32* %4, align 4
  %116 = and i32 %114, %115
  store i32 %116, i32* %25, align 4
  %117 = load i32, i32* %7, align 4
  %118 = load i32, i32* %10, align 4
  %119 = add nsw i32 %117, %118
  %120 = load i32, i32* %13, align 4
  %121 = add nsw i32 %119, %120
  %122 = load i8, i8* %16, align 1
  %123 = trunc i8 %122 to i1
  %124 = zext i1 %123 to i32
  %125 = add nsw i32 %121, %124
  %126 = load i8, i8* %19, align 1
  %127 = trunc i8 %126 to i1
  %128 = zext i1 %127 to i32
  %129 = add nsw i32 %125, %128
  %130 = load i8, i8* %22, align 1
  %131 = trunc i8 %130 to i1
  %132 = zext i1 %131 to i32
  %133 = add nsw i32 %129, %132
  %134 = load i32, i32* %23, align 4
  %135 = add nsw i32 %133, %134
  %136 = load i8, i8* %24, align 1
  %137 = trunc i8 %136 to i1
  %138 = zext i1 %137 to i32
  %139 = add nsw i32 %135, %138
  %140 = load i32, i32* %25, align 4
  %141 = add nsw i32 %139, %140
  ret i32 %141
}

attributes #0 = { noinline nounwind  ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [3 x i32] [i32 10, i32 15, i32 4]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"Apple clang version 11.0.3 (clang-1103.0.32.62)"}
