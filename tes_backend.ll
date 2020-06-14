; ModuleID = 'tes_backend.ll'
source_filename = "prime/src/prime.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

@primes = external global i64*, align 8
@tail = external global i64*, align 8

; Function Attrs: allocsize(0)
declare noalias i8* @malloc(i64) #0

; Function Attrs: nounwind ssp uwtable
define i32 @main() #1 {
entry:
  %alloca_ma0 = alloca i64, align 8
  %call = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #3
  %0 = bitcast i8* %call to i64*
  %1 = bitcast i64** @primes to i8**
  store i8* %call, i8** %1, align 8
  store i64 2, i64* %0, align 8
  %2 = ptrtoint i8* %call to i64
  %3 = add i64 %2, 8
  %4 = inttoptr i64 %3 to i64*
  store i64 0, i64* %4, align 8
  %5 = bitcast i64** @tail to i8**
  store i8* %call, i8** %5, align 8
  store i64 2, i64* %alloca_ma0, align 8
  %call11 = tail call i64 (...) @read() #4
  %cmp2 = icmp eq i64 %call11, 0
  br i1 %cmp2, label %while.end, label %if.end

if.end:                                           ; preds = %if.end, %entry
  %call13 = phi i64 [ %call1, %if.end ], [ %call11, %entry ]
  %call21 = tail call i64 @is_prime.3(i64 %call13, i64* nonnull %alloca_ma0)
  tail call void @write(i64 %call21) #4
  %call1 = tail call i64 (...) @read() #4
  %cmp = icmp eq i64 %call1, 0
  br i1 %cmp, label %while.end, label %if.end

while.end:                                        ; preds = %if.end, %entry
  ret i32 0
}

declare i64 @read(...) #2

declare void @write(i64) #2

; Function Attrs: nounwind ssp uwtable
define i64 @check_with_primes.1(i64 %n, i64* %gv0) #1 {
entry:
  %0 = load i64*, i64** @primes, align 8
  br label %while.cond

while.cond:                                       ; preds = %cleanup, %entry
  %curr.0 = phi i64* [ %0, %entry ], [ %curr.1, %cleanup ]
  %cmp = icmp eq i64* %curr.0, null
  br i1 %cmp, label %cleanup5.loopexit1, label %while.body

while.body:                                       ; preds = %while.cond
  %1 = load i64, i64* %curr.0, align 8
  %mul = mul i64 %1, %1
  %cmp1 = icmp ugt i64 %mul, %n
  br i1 %cmp1, label %cleanup, label %if.end

if.end:                                           ; preds = %while.body
  %rem = urem i64 %n, %1
  %cmp2 = icmp eq i64 %rem, 0
  br i1 %cmp2, label %cleanup, label %if.end4

if.end4:                                          ; preds = %if.end
  %2 = ptrtoint i64* %curr.0 to i64
  %3 = add i64 %2, 8
  %4 = inttoptr i64 %3 to i64**
  %5 = load i64*, i64** %4, align 8
  br label %cleanup

cleanup:                                          ; preds = %if.end4, %if.end, %while.body
  %curr.1 = phi i64* [ %5, %if.end4 ], [ %curr.0, %while.body ], [ %curr.0, %if.end ]
  %cleanup.dest.slot.0 = phi i32 [ 0, %if.end4 ], [ 3, %while.body ], [ 1, %if.end ]
  switch i32 %cleanup.dest.slot.0, label %cleanup5 [
    i32 0, label %while.cond
    i32 3, label %cleanup5.loopexit1
  ]

cleanup5.loopexit1:                               ; preds = %cleanup, %while.cond
  br label %cleanup5

cleanup5:                                         ; preds = %cleanup5.loopexit1, %cleanup
  %retval.2 = phi i64 [ 1, %cleanup5.loopexit1 ], [ 0, %cleanup ]
  ret i64 %retval.2
}

; Function Attrs: nounwind ssp uwtable
define i64 @add_primes.2(i64 %n, i64* %gv0) #1 {
entry:
  %0 = load i64, i64* %gv0, align 8
  %mul1 = mul i64 %0, %0
  %cmp2 = icmp ult i64 %mul1, %n
  br i1 %cmp2, label %while.body, label %return

while.body:                                       ; preds = %if.end5, %entry
  %1 = phi i64 [ %19, %if.end5 ], [ %0, %entry ]
  %inc = add i64 %1, 1
  store i64 %inc, i64* %gv0, align 8
  %2 = load i64*, i64** @primes, align 8
  br label %while.cond.i

while.cond.i:                                     ; preds = %cleanup.i, %while.body
  %curr.0.i = phi i64* [ %2, %while.body ], [ %curr.1.i, %cleanup.i ]
  %cmp.i = icmp eq i64* %curr.0.i, null
  br i1 %cmp.i, label %while.end.i, label %while.body.i

