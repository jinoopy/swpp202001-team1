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
  %2 = mul i64 -1, 4
  %3 = add i64 %1, %2
  %4 = inttoptr i64 %3 to i32*
  %5 = ptrtoint i32* %4 to i64
  %6 = sub i64 %5, %p2
  %7 = udiv i64 %6, 4
  %8 = add nuw nsw i64 %7, 1
  %xtraiter11 = urem i64 %8, 8
  %lcmp.mod = icmp eq i64 %xtraiter11, 0
  br i1 %lcmp.mod, label %while.body.prol.loopexit, label %while.body.prol

while.body.prol:                                  ; preds = %while.body.prol.while.body.prol_crit_edge, %while.body.preheader
  %9 = phi i32 [ %.pre, %while.body.prol.while.body.prol_crit_edge ], [ %0, %while.body.preheader ]
  %e.04.prol = phi i32 [ %spec.select.prol, %while.body.prol.while.body.prol_crit_edge ], [ %0, %while.body.preheader ]
  %p.addr.03.prol = phi i32* [ %13, %while.body.prol.while.body.prol_crit_edge ], [ %p, %while.body.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.prol.while.body.prol_crit_edge ], [ %xtraiter11, %while.body.preheader ]
  %cmp1.prol = icmp slt i32 %9, %e.04.prol
  %spec.select.prol = select i1 %cmp1.prol, i32 %9, i32 %e.04.prol
  %10 = ptrtoint i32* %p.addr.03.prol to i64
  %11 = mul i64 1, 4
  %12 = add i64 %10, %11
  %13 = inttoptr i64 %12 to i32*
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.prol.loopexit, label %while.body.prol.while.body.prol_crit_edge, !llvm.loop !4

while.body.prol.while.body.prol_crit_edge:        ; preds = %while.body.prol
  %.pre = load i32, i32* %13, align 4
  br label %while.body.prol

while.body.prol.loopexit:                         ; preds = %while.body.prol, %while.body.preheader
  %spec.select.lcssa.unr = phi i32 [ undef, %while.body.preheader ], [ %spec.select.prol, %while.body.prol ]
  %e.04.unr = phi i32 [ %0, %while.body.preheader ], [ %spec.select.prol, %while.body.prol ]
  %p.addr.03.unr = phi i32* [ %p, %while.body.preheader ], [ %13, %while.body.prol ]
  %14 = icmp ult i64 %6, 28
  br i1 %14, label %while.end, label %while.body

