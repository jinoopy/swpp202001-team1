; ModuleID = 'test_out.ll'
source_filename = "bitcount4/src/bitcount4.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

@BitsSetTable256 = external global [256 x i32], align 16

; Function Attrs: nounwind ssp uwtable
define i32 @countSetBits(i32 %n) #0 {
entry:
  %and2 = srem i32 %n, 256
  %idxprom = sext i32 %and2 to i64
  %arrayidx = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4
  %shr3 = sdiv i32 %n, 256
  %and11 = srem i32 %shr3, 256
  %idxprom2 = zext i32 %and11 to i64
  %arrayidx3 = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom2
  %1 = load i32, i32* %arrayidx3, align 4
  %add = add nsw i32 %1, %0
  %shr44 = sdiv i32 %n, 65536
  %and52 = srem i32 %shr44, 256
  %idxprom6 = zext i32 %and52 to i64
  %arrayidx7 = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom6
  %2 = load i32, i32* %arrayidx7, align 4
  %add8 = add nsw i32 %add, %2
  %shr95 = sdiv i32 %n, 16777216
  %idxprom10 = sext i32 %shr95 to i64
  %arrayidx11 = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom10
  %3 = load i32, i32* %arrayidx11, align 4
  %add12 = add nsw i32 %add8, %3
  ret i32 %add12
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  store i32 0, i32* getelementptr inbounds ([256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 0), align 16
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %call = tail call i64 (...) @read() #2
  %conv = trunc i64 %call to i32
  %and.i1 = srem i32 %conv, 256
  %idxprom.i = sext i32 %and.i1 to i64
  %arrayidx.i = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom.i
  %0 = load i32, i32* %arrayidx.i, align 4
  %shr.i2 = sdiv i32 %conv, 256
  %and1.i1 = srem i32 %shr.i2, 256
  %idxprom2.i = zext i32 %and1.i1 to i64
  %arrayidx3.i = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom2.i
  %1 = load i32, i32* %arrayidx3.i, align 4
  %add.i = add nsw i32 %1, %0
  %shr4.i3 = sdiv i32 %conv, 65536
  %and5.i2 = srem i32 %shr4.i3, 256
  %idxprom6.i = zext i32 %and5.i2 to i64
  %arrayidx7.i = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom6.i
  %2 = load i32, i32* %arrayidx7.i, align 4
  %add8.i = add nsw i32 %add.i, %2
  %shr9.i4 = sdiv i32 %conv, 16777216
  %idxprom10.i = sext i32 %shr9.i4 to i64
  %arrayidx11.i = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom10.i
  %3 = load i32, i32* %arrayidx11.i, align 4
  %add12.i = add nsw i32 %add8.i, %3
  %conv4 = sext i32 %add12.i to i64
  tail call void @write(i64 %conv4) #2
  ret i32 0

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next.1, %for.body ]
  %4 = trunc i64 %indvars.iv to i32
  %div111 = sdiv i32 %4, 2
  %idxprom = zext i32 %div111 to i64
  %arrayidx = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom
  %5 = load i32, i32* %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %indvars.iv
  store i32 %5, i32* %arrayidx2, align 8
  %indvars.iv.next = or i64 %indvars.iv, 1
  %6 = trunc i64 %indvars.iv.next to i32
  %div11.12 = sdiv i32 %6, 2
  %idxprom.1 = zext i32 %div11.12 to i64
  %arrayidx.1 = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %idxprom.1
  %7 = load i32, i32* %arrayidx.1, align 4
  %add.1 = add nsw i32 %7, 1
  %arrayidx2.1 = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 %indvars.iv.next
  store i32 %add.1, i32* %arrayidx2.1, align 4
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2
  %exitcond.1 = icmp eq i64 %indvars.iv.next.1, 256
  br i1 %exitcond.1, label %for.cond.cleanup, label %for.body
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