while.body.i:                                     ; preds = %while.cond.i
  %3 = load i64, i64* %curr.0.i, align 8
  %mul.i = mul i64 %3, %3
  %cmp1.i = icmp ugt i64 %mul.i, %inc
  br i1 %cmp1.i, label %cleanup.i, label %if.end.i

if.end.i:                                         ; preds = %while.body.i
  %rem.i = urem i64 %inc, %3
  %cmp2.i = icmp eq i64 %rem.i, 0
  br i1 %cmp2.i, label %cleanup.i, label %if.end4.i

if.end4.i:                                        ; preds = %if.end.i
  %4 = ptrtoint i64* %curr.0.i to i64
  %5 = add i64 %4, 8
  %6 = inttoptr i64 %5 to i64**
  %7 = load i64*, i64** %6, align 8
  br label %cleanup.i

cleanup.i:                                        ; preds = %if.end4.i, %if.end.i, %while.body.i
  %curr.1.i = phi i64* [ %7, %if.end4.i ], [ %curr.0.i, %while.body.i ], [ %curr.0.i, %if.end.i ]
  %cleanup.dest.slot.0.i = phi i32 [ 0, %if.end4.i ], [ 3, %while.body.i ], [ 1, %if.end.i ]
  switch i32 %cleanup.dest.slot.0.i, label %if.end5 [
    i32 0, label %while.cond.i
    i32 3, label %while.end.i
  ]

while.end.i:                                      ; preds = %cleanup.i, %while.cond.i
  %call1 = tail call noalias dereferenceable_or_null(16) i8* @malloc(i64 16) #3
  %8 = bitcast i8* %call1 to i64*
  store i64 %inc, i64* %8, align 8
  %9 = ptrtoint i8* %call1 to i64
  %10 = add i64 %9, 8
  %11 = inttoptr i64 %10 to i64*
  store i64 0, i64* %11, align 8
  %12 = ptrtoint i8* %call1 to i64
  %13 = bitcast i64** @tail to i64*
  %14 = load i64, i64* %13, align 8
  %15 = add i64 %14, 8
  %16 = inttoptr i64 %15 to i64*
  store i64 %12, i64* %16, align 8
  %17 = bitcast i64** @tail to i8**
  store i8* %call1, i8** %17, align 8
  %18 = load i64, i64* %gv0, align 8
  %rem = urem i64 %n, %18
  %cmp3 = icmp eq i64 %rem, 0
  br i1 %cmp3, label %return, label %if.end5

if.end5:                                          ; preds = %while.end.i, %cleanup.i
  %19 = phi i64 [ %18, %while.end.i ], [ %inc, %cleanup.i ]
  %mul = mul i64 %19, %19
  %cmp = icmp ult i64 %mul, %n
  br i1 %cmp, label %while.body, label %return

return:                                           ; preds = %if.end5, %while.end.i, %entry
  %retval.3 = phi i64 [ 1, %entry ], [ 1, %if.end5 ], [ 0, %while.end.i ]
  ret i64 %retval.3
}

; Function Attrs: nounwind ssp uwtable
define i64 @is_prime.3(i64 %n, i64* %gv0) #1 {
entry:
  %0 = load i64*, i64** @primes, align 8
  br label %while.cond.i

while.cond.i:                                     ; preds = %cleanup.i, %entry
  %curr.0.i = phi i64* [ %0, %entry ], [ %curr.1.i, %cleanup.i ]
  %cmp.i = icmp eq i64* %curr.0.i, null
  br i1 %cmp.i, label %while.end.i, label %while.body.i

while.body.i:                                     ; preds = %while.cond.i
  %1 = load i64, i64* %curr.0.i, align 8
  %mul.i = mul i64 %1, %1
  %cmp1.i = icmp ugt i64 %mul.i, %n
  br i1 %cmp1.i, label %cleanup.i, label %if.end.i

if.end.i:                                         ; preds = %while.body.i
  %rem.i = urem i64 %n, %1
  %cmp2.i = icmp eq i64 %rem.i, 0
  br i1 %cmp2.i, label %cleanup.i, label %if.end4.i

if.end4.i:                                        ; preds = %if.end.i
  %2 = ptrtoint i64* %curr.0.i to i64
  %3 = add i64 %2, 8
  %4 = inttoptr i64 %3 to i64**
  %5 = load i64*, i64** %4, align 8
  br label %cleanup.i

cleanup.i:                                        ; preds = %if.end4.i, %if.end.i, %while.body.i
  %curr.1.i = phi i64* [ %5, %if.end4.i ], [ %curr.0.i, %while.body.i ], [ %curr.0.i, %if.end.i ]
  %cleanup.dest.slot.0.i = phi i32 [ 0, %if.end4.i ], [ 3, %while.body.i ], [ 1, %if.end.i ]
  switch i32 %cleanup.dest.slot.0.i, label %return [
    i32 0, label %while.cond.i
    i32 3, label %while.end.i
  ]