while.body:                                       ; preds = %while.body, %while.body.prol.loopexit
  %e.04 = phi i32 [ %spec.select.7, %while.body ], [ %e.04.unr, %while.body.prol.loopexit ]
  %p.addr.03 = phi i32* [ %54, %while.body ], [ %p.addr.03.unr, %while.body.prol.loopexit ]
  %15 = load i32, i32* %p.addr.03, align 4
  %cmp1 = icmp slt i32 %15, %e.04
  %spec.select = select i1 %cmp1, i32 %15, i32 %e.04
  %16 = ptrtoint i32* %p.addr.03 to i64
  %17 = mul i64 1, 4
  %18 = add i64 %16, %17
  %19 = inttoptr i64 %18 to i32*
  %20 = load i32, i32* %19, align 4
  %cmp1.1 = icmp slt i32 %20, %spec.select
  %spec.select.1 = select i1 %cmp1.1, i32 %20, i32 %spec.select
  %21 = ptrtoint i32* %p.addr.03 to i64
  %22 = mul i64 2, 4
  %23 = add i64 %21, %22
  %24 = inttoptr i64 %23 to i32*
  %25 = load i32, i32* %24, align 4
  %cmp1.2 = icmp slt i32 %25, %spec.select.1
  %spec.select.2 = select i1 %cmp1.2, i32 %25, i32 %spec.select.1
  %26 = ptrtoint i32* %p.addr.03 to i64
  %27 = mul i64 3, 4
  %28 = add i64 %26, %27
  %29 = inttoptr i64 %28 to i32*
  %30 = load i32, i32* %29, align 4
  %cmp1.3 = icmp slt i32 %30, %spec.select.2
  %spec.select.3 = select i1 %cmp1.3, i32 %30, i32 %spec.select.2
  %31 = ptrtoint i32* %p.addr.03 to i64
  %32 = mul i64 4, 4
  %33 = add i64 %31, %32
  %34 = inttoptr i64 %33 to i32*
  %35 = load i32, i32* %34, align 4
  %cmp1.4 = icmp slt i32 %35, %spec.select.3
  %spec.select.4 = select i1 %cmp1.4, i32 %35, i32 %spec.select.3
  %36 = ptrtoint i32* %p.addr.03 to i64
  %37 = mul i64 5, 4
  %38 = add i64 %36, %37
  %39 = inttoptr i64 %38 to i32*
  %40 = load i32, i32* %39, align 4
  %cmp1.5 = icmp slt i32 %40, %spec.select.4
  %spec.select.5 = select i1 %cmp1.5, i32 %40, i32 %spec.select.4
  %41 = ptrtoint i32* %p.addr.03 to i64
  %42 = mul i64 6, 4
  %43 = add i64 %41, %42
  %44 = inttoptr i64 %43 to i32*
  %45 = load i32, i32* %44, align 4
  %cmp1.6 = icmp slt i32 %45, %spec.select.5
  %spec.select.6 = select i1 %cmp1.6, i32 %45, i32 %spec.select.5
  %46 = ptrtoint i32* %p.addr.03 to i64
  %47 = mul i64 7, 4
  %48 = add i64 %46, %47
  %49 = inttoptr i64 %48 to i32*
  %50 = load i32, i32* %49, align 4
  %cmp1.7 = icmp slt i32 %50, %spec.select.6
  %spec.select.7 = select i1 %cmp1.7, i32 %50, i32 %spec.select.6
  %51 = ptrtoint i32* %p.addr.03 to i64
  %52 = mul i64 8, 4
  %53 = add i64 %51, %52
  %54 = inttoptr i64 %53 to i32*
  %cmp.7 = icmp eq i32* %54, %q
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
  %sext3111 = mul i64 %call, 4294967296
  %mul4 = sdiv i64 %sext3111, 1073741824
  %add.i = add nsw i64 %mul4, 7
  %div.i = and i64 %add.i, -8
  %call.i = tail call noalias i8* @malloc(i64 %div.i) #3
  %0 = bitcast i8* %call.i to i32*
  %cmp6 = icmp sgt i32 %conv, 0
  %call47 = tail call i64 (...) @read() #4
  br i1 %cmp6, label %for.body.preheader, label %while.cond.preheader

for.body.preheader:                               ; preds = %entry
  %wide.trip.count2 = urem i64 %call, 4294967296
  br label %for.body

while.cond.preheader:                             ; preds = %for.body, %entry
  %call4.lcssa = phi i64 [ %call47, %entry ], [ %call4, %for.body ]
  %conv5.le = trunc i64 %call4.lcssa to i32
  %tobool4 = icmp eq i32 %conv5.le, 0
  br i1 %tobool4, label %while.end, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %while.cond.preheader
  %1 = ptrtoint i8* %call.i to i64
  %2 = mul i64 4, 1
  %3 = add i64 %1, %2
  %4 = inttoptr i64 %3 to i8*
  %5 = bitcast i8* %4 to i32*
  br label %while.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %conv510.in = phi i64 [ %call4, %for.body ], [ %call47, %for.body.preheader ]
  %conv510 = trunc i64 %conv510.in to i32
  %6 = ptrtoint i32* %0 to i64
  %7 = mul i64 %indvars.iv, 4
  %8 = add i64 %6, %7
  %9 = inttoptr i64 %8 to i32*
  store i32 %conv510, i32* %9, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %call4 = tail call i64 (...) @read() #4
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count2
  br i1 %exitcond, label %while.cond.preheader, label %for.body

