; ModuleID = 'test_out.ll'
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
  %and11111 = urem i32 %num, 16
  %idxprom = zext i32 %and11111 to i64
  %arrayidx = getelementptr inbounds [16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4
  %shr22222 = udiv i32 %num, 16
  %call = tail call i32 @countSetBitsRec(i32 %shr22222)
  %add = add i32 %call, %0
  ret i32 %add

cleanup:                                          ; preds = %entry
  %1 = load i32, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 0), align 16
  ret i32 %1
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  store i32 0, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 0), align 16
  store i32 1, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 1), align 4
  store i32 1, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 2), align 8
  store i32 2, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 3), align 4
  store i32 1, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 4), align 16
  store i32 2, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 5), align 4
  store i32 2, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 6), align 8
  store i32 3, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 7), align 4
  store i32 1, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 8), align 16
  store i32 2, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 9), align 4
  store i32 2, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 10), align 8
  store i32 3, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 11), align 4
  store i32 2, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 12), align 16
  store i32 3, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 13), align 4
  store i32 3, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 14), align 8
  store i32 4, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @num_to_bits, i64 0, i64 15), align 4
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
