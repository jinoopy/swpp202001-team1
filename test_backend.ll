; ModuleID = 'test_backend.ll'
source_filename = "rmq2d_naive/src/rmq2d_naive.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

@v = external global i32**, align 8

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
define i32 @min(i32 %x, i32 %y) #0 {
entry:
  %cmp = icmp slt i32 %x, %y
  %x.y = select i1 %cmp, i32 %x, i32 %y
  ret i32 %x.y
}

; Function Attrs: nounwind ssp uwtable
define i32* @min_element(i32* %p, i32* %q) #0 {
entry:
  %cmp2 = icmp eq i32* %p, %q
  br i1 %cmp2, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  %p2 = ptrtoint i32* %p to i64
  %0 = ptrtoint i32* %q to i64
  %1 = add i64 %0, -4
  %2 = sub i64 %1, %p2
  %3 = sdiv i64 %2, 4
  %4 = add nuw nsw i64 %3, 1
  %xtraiter111 = urem i64 %4, 4
  %lcmp.mod = icmp eq i64 %xtraiter111, 0
  br i1 %lcmp.mod, label %while.body.prol.loopexit, label %while.body.prol

while.body.prol:                                  ; preds = %while.body.prol, %while.body.preheader
  %e.04.prol = phi i32* [ %spec.select.prol, %while.body.prol ], [ %p, %while.body.preheader ]
  %p.addr.03.prol = phi i32* [ %9, %while.body.prol ], [ %p, %while.body.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.prol ], [ %xtraiter111, %while.body.preheader ]
  %5 = load i32, i32* %p.addr.03.prol, align 4
  %6 = load i32, i32* %e.04.prol, align 4
  %cmp1.prol = icmp slt i32 %5, %6
  %spec.select.prol = select i1 %cmp1.prol, i32* %p.addr.03.prol, i32* %e.04.prol
  %7 = ptrtoint i32* %p.addr.03.prol to i64
  %8 = add i64 %7, 4
  %9 = inttoptr i64 %8 to i32*
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.prol.loopexit, label %while.body.prol, !llvm.loop !4

while.body.prol.loopexit:                         ; preds = %while.body.prol, %while.body.preheader
  %spec.select.lcssa.unr = phi i32* [ undef, %while.body.preheader ], [ %spec.select.prol, %while.body.prol ]
  %e.04.unr = phi i32* [ %p, %while.body.preheader ], [ %spec.select.prol, %while.body.prol ]
  %p.addr.03.unr = phi i32* [ %p, %while.body.preheader ], [ %9, %while.body.prol ]
  %10 = icmp ult i64 %3, 3
  br i1 %10, label %while.end, label %while.body

while.body:                                       ; preds = %while.body, %while.body.prol.loopexit
  %e.04 = phi i32* [ %spec.select.3, %while.body ], [ %e.04.unr, %while.body.prol.loopexit ]
  %p.addr.03 = phi i32* [ %30, %while.body ], [ %p.addr.03.unr, %while.body.prol.loopexit ]
  %11 = load i32, i32* %p.addr.03, align 4
  %12 = load i32, i32* %e.04, align 4
  %cmp1 = icmp slt i32 %11, %12
  %spec.select = select i1 %cmp1, i32* %p.addr.03, i32* %e.04
  %13 = ptrtoint i32* %p.addr.03 to i64
  %14 = add i64 %13, 4
  %15 = inttoptr i64 %14 to i32*
  %16 = load i32, i32* %15, align 4
  %17 = load i32, i32* %spec.select, align 4
  %cmp1.1 = icmp slt i32 %16, %17
  %spec.select.1 = select i1 %cmp1.1, i32* %15, i32* %spec.select
  %18 = ptrtoint i32* %p.addr.03 to i64
  %19 = add i64 %18, 8
  %20 = inttoptr i64 %19 to i32*
  %21 = load i32, i32* %20, align 4
  %22 = load i32, i32* %spec.select.1, align 4
  %cmp1.2 = icmp slt i32 %21, %22
  %spec.select.2 = select i1 %cmp1.2, i32* %20, i32* %spec.select.1
  %23 = ptrtoint i32* %p.addr.03 to i64
  %24 = add i64 %23, 12
  %25 = inttoptr i64 %24 to i32*
  %26 = load i32, i32* %25, align 4
  %27 = load i32, i32* %spec.select.2, align 4
  %cmp1.3 = icmp slt i32 %26, %27
  %spec.select.3 = select i1 %cmp1.3, i32* %25, i32* %spec.select.2
  %28 = ptrtoint i32* %p.addr.03 to i64
  %29 = add i64 %28, 16
  %30 = inttoptr i64 %29 to i32*
  %cmp.3 = icmp eq i32* %30, %q
  br i1 %cmp.3, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %while.body.prol.loopexit, %entry
  %e.0.lcssa = phi i32* [ %p, %entry ], [ %spec.select.lcssa.unr, %while.body.prol.loopexit ], [ %spec.select.3, %while.body ]
  ret i32* %e.0.lcssa
}