while.body:                                       ; preds = %min_element.exit, %while.body.lr.ph
  %Q.05 = phi i32 [ %conv5.le, %while.body.lr.ph ], [ %dec, %min_element.exit ]
  %call8 = tail call i64 (...) @read() #4
  %call10 = tail call i64 (...) @read() #4
  %sext15223 = mul i64 %call8, 4294967296
  %idx.ext6 = sdiv i64 %sext15223, 4294967296
  %10 = ptrtoint i32* %0 to i64
  %11 = mul i64 %idx.ext6, 4
  %12 = add i64 %10, %11
  %13 = inttoptr i64 %12 to i32*
  %sext27334 = mul i64 %call10, 4294967296
  %idx.ext128 = sdiv i64 %sext27334, 4294967296
  %14 = ptrtoint i32* %5 to i64
  %15 = mul i64 %idx.ext128, 4
  %16 = add i64 %14, %15
  %17 = inttoptr i64 %16 to i32*
  %18 = load i32, i32* %13, align 4
  %cmp.i1 = icmp eq i32* %13, %17
  br i1 %cmp.i1, label %min_element.exit, label %while.body.i.preheader

while.body.i.preheader:                           ; preds = %while.body
  %19 = sub nsw i64 %idx.ext128, %idx.ext6
  %20 = add nsw i64 %19, 1
  %xtraiter15 = urem i64 %20, 8
  %lcmp.mod = icmp eq i64 %xtraiter15, 0
  br i1 %lcmp.mod, label %while.body.i.prol.loopexit, label %while.body.i.prol

while.body.i.prol:                                ; preds = %while.body.i.prol.while.body.i.prol_crit_edge, %while.body.i.preheader
  %21 = phi i32 [ %.pre, %while.body.i.prol.while.body.i.prol_crit_edge ], [ %18, %while.body.i.preheader ]
  %e.0.i3.prol = phi i32 [ %spec.select.prol, %while.body.i.prol.while.body.i.prol_crit_edge ], [ %18, %while.body.i.preheader ]
  %p.addr.0.i2.prol = phi i32* [ %25, %while.body.i.prol.while.body.i.prol_crit_edge ], [ %13, %while.body.i.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.i.prol.while.body.i.prol_crit_edge ], [ %xtraiter15, %while.body.i.preheader ]
  %cmp1.i.prol = icmp slt i32 %21, %e.0.i3.prol
  %spec.select.prol = select i1 %cmp1.i.prol, i32 %21, i32 %e.0.i3.prol
  %22 = ptrtoint i32* %p.addr.0.i2.prol to i64
  %23 = mul i64 1, 4
  %24 = add i64 %22, %23
  %25 = inttoptr i64 %24 to i32*
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.i.prol.loopexit, label %while.body.i.prol.while.body.i.prol_crit_edge, !llvm.loop !6

while.body.i.prol.while.body.i.prol_crit_edge:    ; preds = %while.body.i.prol
  %.pre = load i32, i32* %25, align 4
  br label %while.body.i.prol

