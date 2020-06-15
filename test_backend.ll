; ModuleID = 'test_backend.ll'
source_filename = "rmq1d_naive/src/rmq1d_naive.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: nounwind ssp uwtable
define i8* @malloc_upto_8(i64 %x) #0 {
entry:
  %add = add i64 %x, 7
  %div = and i64 %add, -8
  %call = tail call noalias i8* @malloc(i64 %div) #3
  ret i8* %call
}

; Function Attrs: allocsize(0)
declare noalias i8* @malloc(i64) #1

; Function Attrs: nounwind ssp uwtable
define i32 @min_element(i32* %p, i32* %q) #0 {
entry:
  %0 = load i32, i32* %p, align 4
  %cmp2 = icmp eq i32* %p, %q
  br i1 %cmp2, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  %p2 = ptrtoint i32* %p to i64
  %1 = ptrtoint i32* %q to i64
  %2 = add i64 %1, -4
  %3 = sub i64 %2, %p2
  %4 = sdiv i64 %3, 4
  %5 = add nuw nsw i64 %4, 1
  %xtraiter111 = urem i64 %5, 8
  %lcmp.mod = icmp eq i64 %xtraiter111, 0
  br i1 %lcmp.mod, label %while.body.prol.loopexit, label %while.body.prol

while.body.prol:                                  ; preds = %while.body.prol.while.body.prol_crit_edge, %while.body.preheader
  %6 = phi i32 [ %.pre, %while.body.prol.while.body.prol_crit_edge ], [ %0, %while.body.preheader ]
  %e.04.prol = phi i32 [ %spec.select.prol, %while.body.prol.while.body.prol_crit_edge ], [ %0, %while.body.preheader ]
  %p.addr.03.prol = phi i32* [ %9, %while.body.prol.while.body.prol_crit_edge ], [ %p, %while.body.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.prol.while.body.prol_crit_edge ], [ %xtraiter111, %while.body.preheader ]
  %cmp1.prol = icmp slt i32 %6, %e.04.prol
  %spec.select.prol = select i1 %cmp1.prol, i32 %6, i32 %e.04.prol
  %7 = ptrtoint i32* %p.addr.03.prol to i64
  %8 = add i64 %7, 4
  %9 = inttoptr i64 %8 to i32*
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.prol.loopexit, label %while.body.prol.while.body.prol_crit_edge, !llvm.loop !4

while.body.prol.while.body.prol_crit_edge:        ; preds = %while.body.prol
  %.pre = load i32, i32* %9, align 4
  br label %while.body.prol

while.body.prol.loopexit:                         ; preds = %while.body.prol, %while.body.preheader
  %spec.select.lcssa.unr = phi i32 [ undef, %while.body.preheader ], [ %spec.select.prol, %while.body.prol ]
  %e.04.unr = phi i32 [ %0, %while.body.preheader ], [ %spec.select.prol, %while.body.prol ]
  %p.addr.03.unr = phi i32* [ %p, %while.body.preheader ], [ %9, %while.body.prol ]
  %10 = icmp ult i64 %4, 7
  br i1 %10, label %while.end, label %while.body

