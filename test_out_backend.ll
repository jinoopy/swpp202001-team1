; ModuleID = 'test_out_backend.ll'
source_filename = "bitcount1/src/bitcount1.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: nounwind ssp uwtable
define i32 @countSetBits(i32 %n) local_unnamed_addr #0 {
entry:
  %tobool1 = icmp eq i32 %n, 0
  br i1 %tobool1, label %while.end, label %while.body

while.body:                                       ; preds = %while.body, %entry
  %count.03 = phi i32 [ %add, %while.body ], [ 0, %entry ]
  %n.addr.02 = phi i32 [ %shr2, %while.body ], [ %n, %entry ]
  %and1 = srem i32 %n.addr.02, 2
  %add = add i32 %and1, %count.03
  %shr2 = sdiv i32 %n.addr.02, 2
  %n.addr.02.off = add i32 %n.addr.02, 1
  %0 = icmp ult i32 %n.addr.02.off, 3
  br i1 %0, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %entry
  %count.0.lcssa = phi i32 [ 0, %entry ], [ %add, %while.body ]
  ret i32 %count.0.lcssa
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() local_unnamed_addr #0 {
entry:
  %call = tail call i64 (...) @read() #2
  %conv = trunc i64 %call to i32
  %tobool.i1 = icmp eq i32 %conv, 0
  br i1 %tobool.i1, label %countSetBits.exit, label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %entry
  %count.0.i3 = phi i32 [ %add.i, %while.body.i ], [ 0, %entry ]
  %n.addr.0.i2 = phi i32 [ %shr.i2, %while.body.i ], [ %conv, %entry ]
  %and.i1 = srem i32 %n.addr.0.i2, 2
  %add.i = add i32 %and.i1, %count.0.i3
  %shr.i2 = sdiv i32 %n.addr.0.i2, 2
  %n.addr.0.i2.off = add i32 %n.addr.0.i2, 1
  %0 = icmp ult i32 %n.addr.0.i2.off, 3
  br i1 %0, label %while.cond.i.countSetBits.exit_crit_edge, label %while.body.i

while.cond.i.countSetBits.exit_crit_edge:         ; preds = %while.body.i
  %phitmp = zext i32 %add.i to i64
  br label %countSetBits.exit

countSetBits.exit:                                ; preds = %while.cond.i.countSetBits.exit_crit_edge, %entry
  %count.0.i.lcssa = phi i64 [ %phitmp, %while.cond.i.countSetBits.exit_crit_edge ], [ 0, %entry ]
  tail call void @write(i64 %count.0.i.lcssa) #2
  ret i32 0
}

declare i64 @read(...) local_unnamed_addr #1

declare void @write(i64) local_unnamed_addr #1

attributes #0 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 15]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"clang version 10.0.0 (git@github.com:llvm/llvm-project.git d32170dbd5b0d54436537b6b75beaf44324e0c28)"}