while.body.i.prol.loopexit:                       ; preds = %while.body.i.prol, %while.body.i.preheader
  %spec.select.lcssa.unr = phi i32 [ undef, %while.body.i.preheader ], [ %spec.select.prol, %while.body.i.prol ]
  %e.0.i3.unr = phi i32 [ %18, %while.body.i.preheader ], [ %spec.select.prol, %while.body.i.prol ]
  %p.addr.0.i2.unr = phi i32* [ %13, %while.body.i.preheader ], [ %25, %while.body.i.prol ]
  %26 = urem i64 %19, 4611686018427387904
  %27 = icmp ult i64 %26, 7
  br i1 %27, label %min_element.exit, label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.i.prol.loopexit
  %e.0.i3 = phi i32 [ %spec.select.7, %while.body.i ], [ %e.0.i3.unr, %while.body.i.prol.loopexit ]
  %p.addr.0.i2 = phi i32* [ %67, %while.body.i ], [ %p.addr.0.i2.unr, %while.body.i.prol.loopexit ]
  %28 = load i32, i32* %p.addr.0.i2, align 4
  %cmp1.i = icmp slt i32 %28, %e.0.i3
  %spec.select = select i1 %cmp1.i, i32 %28, i32 %e.0.i3
  %29 = ptrtoint i32* %p.addr.0.i2 to i64
  %30 = mul i64 1, 4
  %31 = add i64 %29, %30
  %32 = inttoptr i64 %31 to i32*
  %33 = load i32, i32* %32, align 4
  %cmp1.i.1 = icmp slt i32 %33, %spec.select
  %spec.select.1 = select i1 %cmp1.i.1, i32 %33, i32 %spec.select
  %34 = ptrtoint i32* %p.addr.0.i2 to i64
  %35 = mul i64 2, 4
  %36 = add i64 %34, %35
  %37 = inttoptr i64 %36 to i32*
  %38 = load i32, i32* %37, align 4
  %cmp1.i.2 = icmp slt i32 %38, %spec.select.1
  %spec.select.2 = select i1 %cmp1.i.2, i32 %38, i32 %spec.select.1
  %39 = ptrtoint i32* %p.addr.0.i2 to i64
  %40 = mul i64 3, 4
  %41 = add i64 %39, %40
  %42 = inttoptr i64 %41 to i32*
  %43 = load i32, i32* %42, align 4
  %cmp1.i.3 = icmp slt i32 %43, %spec.select.2
  %spec.select.3 = select i1 %cmp1.i.3, i32 %43, i32 %spec.select.2
  %44 = ptrtoint i32* %p.addr.0.i2 to i64
  %45 = mul i64 4, 4
  %46 = add i64 %44, %45
  %47 = inttoptr i64 %46 to i32*
  %48 = load i32, i32* %47, align 4
  %cmp1.i.4 = icmp slt i32 %48, %spec.select.3
  %spec.select.4 = select i1 %cmp1.i.4, i32 %48, i32 %spec.select.3
  %49 = ptrtoint i32* %p.addr.0.i2 to i64
  %50 = mul i64 5, 4
  %51 = add i64 %49, %50
  %52 = inttoptr i64 %51 to i32*
  %53 = load i32, i32* %52, align 4
  %cmp1.i.5 = icmp slt i32 %53, %spec.select.4
  %spec.select.5 = select i1 %cmp1.i.5, i32 %53, i32 %spec.select.4
  %54 = ptrtoint i32* %p.addr.0.i2 to i64
  %55 = mul i64 6, 4
  %56 = add i64 %54, %55
  %57 = inttoptr i64 %56 to i32*
  %58 = load i32, i32* %57, align 4
  %cmp1.i.6 = icmp slt i32 %58, %spec.select.5
  %spec.select.6 = select i1 %cmp1.i.6, i32 %58, i32 %spec.select.5
  %59 = ptrtoint i32* %p.addr.0.i2 to i64
  %60 = mul i64 7, 4
  %61 = add i64 %59, %60
  %62 = inttoptr i64 %61 to i32*
  %63 = load i32, i32* %62, align 4
  %cmp1.i.7 = icmp slt i32 %63, %spec.select.6
  %spec.select.7 = select i1 %cmp1.i.7, i32 %63, i32 %spec.select.6
  %64 = ptrtoint i32* %p.addr.0.i2 to i64
  %65 = mul i64 8, 4
  %66 = add i64 %64, %65
  %67 = inttoptr i64 %66 to i32*
  %cmp.i.7 = icmp eq i32* %67, %17
  br i1 %cmp.i.7, label %min_element.exit, label %while.body.i

min_element.exit:                                 ; preds = %while.body.i, %while.body.i.prol.loopexit, %while.body
  %e.0.i.lcssa = phi i32 [ %18, %while.body ], [ %spec.select.lcssa.unr, %while.body.i.prol.loopexit ], [ %spec.select.7, %while.body.i ]
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