while.body:                                       ; preds = %while.body, %while.body.prol.loopexit
  %e.04 = phi i32 [ %spec.select.7, %while.body ], [ %e.04.unr, %while.body.prol.loopexit ]
  %p.addr.03 = phi i32* [ %42, %while.body ], [ %p.addr.03.unr, %while.body.prol.loopexit ]
  %11 = load i32, i32* %p.addr.03, align 4
  %cmp1 = icmp slt i32 %11, %e.04
  %spec.select = select i1 %cmp1, i32 %11, i32 %e.04
  %12 = ptrtoint i32* %p.addr.03 to i64
  %13 = add i64 %12, 4
  %14 = inttoptr i64 %13 to i32*
  %15 = load i32, i32* %14, align 4
  %cmp1.1 = icmp slt i32 %15, %spec.select
  %spec.select.1 = select i1 %cmp1.1, i32 %15, i32 %spec.select
  %16 = ptrtoint i32* %p.addr.03 to i64
  %17 = add i64 %16, 8
  %18 = inttoptr i64 %17 to i32*
  %19 = load i32, i32* %18, align 4
  %cmp1.2 = icmp slt i32 %19, %spec.select.1
  %spec.select.2 = select i1 %cmp1.2, i32 %19, i32 %spec.select.1
  %20 = ptrtoint i32* %p.addr.03 to i64
  %21 = add i64 %20, 12
  %22 = inttoptr i64 %21 to i32*
  %23 = load i32, i32* %22, align 4
  %cmp1.3 = icmp slt i32 %23, %spec.select.2
  %spec.select.3 = select i1 %cmp1.3, i32 %23, i32 %spec.select.2
  %24 = ptrtoint i32* %p.addr.03 to i64
  %25 = add i64 %24, 16
  %26 = inttoptr i64 %25 to i32*
  %27 = load i32, i32* %26, align 4
  %cmp1.4 = icmp slt i32 %27, %spec.select.3
  %spec.select.4 = select i1 %cmp1.4, i32 %27, i32 %spec.select.3
  %28 = ptrtoint i32* %p.addr.03 to i64
  %29 = add i64 %28, 20
  %30 = inttoptr i64 %29 to i32*
  %31 = load i32, i32* %30, align 4
  %cmp1.5 = icmp slt i32 %31, %spec.select.4
  %spec.select.5 = select i1 %cmp1.5, i32 %31, i32 %spec.select.4
  %32 = ptrtoint i32* %p.addr.03 to i64
  %33 = add i64 %32, 24
  %34 = inttoptr i64 %33 to i32*
  %35 = load i32, i32* %34, align 4
  %cmp1.6 = icmp slt i32 %35, %spec.select.5
  %spec.select.6 = select i1 %cmp1.6, i32 %35, i32 %spec.select.5
  %36 = ptrtoint i32* %p.addr.03 to i64
  %37 = add i64 %36, 28
  %38 = inttoptr i64 %37 to i32*
  %39 = load i32, i32* %38, align 4
  %cmp1.7 = icmp slt i32 %39, %spec.select.6
  %spec.select.7 = select i1 %cmp1.7, i32 %39, i32 %spec.select.6
  %40 = ptrtoint i32* %p.addr.03 to i64
  %41 = add i64 %40, 32
  %42 = inttoptr i64 %41 to i32*
  %cmp.7 = icmp eq i32* %42, %q
  br i1 %cmp.7, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %while.body.prol.loopexit, %entry
  %e.0.lcssa = phi i32 [ %0, %entry ], [ %spec.select.lcssa.unr, %while.body.prol.loopexit ], [ %spec.select.7, %while.body ]
  ret i32 %e.0.lcssa
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %call = tail call i64 (...) @read() #4
  %conv = trunc i64 %call to i32
  %mul4 = sdiv i64 %call, 1073741824
  %add.i = add nsw i64 %mul4, 7
  %div.i = and i64 %add.i, -8
  %call.i = tail call noalias i8* @malloc(i64 %div.i) #3
  %cmp6 = icmp sgt i32 %conv, 0
  %call47 = tail call i64 (...) @read() #4
  br i1 %cmp6, label %for.body.preheader, label %while.cond.preheader

for.body.preheader:                               ; preds = %entry
  %wide.trip.count11 = urem i64 %call, 4294967296
  br label %for.body

while.cond.preheader:                             ; preds = %for.body, %entry
  %call4.lcssa = phi i64 [ %call47, %entry ], [ %call4, %for.body ]
  %conv5.le = trunc i64 %call4.lcssa to i32
  %tobool4 = icmp eq i32 %conv5.le, 0
  br i1 %tobool4, label %while.end, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %while.cond.preheader
  %0 = ptrtoint i8* %call.i to i64
  %1 = add i64 %0, 4
  br label %while.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %conv510.in = phi i64 [ %call4, %for.body ], [ %call47, %for.body.preheader ]
  %conv510 = trunc i64 %conv510.in to i32
  %2 = ptrtoint i8* %call.i to i64
  %3 = mul i64 %indvars.iv, 4
  %4 = add i64 %3, %2
  %5 = inttoptr i64 %4 to i32*
  store i32 %conv510, i32* %5, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %call4 = tail call i64 (...) @read() #4
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count11
  br i1 %exitcond, label %while.cond.preheader, label %for.body