; Function Attrs: nounwind ssp uwtable
define i32 @min_at_row(i32 %row, i32 %from_j, i32 %to_j) #0 {
entry:
  %0 = bitcast i32*** @v to i64*
  %1 = load i64, i64* %0, align 8
  %idx.ext = sext i32 %row to i64
  %2 = mul i64 %idx.ext, 8
  %3 = add i64 %1, %2
  %4 = inttoptr i64 %3 to i32**
  %5 = load i32*, i32** %4, align 8
  %idx.ext1 = sext i32 %from_j to i64
  %6 = ptrtoint i32* %5 to i64
  %7 = mul i64 %idx.ext1, 4
  %8 = add i64 %7, %6
  %9 = inttoptr i64 %8 to i32*
  %idx.ext3 = sext i32 %to_j to i64
  %10 = ptrtoint i32* %5 to i64
  %11 = mul i64 %idx.ext3, 4
  %12 = add i64 %11, %10
  %13 = inttoptr i64 %12 to i32*
  %14 = add i64 %12, 4
  %15 = inttoptr i64 %14 to i32*
  %cmp.i1 = icmp eq i32* %9, %15
  br i1 %cmp.i1, label %min_element.exit, label %while.body.i.preheader

while.body.i.preheader:                           ; preds = %entry
  %16 = sub nsw i64 %idx.ext3, %idx.ext1
  %17 = add nuw nsw i64 %16, 1
  %xtraiter111 = urem i64 %17, 4
  %lcmp.mod = icmp eq i64 %xtraiter111, 0
  br i1 %lcmp.mod, label %while.body.i.prol.loopexit, label %while.body.i.prol

while.body.i.prol:                                ; preds = %while.body.i.prol, %while.body.i.preheader
  %e.0.i3.prol = phi i32* [ %spec.select.prol, %while.body.i.prol ], [ %9, %while.body.i.preheader ]
  %p.addr.0.i2.prol = phi i32* [ %22, %while.body.i.prol ], [ %9, %while.body.i.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.i.prol ], [ %xtraiter111, %while.body.i.preheader ]
  %18 = load i32, i32* %p.addr.0.i2.prol, align 4
  %19 = load i32, i32* %e.0.i3.prol, align 4
  %cmp1.i.prol = icmp slt i32 %18, %19
  %spec.select.prol = select i1 %cmp1.i.prol, i32* %p.addr.0.i2.prol, i32* %e.0.i3.prol
  %20 = ptrtoint i32* %p.addr.0.i2.prol to i64
  %21 = add i64 %20, 4
  %22 = inttoptr i64 %21 to i32*
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.i.prol.loopexit, label %while.body.i.prol, !llvm.loop !6

