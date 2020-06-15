; ModuleID = 'test_backend.ll'
source_filename = "bitcount5/src/bitcount5.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

@num_to_bits = external global [16 x i32], align 16

; Function Attrs: nounwind ssp uwtable
define i32 @countSetBitsRec(i32 %num) #0 {
entry:
  %cmp = icmp eq i32 %num, 0
  br i1 %cmp, label %cleanup, label %if.end

if.end:                                           ; preds = %entry
  %and111111 = mul i32 %num, 4
  %0 = and i32 %and111111, 60
  %1 = zext i32 %0 to i64
  %2 = ptrtoint [16 x i32]* @num_to_bits to i64
  %3 = add i64 %1, %2
  %4 = inttoptr i64 %3 to i32*
  %5 = load i32, i32* %4, align 4
  %shr222222 = udiv i32 %num, 16
  %call = tail call i32 @countSetBitsRec(i32 %shr222222)
  %add = add i32 %call, %5
  ret i32 %add

cleanup:                                          ; preds = %entry
  %6 = getelementptr inbounds [16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 0
  %7 = load i32, i32* %6, align 16
  ret i32 %7
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %0 = getelementptr inbounds [16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 0
  store i32 0, i32* %0, align 16
  %1 = ptrtoint [16 x i32]* @num_to_bits to i64
  %2 = add i64 %1, 4
  %3 = inttoptr i64 %2 to i32*
  store i32 1, i32* %3, align 4
  %4 = ptrtoint [16 x i32]* @num_to_bits to i64
  %5 = add i64 %4, 8
  %6 = inttoptr i64 %5 to i32*
  store i32 1, i32* %6, align 8
  %7 = ptrtoint [16 x i32]* @num_to_bits to i64
  %8 = add i64 %7, 12
  %9 = inttoptr i64 %8 to i32*
  store i32 2, i32* %9, align 4
  %10 = ptrtoint [16 x i32]* @num_to_bits to i64
  %11 = add i64 %10, 16
  %12 = inttoptr i64 %11 to i32*
  store i32 1, i32* %12, align 16
  %13 = ptrtoint [16 x i32]* @num_to_bits to i64
  %14 = add i64 %13, 20
  %15 = inttoptr i64 %14 to i32*
  store i32 2, i32* %15, align 4
  %16 = ptrtoint [16 x i32]* @num_to_bits to i64
  %17 = add i64 %16, 24
  %18 = inttoptr i64 %17 to i32*
  store i32 2, i32* %18, align 8
  %19 = ptrtoint [16 x i32]* @num_to_bits to i64
  %20 = add i64 %19, 28
  %21 = inttoptr i64 %20 to i32*
  store i32 3, i32* %21, align 4
  %22 = ptrtoint [16 x i32]* @num_to_bits to i64
  %23 = add i64 %22, 32
  %24 = inttoptr i64 %23 to i32*
  store i32 1, i32* %24, align 16
  %25 = ptrtoint [16 x i32]* @num_to_bits to i64
  %26 = add i64 %25, 36
  %27 = inttoptr i64 %26 to i32*
  store i32 2, i32* %27, align 4
  %28 = ptrtoint [16 x i32]* @num_to_bits to i64
  %29 = add i64 %28, 40
  %30 = inttoptr i64 %29 to i32*
  store i32 2, i32* %30, align 8
  %31 = ptrtoint [16 x i32]* @num_to_bits to i64
  %32 = add i64 %31, 44
  %33 = inttoptr i64 %32 to i32*
  store i32 3, i32* %33, align 4
  %34 = ptrtoint [16 x i32]* @num_to_bits to i64
  %35 = add i64 %34, 48
  %36 = inttoptr i64 %35 to i32*
  store i32 2, i32* %36, align 16
  %37 = ptrtoint [16 x i32]* @num_to_bits to i64
  %38 = add i64 %37, 52
  %39 = inttoptr i64 %38 to i32*
  store i32 3, i32* %39, align 4
  %40 = ptrtoint [16 x i32]* @num_to_bits to i64
  %41 = add i64 %40, 56
  %42 = inttoptr i64 %41 to i32*
  store i32 3, i32* %42, align 8
  %43 = ptrtoint [16 x i32]* @num_to_bits to i64
  %44 = add i64 %43, 60
  %45 = inttoptr i64 %44 to i32*
  store i32 4, i32* %45, align 4
  %call = tail call i64 (...) @read() #2
  %conv = trunc i64 %call to i32
  %call1 = tail call i32 @countSetBitsRec(i32 %conv)
  %conv2 = zext i32 %call1 to i64
  tail call void @write(i64 %conv2) #2
  ret i32 0
}

declare void @write(i64) #1

declare i64 @read(...) #1

attributes #0 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 15]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"clang version 10.0.0 (git@github.com:llvm/llvm-project.git d32170dbd5b0d54436537b6b75beaf44324e0c28)"}
