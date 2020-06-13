; ModuleID = 'src/optim/test-ir/input1.cpp'
source_filename = "src/optim/test-ir/input1.cpp"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: noinline nounwind  ssp uwtable
define i32 @_Z3fooi(i32) #0 {
  %2 = alloca i32, align 4
  %3 = alloca [10 x i32], align 16
  store i32 %0, i32* %2, align 4
  %4 = bitcast [10 x i32]* %3 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %4, i8 0, i64 40, i1 false)
  %5 = bitcast i8* %4 to [10 x i32]*
  %6 = getelementptr inbounds [10 x i32], [10 x i32]* %5, i32 0, i32 0
  store i32 1, i32* %6, align 16
  %7 = getelementptr inbounds [10 x i32], [10 x i32]* %5, i32 0, i32 1
  store i32 4, i32* %7, align 4
  %8 = getelementptr inbounds [10 x i32], [10 x i32]* %5, i32 0, i32 2
  store i32 6, i32* %8, align 8
  %9 = getelementptr inbounds [10 x i32], [10 x i32]* %5, i32 0, i32 3
  store i32 3, i32* %9, align 4
  %10 = getelementptr inbounds [10 x i32], [10 x i32]* %5, i32 0, i32 4
  store i32 5, i32* %10, align 16
  %11 = load i32, i32* %2, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [10 x i32], [10 x i32]* %3, i64 0, i64 %12
  %14 = load i32, i32* %13, align 4
  ret i32 %14
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

attributes #0 = { noinline nounwind  ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [3 x i32] [i32 10, i32 15, i32 4]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"Apple clang version 11.0.3 (clang-1103.0.32.62)"}