while.end.i:                                      ; preds = %cleanup.i, %while.cond.i
  %6 = load i64, i64* %gv0, align 8
  %mul.i11 = mul i64 %6, %6
  %cmp.i22 = icmp ult i64 %mul.i11, %n
  br i1 %cmp.i22, label %while.body.i4, label %return

while.body.i4:                                    ; preds = %if.end5.i, %while.end.i
  %7 = phi i64 [ %25, %if.end5.i ], [ %6, %while.end.i ]
  %inc.i = add i64 %7, 1
  store i64 %inc.i, i64* %gv0, align 8
  %8 = load i64*, i64** @primes, align 8
  br label %while.cond.i.i

while.cond.i.i:                                   ; preds = %cleanup.i.i, %while.body.i4
  %curr.0.i.i = phi i64* [ %8, %while.body.i4 ], [ %curr.1.i.i, %cleanup.i.i ]
  %cmp.i.i = icmp eq i64* %curr.0.i.i, null
  br i1 %cmp.i.i, label %while.end.i.i, label %while.body.i.i

while.body.i.i:                                   ; preds = %while.cond.i.i
  %9 = load i64, i64* %curr.0.i.i, align 8
  %mul.i.i = mul i64 %9, %9
  %cmp1.i.i = icmp ugt i64 %mul.i.i, %inc.i
  br i1 %cmp1.i.i, label %cleanup.i.i, label %if.end.i.i

if.end.i.i:                                       ; preds = %while.body.i.i
  %rem.i.i = urem i64 %inc.i, %9
  %cmp2.i.i = icmp eq i64 %rem.i.i, 0
  br i1 %cmp2.i.i, label %cleanup.i.i, label %if.end4.i.i

if.end4.i.i:                                      ; preds = %if.end.i.i
  %10 = ptrtoint i64* %curr.0.i.i to i64
  %11 = add i64 %10, 8
  %12 = inttoptr i64 %11 to i64**
  %13 = load i64*, i64** %12, align 8
  br label %cleanup.i.i

cleanup.i.i:                                      ; preds = %if.end4.i.i, %if.end.i.i, %while.body.i.i
  %curr.1.i.i = phi i64* [ %13, %if.end4.i.i ], [ %curr.0.i.i, %while.body.i.i ], [ %curr.0.i.i, %if.end.i.i ]
  %cleanup.dest.slot.0.i.i = phi i32 [ 0, %if.end4.i.i ], [ 3, %while.body.i.i ], [ 1, %if.end.i.i ]
  switch i32 %cleanup.dest.slot.0.i.i, label %if.end5.i [
    i32 0, label %while.cond.i.i
    i32 3, label %while.end.i.i
  ]

while.end.i.i:                                    ; preds = %cleanup.i.i, %while.cond.i.i
  %call1.i = tail call noalias dereferenceable_or_null(16) i8* @malloc(i64 16) #3
  %14 = bitcast i8* %call1.i to i64*
  store i64 %inc.i, i64* %14, align 8
  %15 = ptrtoint i8* %call1.i to i64
  %16 = add i64 %15, 8
  %17 = inttoptr i64 %16 to i64*
  store i64 0, i64* %17, align 8
  %18 = ptrtoint i8* %call1.i to i64
  %19 = bitcast i64** @tail to i64*
  %20 = load i64, i64* %19, align 8
  %21 = add i64 %20, 8
  %22 = inttoptr i64 %21 to i64*
  store i64 %18, i64* %22, align 8
  %23 = bitcast i64** @tail to i8**
  store i8* %call1.i, i8** %23, align 8
  %24 = load i64, i64* %gv0, align 8
  %rem.i6 = urem i64 %n, %24
  %cmp3.i = icmp eq i64 %rem.i6, 0
  br i1 %cmp3.i, label %return, label %if.end5.i

if.end5.i:                                        ; preds = %while.end.i.i, %cleanup.i.i
  %25 = phi i64 [ %24, %while.end.i.i ], [ %inc.i, %cleanup.i.i ]
  %mul.i1 = mul i64 %25, %25
  %cmp.i2 = icmp ult i64 %mul.i1, %n
  br i1 %cmp.i2, label %while.body.i4, label %return

return:                                           ; preds = %if.end5.i, %while.end.i.i, %while.end.i, %cleanup.i
  %retval.0 = phi i64 [ 1, %while.end.i ], [ 1, %if.end5.i ], [ 0, %while.end.i.i ], [ 0, %cleanup.i ]
  ret i64 %retval.0
}

attributes #0 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind allocsize(0) }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 15]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"clang version 10.0.0 (git@github.com:llvm/llvm-project.git d32170dbd5b0d54436537b6b75beaf44324e0c28)"}