while.body.i.prol.loopexit:                       ; preds = %while.body.i.prol, %while.body.i.preheader
  %spec.select.lcssa.unr = phi i32* [ undef, %while.body.i.preheader ], [ %spec.select.prol, %while.body.i.prol ]
  %e.0.i3.unr = phi i32* [ %9, %while.body.i.preheader ], [ %spec.select.prol, %while.body.i.prol ]
  %p.addr.0.i2.unr = phi i32* [ %9, %while.body.i.preheader ], [ %22, %while.body.i.prol ]
  %23 = icmp ult i64 %16, 3
  br i1 %23, label %min_element.exit, label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.i.prol.loopexit
  %e.0.i3 = phi i32* [ %spec.select.3, %while.body.i ], [ %e.0.i3.unr, %while.body.i.prol.loopexit ]
  %p.addr.0.i2 = phi i32* [ %43, %while.body.i ], [ %p.addr.0.i2.unr, %while.body.i.prol.loopexit ]
  %24 = load i32, i32* %p.addr.0.i2, align 4
  %25 = load i32, i32* %e.0.i3, align 4
  %cmp1.i = icmp slt i32 %24, %25
  %spec.select = select i1 %cmp1.i, i32* %p.addr.0.i2, i32* %e.0.i3
  %26 = ptrtoint i32* %p.addr.0.i2 to i64
  %27 = add i64 %26, 4
  %28 = inttoptr i64 %27 to i32*
  %29 = load i32, i32* %28, align 4
  %30 = load i32, i32* %spec.select, align 4
  %cmp1.i.1 = icmp slt i32 %29, %30
  %spec.select.1 = select i1 %cmp1.i.1, i32* %28, i32* %spec.select
  %31 = ptrtoint i32* %p.addr.0.i2 to i64
  %32 = add i64 %31, 8
  %33 = inttoptr i64 %32 to i32*
  %34 = load i32, i32* %33, align 4
  %35 = load i32, i32* %spec.select.1, align 4
  %cmp1.i.2 = icmp slt i32 %34, %35
  %spec.select.2 = select i1 %cmp1.i.2, i32* %33, i32* %spec.select.1
  %36 = ptrtoint i32* %p.addr.0.i2 to i64
  %37 = add i64 %36, 12
  %38 = inttoptr i64 %37 to i32*
  %39 = load i32, i32* %38, align 4
  %40 = load i32, i32* %spec.select.2, align 4
  %cmp1.i.3 = icmp slt i32 %39, %40
  %spec.select.3 = select i1 %cmp1.i.3, i32* %38, i32* %spec.select.2
  %41 = ptrtoint i32* %p.addr.0.i2 to i64
  %42 = add i64 %41, 16
  %43 = inttoptr i64 %42 to i32*
  %cmp.i.3 = icmp eq i32* %38, %13
  br i1 %cmp.i.3, label %min_element.exit, label %while.body.i

min_element.exit:                                 ; preds = %while.body.i, %while.body.i.prol.loopexit, %entry
  %e.0.i.lcssa = phi i32* [ %9, %entry ], [ %spec.select.lcssa.unr, %while.body.i.prol.loopexit ], [ %spec.select.3, %while.body.i ]
  %44 = load i32, i32* %e.0.i.lcssa, align 4
  ret i32 %44
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %color17 = alloca i64
  %color13 = alloca i64
  %color12 = alloca i64
  %call = tail call i64 (...) @read() #4
  %conv = trunc i64 %call to i32
  %call1 = tail call i64 (...) @read() #4
  %mul8 = sdiv i64 %call, 536870912
  %call.i = tail call noalias i8* @malloc(i64 %mul8) #3
  %0 = bitcast i32*** @v to i8**
  store i8* %call.i, i8** %0, align 8
  %cmp16 = icmp sgt i32 %conv, 0
  %1 = bitcast i8* %call.i to i32**
  br i1 %cmp16, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %conv2 = trunc i64 %call1 to i32
  %mul710 = sdiv i64 %call1, 1073741824
  %add.i1 = add nsw i64 %mul710, 7
  %div.i2 = and i64 %add.i1, -8
  %cmp1014 = icmp sgt i32 %conv2, 0
  %wide.trip.count721 = urem i64 %call, 4294967296
  br i1 %cmp1014, label %for.body.us, label %for.body

