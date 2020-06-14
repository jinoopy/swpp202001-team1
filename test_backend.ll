; ModuleID = 'test_backend.ll'
source_filename = "bitcount2/src/bitcount2.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: nounwind ssp uwtable
define i32 @countSetBits(i32 %n) #0 {
entry:
  %cmp1 = icmp eq i32 %n, 0
  br i1 %cmp1, label %return, label %if.else

if.else:                                          ; preds = %if.else, %entry
  %n.tr3 = phi i32 [ %shr1, %if.else ], [ %n, %entry ]
  %accumulator.tr2 = phi i32 [ %add, %if.else ], [ 0, %entry ]
  %and1 = srem i32 %n.tr3, 2
  %shr1 = sdiv i32 %n.tr3, 2
  %add = add nsw i32 %and1, %accumulator.tr2
  %n.tr3.off = add i32 %n.tr3, 1
  %0 = icmp ult i32 %n.tr3.off, 3
  br i1 %0, label %return, label %if.else

return:                                           ; preds = %if.else, %entry
  %accumulator.tr.lcssa = phi i32 [ 0, %entry ], [ %add, %if.else ]
  ret i32 %accumulator.tr.lcssa
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %call = tail call i64 (...) @read() #2
  %conv = trunc i64 %call to i32
  %cmp.i1 = icmp eq i32 %conv, 0
  br i1 %cmp.i1, label %countSetBits.exit, label %if.else.i

if.else.i:                                        ; preds = %if.else.i, %entry
  %n.tr.i3 = phi i32 [ %shr.i1, %if.else.i ], [ %conv, %entry ]
  %accumulator.tr.i2 = phi i32 [ %add.i, %if.else.i ], [ 0, %entry ]
  %and.i1 = srem i32 %n.tr.i3, 2
  %shr.i1 = sdiv i32 %n.tr.i3, 2
  %add.i = add nsw i32 %and.i1, %accumulator.tr.i2
  %n.tr.i3.off = add i32 %n.tr.i3, 1
  %0 = icmp ult i32 %n.tr.i3.off, 3
  br i1 %0, label %tailrecurse.i.countSetBits.exit_crit_edge, label %if.else.i

tailrecurse.i.countSetBits.exit_crit_edge:        ; preds = %if.else.i
  %phitmp = sext i32 %add.i to i64
  br label %countSetBits.exit

countSetBits.exit:                                ; preds = %tailrecurse.i.countSetBits.exit_crit_edge, %entry
  %accumulator.tr.i.lcssa = phi i64 [ %phitmp, %tailrecurse.i.countSetBits.exit_crit_edge ], [ 0, %entry ]
  tail call void @write(i64 %accumulator.tr.i.lcssa) #2
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