while.body:                                       ; preds = %min_element.exit, %while.body.lr.ph
  %Q.05 = phi i32 [ %conv5.le, %while.body.lr.ph ], [ %dec, %min_element.exit ]
  %call8 = tail call i64 (...) @read() #4
  %call10 = tail call i64 (...) @read() #4
  %6 = ptrtoint i8* %call.i to i64
  %7 = mul i64 %call8, 4
  %8 = add i64 %7, %6
  %9 = inttoptr i64 %8 to i32*
  %10 = mul i64 %call10, 4
  %11 = add i64 %1, %10
  %12 = inttoptr i64 %11 to i32*
  %13 = load i32, i32* %9, align 4
  %cmp.i1 = icmp eq i32* %9, %12
  br i1 %cmp.i1, label %min_element.exit, label %while.body.i.preheader

while.body.i.preheader:                           ; preds = %while.body
  %14 = sub i64 %call10, %call8
  %15 = mul i64 %14, 4
  %16 = sdiv i64 %15, 4
  %17 = add nuw nsw i64 %16, 1
  %xtraiter122 = urem i64 %17, 8
  %lcmp.mod = icmp eq i64 %xtraiter122, 0
  br i1 %lcmp.mod, label %while.body.i.prol.loopexit, label %while.body.i.prol

while.body.i.prol:                                ; preds = %while.body.i.prol.while.body.i.prol_crit_edge, %while.body.i.preheader
  %18 = phi i32 [ %.pre, %while.body.i.prol.while.body.i.prol_crit_edge ], [ %13, %while.body.i.preheader ]
  %e.0.i3.prol = phi i32 [ %spec.select.prol, %while.body.i.prol.while.body.i.prol_crit_edge ], [ %13, %while.body.i.preheader ]
  %p.addr.0.i2.prol = phi i32* [ %21, %while.body.i.prol.while.body.i.prol_crit_edge ], [ %9, %while.body.i.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.i.prol.while.body.i.prol_crit_edge ], [ %xtraiter122, %while.body.i.preheader ]
  %cmp1.i.prol = icmp slt i32 %18, %e.0.i3.prol
  %spec.select.prol = select i1 %cmp1.i.prol, i32 %18, i32 %e.0.i3.prol
  %19 = ptrtoint i32* %p.addr.0.i2.prol to i64
  %20 = add i64 %19, 4
  %21 = inttoptr i64 %20 to i32*
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.i.prol.loopexit, label %while.body.i.prol.while.body.i.prol_crit_edge, !llvm.loop !6

while.body.i.prol.while.body.i.prol_crit_edge:    ; preds = %while.body.i.prol
  %.pre = load i32, i32* %21, align 4
  br label %while.body.i.prol