for.body.us:                                      ; preds = %for.cond.cleanup12.us.for.body.us_crit_edge, %for.body.lr.ph
  %2 = phi i32** [ %.pre1, %for.cond.cleanup12.us.for.body.us_crit_edge ], [ %1, %for.body.lr.ph ]
  %indvars.iv5 = phi i64 [ %indvars.iv.next6, %for.cond.cleanup12.us.for.body.us_crit_edge ], [ 0, %for.body.lr.ph ]
  %call.i4.us = tail call noalias i8* @malloc(i64 %div.i2) #3
  %3 = ptrtoint i32** %2 to i64
  %4 = mul i64 %indvars.iv5, 8
  %5 = add i64 %4, %3
  %6 = inttoptr i64 %5 to i8**
  store i8* %call.i4.us, i8** %6, align 8
  %wide.trip.count332 = urem i64 %call1, 4294967296
  br label %for.body13.us

for.body13.us:                                    ; preds = %for.body13.us, %for.body.us
  %indvars.iv1 = phi i64 [ %indvars.iv.next2, %for.body13.us ], [ 0, %for.body.us ]
  %call14.us = tail call i64 (...) @read() #4
  %conv15.us = trunc i64 %call14.us to i32
  %7 = bitcast i32*** @v to i64*
  %8 = load i64, i64* %7, align 8
  %9 = mul i64 %indvars.iv5, 8
  %10 = add i64 %8, %9
  %11 = inttoptr i64 %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = mul i64 %indvars.iv1, 4
  %14 = add i64 %12, %13
  %15 = inttoptr i64 %14 to i32*
  store i32 %conv15.us, i32* %15, align 4
  %indvars.iv.next2 = add nuw nsw i64 %indvars.iv1, 1
  %exitcond4 = icmp eq i64 %indvars.iv.next2, %wide.trip.count332
  br i1 %exitcond4, label %for.cond.cleanup12.us, label %for.body13.us

for.cond.cleanup12.us:                            ; preds = %for.body13.us
  %indvars.iv.next6 = add nuw nsw i64 %indvars.iv5, 1
  %exitcond8 = icmp eq i64 %indvars.iv.next6, %wide.trip.count721
  br i1 %exitcond8, label %for.cond.cleanup, label %for.cond.cleanup12.us.for.body.us_crit_edge

for.cond.cleanup12.us.for.body.us_crit_edge:      ; preds = %for.cond.cleanup12.us
  %.pre1 = load i32**, i32*** @v, align 8
  br label %for.body.us

for.cond.cleanup:                                 ; preds = %for.body, %for.cond.cleanup12.us, %entry
  %call23 = tail call i64 (...) @read() #4
  %conv24 = trunc i64 %call23 to i32
  %tobool12 = icmp eq i32 %conv24, 0
  br i1 %tobool12, label %while.end, label %while.body

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.lr.ph
  %16 = phi i32** [ %.pre, %for.body.for.body_crit_edge ], [ %1, %for.body.lr.ph ]
  %indvars.iv9 = phi i64 [ %indvars.iv.next10, %for.body.for.body_crit_edge ], [ 0, %for.body.lr.ph ]
  %call.i4 = tail call noalias i8* @malloc(i64 %div.i2) #3
  %17 = ptrtoint i32** %16 to i64
  %18 = mul i64 %indvars.iv9, 8
  %19 = add i64 %18, %17
  %20 = inttoptr i64 %19 to i8**
  store i8* %call.i4, i8** %20, align 8
  %indvars.iv.next10 = add nuw nsw i64 %indvars.iv9, 1
  %exitcond12 = icmp eq i64 %indvars.iv.next10, %wide.trip.count721
  br i1 %exitcond12, label %for.cond.cleanup, label %for.body.for.body_crit_edge

for.body.for.body_crit_edge:                      ; preds = %for.body
  %.pre = load i32**, i32*** @v, align 8
  br label %for.body

