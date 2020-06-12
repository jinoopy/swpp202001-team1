; ModuleID = 'collatz_out.ll'
source_filename = "collatz/src/collatz.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: nounwind ssp uwtable
define i32 @collatz(i16* %iter, i32 %n) local_unnamed_addr #0 {
entry:
  %conv1 = zext i32 %n to i64
  tail call void @write(i64 %conv1) #2
  %cmp2 = icmp ult i32 %n, 2
  br i1 %cmp2, label %return, label %if.end

if.end:                                           ; preds = %entry, %cond.end
  %n.tr3 = phi i32 [ %cond, %cond.end ], [ %n, %entry ]
  %0 = load i16, i16* %iter, align 2
  %cmp3 = icmp slt i16 %0, 0
  br i1 %cmp3, label %return, label %if.end6

if.end6:                                          ; preds = %if.end
  %add = add i16 %0, 1
  store i16 %add, i16* %iter, align 2
  %1 = srem i32 %n.tr3, 2
  %cmp9 = icmp eq i32 %1, 0
  br i1 %cmp9, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end6
  %div2 = sdiv i32 %n.tr3, 2
  br label %cond.end

cond.false:                                       ; preds = %if.end6
  %mul = mul i32 %n.tr3, 3
  %add11 = add i32 %mul, 1
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %div2, %cond.true ], [ %add11, %cond.false ]
  %conv = zext i32 %cond to i64
  tail call void @write(i64 %conv) #2
  %cmp = icmp ult i32 %cond, 2
  br i1 %cmp, label %return, label %if.end

return:                                           ; preds = %if.end, %cond.end, %entry
  %retval.0 = phi i32 [ %n, %entry ], [ %cond, %cond.end ], [ -1, %if.end ]
  ret i32 %retval.0
}

declare void @write(i64) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
define i32 @main() local_unnamed_addr #0 {
entry:
  %call = tail call i64 (...) @read() #2
  %conv = trunc i64 %call to i32
  %conv.i11 = srem i64 %call, 4294967296
  call void @write(i64 %conv.i11) #2
  %cmp.i2 = icmp ult i32 %conv, 2
  br i1 %cmp.i2, label %collatz.exit, label %if.end6.i

if.end6.i:                                        ; preds = %entry, %cond.end.i
  %n.tr.i4 = phi i32 [ %cond.i, %cond.end.i ], [ %conv, %entry ]
  %iter.03 = phi i16 [ %add.i, %cond.end.i ], [ 0, %entry ]
  %0 = srem i32 %n.tr.i4, 2
  %cmp9.i = icmp eq i32 %0, 0
  br i1 %cmp9.i, label %cond.true.i, label %cond.false.i

cond.true.i:                                      ; preds = %if.end6.i
  %div.i2 = sdiv i32 %n.tr.i4, 2
  br label %cond.end.i

cond.false.i:                                     ; preds = %if.end6.i
  %mul.i = mul i32 %n.tr.i4, 3
  %add11.i = add i32 %mul.i, 1
  br label %cond.end.i

cond.end.i:                                       ; preds = %cond.false.i, %cond.true.i
  %cond.i = phi i32 [ %div.i2, %cond.true.i ], [ %add11.i, %cond.false.i ]
  %add.i = add nuw i16 %iter.03, 1
  %conv.i = zext i32 %cond.i to i64
  call void @write(i64 %conv.i) #2
  %cmp.i = icmp ult i32 %cond.i, 2
  %cmp3.i = icmp slt i16 %add.i, 0
  %or.cond = or i1 %cmp3.i, %cmp.i
  br i1 %or.cond, label %tailrecurse.i.collatz.exit_crit_edge, label %if.end6.i

tailrecurse.i.collatz.exit_crit_edge:             ; preds = %cond.end.i
  %phitmp = sext i16 %add.i to i64
  br label %collatz.exit

collatz.exit:                                     ; preds = %tailrecurse.i.collatz.exit_crit_edge, %entry
  %iter.0.lcssa = phi i64 [ %phitmp, %tailrecurse.i.collatz.exit_crit_edge ], [ 0, %entry ]
  call void @write(i64 %iter.0.lcssa) #2
  ret i32 0
}

declare i64 @read(...) local_unnamed_addr #1

declare i8* @malloc(i64)

attributes #0 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 15]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"clang version 10.0.0 (git@github.com:llvm/llvm-project.git d32170dbd5b0d54436537b6b75beaf44324e0c28)"}