while.body.i.prol.loopexit:                       ; preds = %while.body.i.prol, %while.body.i.preheader
  %spec.select.lcssa.unr = phi i32 [ undef, %while.body.i.preheader ], [ %spec.select.prol, %while.body.i.prol ]
  %e.0.i3.unr = phi i32 [ %13, %while.body.i.preheader ], [ %spec.select.prol, %while.body.i.prol ]
  %p.addr.0.i2.unr = phi i32* [ %9, %while.body.i.preheader ], [ %21, %while.body.i.prol ]
  %22 = icmp ult i64 %16, 7
  br i1 %22, label %min_element.exit, label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.i.prol.loopexit
  %e.0.i3 = phi i32 [ %spec.select.7, %while.body.i ], [ %e.0.i3.unr, %while.body.i.prol.loopexit ]
  %p.addr.0.i2 = phi i32* [ %54, %while.body.i ], [ %p.addr.0.i2.unr, %while.body.i.prol.loopexit ]
  %23 = load i32, i32* %p.addr.0.i2, align 4
  %cmp1.i = icmp slt i32 %23, %e.0.i3
  %spec.select = select i1 %cmp1.i, i32 %23, i32 %e.0.i3
  %24 = ptrtoint i32* %p.addr.0.i2 to i64
  %25 = add i64 %24, 4
  %26 = inttoptr i64 %25 to i32*
  %27 = load i32, i32* %26, align 4
  %cmp1.i.1 = icmp slt i32 %27, %spec.select
  %spec.select.1 = select i1 %cmp1.i.1, i32 %27, i32 %spec.select
  %28 = ptrtoint i32* %p.addr.0.i2 to i64
  %29 = add i64 %28, 8
  %30 = inttoptr i64 %29 to i32*
  %31 = load i32, i32* %30, align 4
  %cmp1.i.2 = icmp slt i32 %31, %spec.select.1
  %spec.select.2 = select i1 %cmp1.i.2, i32 %31, i32 %spec.select.1
  %32 = ptrtoint i32* %p.addr.0.i2 to i64
  %33 = add i64 %32, 12
  %34 = inttoptr i64 %33 to i32*
  %35 = load i32, i32* %34, align 4
  %cmp1.i.3 = icmp slt i32 %35, %spec.select.2
  %spec.select.3 = select i1 %cmp1.i.3, i32 %35, i32 %spec.select.2
  %36 = ptrtoint i32* %p.addr.0.i2 to i64
  %37 = add i64 %36, 16
  %38 = inttoptr i64 %37 to i32*
  %39 = load i32, i32* %38, align 4
  %cmp1.i.4 = icmp slt i32 %39, %spec.select.3
  %spec.select.4 = select i1 %cmp1.i.4, i32 %39, i32 %spec.select.3
  %40 = ptrtoint i32* %p.addr.0.i2 to i64
  %41 = add i64 %40, 20
  %42 = inttoptr i64 %41 to i32*
  %43 = load i32, i32* %42, align 4
  %cmp1.i.5 = icmp slt i32 %43, %spec.select.4
  %spec.select.5 = select i1 %cmp1.i.5, i32 %43, i32 %spec.select.4
  %44 = ptrtoint i32* %p.addr.0.i2 to i64
  %45 = add i64 %44, 24
  %46 = inttoptr i64 %45 to i32*
  %47 = load i32, i32* %46, align 4
  %cmp1.i.6 = icmp slt i32 %47, %spec.select.5
  %spec.select.6 = select i1 %cmp1.i.6, i32 %47, i32 %spec.select.5
  %48 = ptrtoint i32* %p.addr.0.i2 to i64
  %49 = add i64 %48, 28
  %50 = inttoptr i64 %49 to i32*
  %51 = load i32, i32* %50, align 4
  %cmp1.i.7 = icmp slt i32 %51, %spec.select.6
  %spec.select.7 = select i1 %cmp1.i.7, i32 %51, i32 %spec.select.6
  %52 = ptrtoint i32* %p.addr.0.i2 to i64
  %53 = add i64 %52, 32
  %54 = inttoptr i64 %53 to i32*
  %cmp.i.7 = icmp eq i32* %54, %12
  br i1 %cmp.i.7, label %min_element.exit, label %while.body.i

min_element.exit:                                 ; preds = %while.body.i, %while.body.i.prol.loopexit, %while.body
  %e.0.i.lcssa = phi i32 [ %13, %while.body ], [ %spec.select.lcssa.unr, %while.body.i.prol.loopexit ], [ %spec.select.7, %while.body.i ]
  %dec = add nsw i32 %Q.05, -1
  %conv16 = sext i32 %e.0.i.lcssa to i64
  tail call void @write(i64 %conv16) #4
  %tobool = icmp eq i32 %dec, 0
  br i1 %tobool, label %while.end, label %while.body

while.end:                                        ; preds = %min_element.exit, %while.cond.preheader
  ret i32 0
}

declare i64 @read(...) #2

declare void @write(i64) #2

attributes #0 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind allocsize(0) }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 15]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"clang version 10.0.0 (git@github.com:llvm/llvm-project.git d32170dbd5b0d54436537b6b75beaf44324e0c28)"}
!4 = distinct !{!4, !5}
!5 = !{!"llvm.loop.unroll.disable"}
!6 = distinct !{!6, !5}