while.body:                                       ; preds = %for.cond.cleanup38, %for.cond.cleanup
  %Q.013 = phi i32 [ %dec, %for.cond.cleanup38 ], [ %conv24, %for.cond.cleanup ]
  %Q.013.temp.s = zext i32 %Q.013 to i64
  store i64 %Q.013.temp.s, i64* %color17
  %call25 = tail call i64 (...) @read() #4
  %call27 = tail call i64 (...) @read() #4
  %call29 = tail call i64 (...) @read() #4
  %call31 = tail call i64 (...) @read() #4
  %21 = load i32**, i32*** @v, align 8
  %.temp.s = ptrtoint i32** %21 to i64
  store i64 %.temp.s, i64* %color13
  %.temp.l = load i64, i64* %color13
  %.temp.l1 = inttoptr i64 %.temp.l to i32**
  %22 = ptrtoint i32** %.temp.l1 to i64
  %23 = mul i64 %call25, 8
  %24 = add i64 %23, %22
  %25 = inttoptr i64 %24 to i32**
  %26 = load i32*, i32** %25, align 8
  %27 = ptrtoint i32* %26 to i64
  %28 = mul i64 %call29, 4
  %29 = add i64 %28, %27
  %30 = inttoptr i64 %29 to i32*
  %31 = ptrtoint i32* %26 to i64
  %32 = add i64 %31, 4
  %33 = mul i64 %call31, 4
  %34 = add i64 %32, %33
  %35 = inttoptr i64 %34 to i32*
  %cmp.i.i1 = icmp eq i32* %30, %35
  br i1 %cmp.i.i1, label %min_at_row.exit, label %while.body.i.i.preheader

while.body.i.i.preheader:                         ; preds = %while.body
  %36 = sub i64 %call31, %call29
  %37 = mul i64 %36, 4
  %38 = sdiv i64 %37, 4
  %39 = add nuw nsw i64 %38, 1
  %xtraiter243 = urem i64 %39, 4
  %lcmp.mod = icmp eq i64 %xtraiter243, 0
  br i1 %lcmp.mod, label %while.body.i.i.prol.loopexit, label %while.body.i.i.prol

while.body.i.i.prol:                              ; preds = %while.body.i.i.prol, %while.body.i.i.preheader
  %e.0.i.i3.prol = phi i32* [ %spec.select.prol, %while.body.i.i.prol ], [ %30, %while.body.i.i.preheader ]
  %p.addr.0.i.i2.prol = phi i32* [ %44, %while.body.i.i.prol ], [ %30, %while.body.i.i.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.i.i.prol ], [ %xtraiter243, %while.body.i.i.preheader ]
  %40 = load i32, i32* %p.addr.0.i.i2.prol, align 4
  %41 = load i32, i32* %e.0.i.i3.prol, align 4
  %cmp1.i.i.prol = icmp slt i32 %40, %41
  %spec.select.prol = select i1 %cmp1.i.i.prol, i32* %p.addr.0.i.i2.prol, i32* %e.0.i.i3.prol
  %42 = ptrtoint i32* %p.addr.0.i.i2.prol to i64
  %43 = add i64 %42, 4
  %44 = inttoptr i64 %43 to i32*
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.i.i.prol.loopexit, label %while.body.i.i.prol, !llvm.loop !7

while.body.i.i.prol.loopexit:                     ; preds = %while.body.i.i.prol, %while.body.i.i.preheader
  %spec.select.lcssa.unr = phi i32* [ undef, %while.body.i.i.preheader ], [ %spec.select.prol, %while.body.i.i.prol ]
  %e.0.i.i3.unr = phi i32* [ %30, %while.body.i.i.preheader ], [ %spec.select.prol, %while.body.i.i.prol ]
  %p.addr.0.i.i2.unr = phi i32* [ %30, %while.body.i.i.preheader ], [ %44, %while.body.i.i.prol ]
  %45 = icmp ult i64 %38, 3
  br i1 %45, label %min_at_row.exit, label %while.body.i.i

