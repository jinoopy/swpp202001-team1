; ModuleID = 'test_backend.ll'
source_filename = "bitcount4/src/bitcount4.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

@BitsSetTable256 = external global [256 x i32], align 16

; Function Attrs: nounwind ssp uwtable
define i32 @countSetBits(i32 %n) #0 {
entry:
  %and2 = srem i32 %n, 256
  %idxprom = sext i32 %and2 to i64
  %0 = mul i64 %idxprom, 4
  %1 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %2 = add i64 %0, %1
  %3 = inttoptr i64 %2 to i32*
  %4 = load i32, i32* %3, align 4
  %shr3 = sdiv i32 %n, 256
  %and11 = srem i32 %shr3, 256
  %idxprom2 = zext i32 %and11 to i64
  %5 = mul i64 %idxprom2, 4
  %6 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %7 = add i64 %5, %6
  %8 = inttoptr i64 %7 to i32*
  %9 = load i32, i32* %8, align 4
  %add = add nsw i32 %9, %4
  %shr44 = sdiv i32 %n, 65536
  %and52 = srem i32 %shr44, 256
  %idxprom6 = zext i32 %and52 to i64
  %10 = mul i64 %idxprom6, 4
  %11 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %12 = add i64 %10, %11
  %13 = inttoptr i64 %12 to i32*
  %14 = load i32, i32* %13, align 4
  %add8 = add nsw i32 %add, %14
  %shr95 = sdiv i32 %n, 16777216
  %idxprom10 = sext i32 %shr95 to i64
  %15 = mul i64 %idxprom10, 4
  %16 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %17 = add i64 %15, %16
  %18 = inttoptr i64 %17 to i32*
  %19 = load i32, i32* %18, align 4
  %add12 = add nsw i32 %add8, %19
  ret i32 %add12
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %0 = getelementptr inbounds [256 x i32], [256 x i32]* @BitsSetTable256, i64 0, i64 0
  store i32 0, i32* %0, align 16
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %call = tail call i64 (...) @read() #2
  %conv = trunc i64 %call to i32
  %and.i1 = srem i32 %conv, 256
  %idxprom.i = sext i32 %and.i1 to i64
  %1 = mul i64 %idxprom.i, 4
  %2 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %3 = add i64 %1, %2
  %4 = inttoptr i64 %3 to i32*
  %5 = load i32, i32* %4, align 4
  %shr.i2 = sdiv i32 %conv, 256
  %and1.i1 = srem i32 %shr.i2, 256
  %idxprom2.i = zext i32 %and1.i1 to i64
  %6 = mul i64 %idxprom2.i, 4
  %7 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %8 = add i64 %6, %7
  %9 = inttoptr i64 %8 to i32*
  %10 = load i32, i32* %9, align 4
  %add.i = add nsw i32 %10, %5
  %shr4.i3 = sdiv i32 %conv, 65536
  %and5.i2 = srem i32 %shr4.i3, 256
  %idxprom6.i = zext i32 %and5.i2 to i64
  %11 = mul i64 %idxprom6.i, 4
  %12 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %13 = add i64 %11, %12
  %14 = inttoptr i64 %13 to i32*
  %15 = load i32, i32* %14, align 4
  %add8.i = add nsw i32 %add.i, %15
  %shr9.i4 = sdiv i32 %conv, 16777216
  %idxprom10.i = sext i32 %shr9.i4 to i64
  %16 = mul i64 %idxprom10.i, 4
  %17 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %18 = add i64 %16, %17
  %19 = inttoptr i64 %18 to i32*
  %20 = load i32, i32* %19, align 4
  %add12.i = add nsw i32 %add8.i, %20
  %conv4 = sext i32 %add12.i to i64
  tail call void @write(i64 %conv4) #2
  ret i32 0

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next.1, %for.body ]
  %21 = trunc i64 %indvars.iv to i32
  %div111 = sdiv i32 %21, 2
  %idxprom = zext i32 %div111 to i64
  %22 = mul i64 %idxprom, 4
  %23 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %24 = add i64 %22, %23
  %25 = inttoptr i64 %24 to i32*
  %26 = load i32, i32* %25, align 4
  %27 = mul i64 %indvars.iv, 4
  %28 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %29 = add i64 %27, %28
  %30 = inttoptr i64 %29 to i32*
  store i32 %26, i32* %30, align 8
  %indvars.iv.next = or i64 %indvars.iv, 1
  %31 = trunc i64 %indvars.iv.next to i32
  %div11.12 = sdiv i32 %31, 2
  %idxprom.1 = zext i32 %div11.12 to i64
  %32 = mul i64 %idxprom.1, 4
  %33 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %34 = add i64 %32, %33
  %35 = inttoptr i64 %34 to i32*
  %36 = load i32, i32* %35, align 4
  %add.1 = add nsw i32 %36, 1
  %37 = mul i64 %indvars.iv.next, 4
  %38 = ptrtoint [256 x i32]* @BitsSetTable256 to i64
  %39 = add i64 %37, %38
  %40 = inttoptr i64 %39 to i32*
  store i32 %add.1, i32* %40, align 4
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