while.body.i.i:                                   ; preds = %while.body.i.i, %while.body.i.i.prol.loopexit
  %e.0.i.i3 = phi i32* [ %spec.select.3, %while.body.i.i ], [ %e.0.i.i3.unr, %while.body.i.i.prol.loopexit ]
  %p.addr.0.i.i2 = phi i32* [ %65, %while.body.i.i ], [ %p.addr.0.i.i2.unr, %while.body.i.i.prol.loopexit ]
  %46 = load i32, i32* %p.addr.0.i.i2, align 4
  %47 = load i32, i32* %e.0.i.i3, align 4
  %cmp1.i.i = icmp slt i32 %46, %47
  %spec.select = select i1 %cmp1.i.i, i32* %p.addr.0.i.i2, i32* %e.0.i.i3
  %48 = ptrtoint i32* %p.addr.0.i.i2 to i64
  %49 = add i64 %48, 4
  %50 = inttoptr i64 %49 to i32*
  %51 = load i32, i32* %50, align 4
  %52 = load i32, i32* %spec.select, align 4
  %cmp1.i.i.1 = icmp slt i32 %51, %52
  %spec.select.1 = select i1 %cmp1.i.i.1, i32* %50, i32* %spec.select
  %53 = ptrtoint i32* %p.addr.0.i.i2 to i64
  %54 = add i64 %53, 8
  %55 = inttoptr i64 %54 to i32*
  %56 = load i32, i32* %55, align 4
  %57 = load i32, i32* %spec.select.1, align 4
  %cmp1.i.i.2 = icmp slt i32 %56, %57
  %spec.select.2 = select i1 %cmp1.i.i.2, i32* %55, i32* %spec.select.1
  %58 = ptrtoint i32* %p.addr.0.i.i2 to i64
  %59 = add i64 %58, 12
  %60 = inttoptr i64 %59 to i32*
  %61 = load i32, i32* %60, align 4
  %62 = load i32, i32* %spec.select.2, align 4
  %cmp1.i.i.3 = icmp slt i32 %61, %62
  %spec.select.3 = select i1 %cmp1.i.i.3, i32* %60, i32* %spec.select.2
  %63 = ptrtoint i32* %p.addr.0.i.i2 to i64
  %64 = add i64 %63, 16
  %65 = inttoptr i64 %64 to i32*
  %cmp.i.i.3 = icmp eq i32* %65, %35
  br i1 %cmp.i.i.3, label %min_at_row.exit, label %while.body.i.i

min_at_row.exit:                                  ; preds = %while.body.i.i, %while.body.i.i.prol.loopexit, %while.body
  %e.0.i.i.lcssa = phi i32* [ %30, %while.body ], [ %spec.select.lcssa.unr, %while.body.i.i.prol.loopexit ], [ %spec.select.3, %while.body.i.i ]
  %conv26 = trunc i64 %call25 to i32
  %conv28 = trunc i64 %call27 to i32
  %66 = load i32, i32* %e.0.i.i.lcssa, align 4
  %cmp368 = icmp slt i32 %conv26, %conv28
  br i1 %cmp368, label %for.body39.lr.ph, label %for.cond.cleanup38

for.body39.lr.ph:                                 ; preds = %min_at_row.exit
  %67 = sub i64 %call31, %call29
  %68 = mul i64 %67, 4
  %69 = sdiv i64 %68, 4
  %70 = add nuw nsw i64 %69, 1
  br label %for.body39

for.cond.cleanup38:                               ; preds = %min_at_row.exit22, %min_at_row.exit
  %res.0.lcssa = phi i32 [ %66, %min_at_row.exit ], [ %res.0., %min_at_row.exit22 ]
  %Q.013.temp.l = load i64, i64* %color17
  %Q.013.temp.l2 = trunc i64 %Q.013.temp.l to i32
  %dec = add nsw i32 %Q.013.temp.l2, -1
  %conv45 = sext i32 %res.0.lcssa to i64
  tail call void @write(i64 %conv45) #4
  %tobool = icmp eq i32 %dec, 0
  br i1 %tobool, label %while.end, label %while.body

for.body39:                                       ; preds = %min_at_row.exit22, %for.body39.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %min_at_row.exit22 ], [ %call25, %for.body39.lr.ph ]
  %res.09 = phi i32 [ %res.0., %min_at_row.exit22 ], [ %66, %for.body39.lr.ph ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %.temp.l3 = load i64, i64* %color13
  %.temp.l4 = inttoptr i64 %.temp.l3 to i32**
  %71 = ptrtoint i32** %.temp.l4 to i64
  %72 = mul i64 %indvars.iv.next, 8
  %73 = add i64 %72, %71
  %74 = inttoptr i64 %73 to i32**
  %75 = load i32*, i32** %74, align 8
  %76 = ptrtoint i32* %75 to i64
  %77 = mul i64 %call29, 4
  %78 = add i64 %77, %76
  %79 = inttoptr i64 %78 to i32*
  %80 = ptrtoint i32* %75 to i64
  %81 = add i64 %80, 4
  %82 = mul i64 %call31, 4
  %83 = add i64 %81, %82
  %84 = inttoptr i64 %83 to i32*
  %cmp.i.i144 = icmp eq i32* %79, %84
  br i1 %cmp.i.i144, label %min_at_row.exit22, label %while.body.i.i17.preheader

while.body.i.i17.preheader:                       ; preds = %for.body39
  %xtraiter1384 = urem i64 %70, 4
  %lcmp.mod2 = icmp eq i64 %xtraiter1384, 0
  br i1 %lcmp.mod2, label %while.body.i.i17.prol.loopexit, label %while.body.i.i17.prol

while.body.i.i17.prol:                            ; preds = %while.body.i.i17.prol, %while.body.i.i17.preheader
  %e.0.i.i136.prol = phi i32* [ %spec.select1.prol, %while.body.i.i17.prol ], [ %79, %while.body.i.i17.preheader ]
  %p.addr.0.i.i125.prol = phi i32* [ %89, %while.body.i.i17.prol ], [ %79, %while.body.i.i17.preheader ]
  %prol.iter3 = phi i64 [ %prol.iter3.sub, %while.body.i.i17.prol ], [ %xtraiter1384, %while.body.i.i17.preheader ]
  %e.0.i.i136.prol.temp.s = ptrtoint i32* %e.0.i.i136.prol to i64
  store i64 %e.0.i.i136.prol.temp.s, i64* %color12
  %85 = load i32, i32* %p.addr.0.i.i125.prol, align 4
  %e.0.i.i136.prol.temp.l = load i64, i64* %color12
  %e.0.i.i136.prol.temp.l5 = inttoptr i64 %e.0.i.i136.prol.temp.l to i32*
  %86 = load i32, i32* %e.0.i.i136.prol.temp.l5, align 4
  %cmp1.i.i16.prol = icmp slt i32 %85, %86
  %e.0.i.i136.prol.temp.l6 = load i64, i64* %color12
  %e.0.i.i136.prol.temp.l7 = inttoptr i64 %e.0.i.i136.prol.temp.l6 to i32*
  %spec.select1.prol = select i1 %cmp1.i.i16.prol, i32* %p.addr.0.i.i125.prol, i32* %e.0.i.i136.prol.temp.l7
  %87 = ptrtoint i32* %p.addr.0.i.i125.prol to i64
  %88 = add i64 %87, 4
  %89 = inttoptr i64 %88 to i32*
  %prol.iter3.sub = add i64 %prol.iter3, -1
  %prol.iter3.cmp = icmp eq i64 %prol.iter3.sub, 0
  br i1 %prol.iter3.cmp, label %while.body.i.i17.prol.loopexit, label %while.body.i.i17.prol, !llvm.loop !8

while.body.i.i17.prol.loopexit:                   ; preds = %while.body.i.i17.prol, %while.body.i.i17.preheader
  %spec.select1.lcssa.unr = phi i32* [ undef, %while.body.i.i17.preheader ], [ %spec.select1.prol, %while.body.i.i17.prol ]
  %e.0.i.i136.unr = phi i32* [ %79, %while.body.i.i17.preheader ], [ %spec.select1.prol, %while.body.i.i17.prol ]
  %p.addr.0.i.i125.unr = phi i32* [ %79, %while.body.i.i17.preheader ], [ %89, %while.body.i.i17.prol ]
  %90 = icmp ult i64 %69, 3
  br i1 %90, label %min_at_row.exit22, label %while.body.i.i17

while.body.i.i17:                                 ; preds = %while.body.i.i17, %while.body.i.i17.prol.loopexit
  %e.0.i.i136 = phi i32* [ %spec.select1.3, %while.body.i.i17 ], [ %e.0.i.i136.unr, %while.body.i.i17.prol.loopexit ]
  %p.addr.0.i.i125 = phi i32* [ %110, %while.body.i.i17 ], [ %p.addr.0.i.i125.unr, %while.body.i.i17.prol.loopexit ]
  %91 = load i32, i32* %p.addr.0.i.i125, align 4
  %92 = load i32, i32* %e.0.i.i136, align 4
  %cmp1.i.i16 = icmp slt i32 %91, %92
  %spec.select1 = select i1 %cmp1.i.i16, i32* %p.addr.0.i.i125, i32* %e.0.i.i136
  %93 = ptrtoint i32* %p.addr.0.i.i125 to i64
  %94 = add i64 %93, 4
  %95 = inttoptr i64 %94 to i32*
  %96 = load i32, i32* %95, align 4
  %97 = load i32, i32* %spec.select1, align 4
  %cmp1.i.i16.1 = icmp slt i32 %96, %97
  %spec.select1.1 = select i1 %cmp1.i.i16.1, i32* %95, i32* %spec.select1
  %98 = ptrtoint i32* %p.addr.0.i.i125 to i64
  %99 = add i64 %98, 8
  %100 = inttoptr i64 %99 to i32*
  %101 = load i32, i32* %100, align 4
  %102 = load i32, i32* %spec.select1.1, align 4
  %cmp1.i.i16.2 = icmp slt i32 %101, %102
  %spec.select1.2 = select i1 %cmp1.i.i16.2, i32* %100, i32* %spec.select1.1
  %103 = ptrtoint i32* %p.addr.0.i.i125 to i64
  %104 = add i64 %103, 12
  %105 = inttoptr i64 %104 to i32*
  %106 = load i32, i32* %105, align 4
  %107 = load i32, i32* %spec.select1.2, align 4
  %cmp1.i.i16.3 = icmp slt i32 %106, %107
  %spec.select1.3 = select i1 %cmp1.i.i16.3, i32* %105, i32* %spec.select1.2
  %108 = ptrtoint i32* %p.addr.0.i.i125 to i64
  %109 = add i64 %108, 16
  %110 = inttoptr i64 %109 to i32*
  %cmp.i.i14.3 = icmp eq i32* %110, %84
  br i1 %cmp.i.i14.3, label %min_at_row.exit22, label %while.body.i.i17

min_at_row.exit22:                                ; preds = %while.body.i.i17, %while.body.i.i17.prol.loopexit, %for.body39
  %e.0.i.i13.lcssa = phi i32* [ %79, %for.body39 ], [ %spec.select1.lcssa.unr, %while.body.i.i17.prol.loopexit ], [ %spec.select1.3, %while.body.i.i17 ]
  %111 = load i32, i32* %e.0.i.i13.lcssa, align 4
  %cmp.i = icmp slt i32 %res.09, %111
  %res.0. = select i1 %cmp.i, i32 %res.09, i32 %111
  %exitcond = icmp eq i64 %indvars.iv.next, %call27
  br i1 %exitcond, label %for.cond.cleanup38, label %for.body39

while.end:                                        ; preds = %for.cond.cleanup38, %for.cond.cleanup
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
!7 = distinct !{!7, !5}
!8 = distinct !{!8, !5}
