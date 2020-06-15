; ModuleID = 'test_out.ll'
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
  %scevgep = getelementptr i32, i32* %q, i64 -1
  %0 = ptrtoint i32* %scevgep to i64
  %1 = sub i64 %0, %p2
  %2 = sdiv i64 %1, 4
  %3 = add nuw nsw i64 %2, 1
  %xtraiter11 = urem i64 %3, 4
  %lcmp.mod = icmp eq i64 %xtraiter11, 0
  br i1 %lcmp.mod, label %while.body.prol.loopexit, label %while.body.prol

while.body.prol:                                  ; preds = %while.body.prol, %while.body.preheader
  %e.04.prol = phi i32* [ %spec.select.prol, %while.body.prol ], [ %p, %while.body.preheader ]
  %p.addr.03.prol = phi i32* [ %incdec.ptr.prol, %while.body.prol ], [ %p, %while.body.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.prol ], [ %xtraiter11, %while.body.preheader ]
  %4 = load i32, i32* %p.addr.03.prol, align 4
  %5 = load i32, i32* %e.04.prol, align 4
  %cmp1.prol = icmp slt i32 %4, %5
  %spec.select.prol = select i1 %cmp1.prol, i32* %p.addr.03.prol, i32* %e.04.prol
  %incdec.ptr.prol = getelementptr inbounds i32, i32* %p.addr.03.prol, i64 1
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.prol.loopexit, label %while.body.prol, !llvm.loop !4

while.body.prol.loopexit:                         ; preds = %while.body.prol, %while.body.preheader
  %spec.select.lcssa.unr = phi i32* [ undef, %while.body.preheader ], [ %spec.select.prol, %while.body.prol ]
  %e.04.unr = phi i32* [ %p, %while.body.preheader ], [ %spec.select.prol, %while.body.prol ]
  %p.addr.03.unr = phi i32* [ %p, %while.body.preheader ], [ %incdec.ptr.prol, %while.body.prol ]
  %6 = icmp ult i64 %2, 3
  br i1 %6, label %while.end, label %while.body

while.body:                                       ; preds = %while.body, %while.body.prol.loopexit
  %e.04 = phi i32* [ %spec.select.3, %while.body ], [ %e.04.unr, %while.body.prol.loopexit ]
  %p.addr.03 = phi i32* [ %incdec.ptr.3, %while.body ], [ %p.addr.03.unr, %while.body.prol.loopexit ]
  %7 = load i32, i32* %p.addr.03, align 4
  %8 = load i32, i32* %e.04, align 4
  %cmp1 = icmp slt i32 %7, %8
  %spec.select = select i1 %cmp1, i32* %p.addr.03, i32* %e.04
  %incdec.ptr = getelementptr inbounds i32, i32* %p.addr.03, i64 1
  %9 = load i32, i32* %incdec.ptr, align 4
  %10 = load i32, i32* %spec.select, align 4
  %cmp1.1 = icmp slt i32 %9, %10
  %spec.select.1 = select i1 %cmp1.1, i32* %incdec.ptr, i32* %spec.select
  %incdec.ptr.1 = getelementptr inbounds i32, i32* %p.addr.03, i64 2
  %11 = load i32, i32* %incdec.ptr.1, align 4
  %12 = load i32, i32* %spec.select.1, align 4
  %cmp1.2 = icmp slt i32 %11, %12
  %spec.select.2 = select i1 %cmp1.2, i32* %incdec.ptr.1, i32* %spec.select.1
  %incdec.ptr.2 = getelementptr inbounds i32, i32* %p.addr.03, i64 3
  %13 = load i32, i32* %incdec.ptr.2, align 4
  %14 = load i32, i32* %spec.select.2, align 4
  %cmp1.3 = icmp slt i32 %13, %14
  %spec.select.3 = select i1 %cmp1.3, i32* %incdec.ptr.2, i32* %spec.select.2
  %incdec.ptr.3 = getelementptr inbounds i32, i32* %p.addr.03, i64 4
  %cmp.3 = icmp eq i32* %incdec.ptr.3, %q
  br i1 %cmp.3, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %while.body.prol.loopexit, %entry
  %e.0.lcssa = phi i32* [ %p, %entry ], [ %spec.select.lcssa.unr, %while.body.prol.loopexit ], [ %spec.select.3, %while.body ]
  ret i32* %e.0.lcssa
}

; Function Attrs: nounwind ssp uwtable
define i32 @min_at_row(i32 %row, i32 %from_j, i32 %to_j) #0 {
entry:
  %0 = load i32**, i32*** @v, align 8
  %idx.ext = sext i32 %row to i64
  %add.ptr = getelementptr inbounds i32*, i32** %0, i64 %idx.ext
  %1 = load i32*, i32** %add.ptr, align 8
  %idx.ext1 = sext i32 %from_j to i64
  %add.ptr2 = getelementptr inbounds i32, i32* %1, i64 %idx.ext1
  %idx.ext3 = sext i32 %to_j to i64
  %add.ptr4 = getelementptr inbounds i32, i32* %1, i64 %idx.ext3
  %add.ptr5 = getelementptr inbounds i32, i32* %add.ptr4, i64 1
  %cmp.i1 = icmp eq i32* %add.ptr2, %add.ptr5
  br i1 %cmp.i1, label %min_element.exit, label %while.body.i.preheader

while.body.i.preheader:                           ; preds = %entry
  %2 = sub nsw i64 %idx.ext3, %idx.ext1
  %3 = add nuw nsw i64 %2, 1
  %xtraiter11 = urem i64 %3, 4
  %lcmp.mod = icmp eq i64 %xtraiter11, 0
  br i1 %lcmp.mod, label %while.body.i.prol.loopexit, label %while.body.i.prol

while.body.i.prol:                                ; preds = %while.body.i.prol, %while.body.i.preheader
  %e.0.i3.prol = phi i32* [ %spec.select.prol, %while.body.i.prol ], [ %add.ptr2, %while.body.i.preheader ]
  %p.addr.0.i2.prol = phi i32* [ %incdec.ptr.i.prol, %while.body.i.prol ], [ %add.ptr2, %while.body.i.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.i.prol ], [ %xtraiter11, %while.body.i.preheader ]
  %4 = load i32, i32* %p.addr.0.i2.prol, align 4
  %5 = load i32, i32* %e.0.i3.prol, align 4
  %cmp1.i.prol = icmp slt i32 %4, %5
  %spec.select.prol = select i1 %cmp1.i.prol, i32* %p.addr.0.i2.prol, i32* %e.0.i3.prol
  %incdec.ptr.i.prol = getelementptr inbounds i32, i32* %p.addr.0.i2.prol, i64 1
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.i.prol.loopexit, label %while.body.i.prol, !llvm.loop !6

while.body.i.prol.loopexit:                       ; preds = %while.body.i.prol, %while.body.i.preheader
  %spec.select.lcssa.unr = phi i32* [ undef, %while.body.i.preheader ], [ %spec.select.prol, %while.body.i.prol ]
  %e.0.i3.unr = phi i32* [ %add.ptr2, %while.body.i.preheader ], [ %spec.select.prol, %while.body.i.prol ]
  %p.addr.0.i2.unr = phi i32* [ %add.ptr2, %while.body.i.preheader ], [ %incdec.ptr.i.prol, %while.body.i.prol ]
  %6 = icmp ult i64 %2, 3
  br i1 %6, label %min_element.exit, label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.i.prol.loopexit
  %e.0.i3 = phi i32* [ %spec.select.3, %while.body.i ], [ %e.0.i3.unr, %while.body.i.prol.loopexit ]
  %p.addr.0.i2 = phi i32* [ %incdec.ptr.i.3, %while.body.i ], [ %p.addr.0.i2.unr, %while.body.i.prol.loopexit ]
  %7 = load i32, i32* %p.addr.0.i2, align 4
  %8 = load i32, i32* %e.0.i3, align 4
  %cmp1.i = icmp slt i32 %7, %8
  %spec.select = select i1 %cmp1.i, i32* %p.addr.0.i2, i32* %e.0.i3
  %incdec.ptr.i = getelementptr inbounds i32, i32* %p.addr.0.i2, i64 1
  %9 = load i32, i32* %incdec.ptr.i, align 4
  %10 = load i32, i32* %spec.select, align 4
  %cmp1.i.1 = icmp slt i32 %9, %10
  %spec.select.1 = select i1 %cmp1.i.1, i32* %incdec.ptr.i, i32* %spec.select
  %incdec.ptr.i.1 = getelementptr inbounds i32, i32* %p.addr.0.i2, i64 2
  %11 = load i32, i32* %incdec.ptr.i.1, align 4
  %12 = load i32, i32* %spec.select.1, align 4
  %cmp1.i.2 = icmp slt i32 %11, %12
  %spec.select.2 = select i1 %cmp1.i.2, i32* %incdec.ptr.i.1, i32* %spec.select.1
  %incdec.ptr.i.2 = getelementptr inbounds i32, i32* %p.addr.0.i2, i64 3
  %13 = load i32, i32* %incdec.ptr.i.2, align 4
  %14 = load i32, i32* %spec.select.2, align 4
  %cmp1.i.3 = icmp slt i32 %13, %14
  %spec.select.3 = select i1 %cmp1.i.3, i32* %incdec.ptr.i.2, i32* %spec.select.2
  %incdec.ptr.i.3 = getelementptr inbounds i32, i32* %p.addr.0.i2, i64 4
  %cmp.i.3 = icmp eq i32* %incdec.ptr.i.2, %add.ptr4
  br i1 %cmp.i.3, label %min_element.exit, label %while.body.i

min_element.exit:                                 ; preds = %while.body.i, %while.body.i.prol.loopexit, %entry
  %e.0.i.lcssa = phi i32* [ %add.ptr2, %entry ], [ %spec.select.lcssa.unr, %while.body.i.prol.loopexit ], [ %spec.select.3, %while.body.i ]
  %15 = load i32, i32* %e.0.i.lcssa, align 4
  ret i32 %15
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %call = tail call i64 (...) @read() #4
  %conv = trunc i64 %call to i32
  %call1 = tail call i64 (...) @read() #4
  %mul8 = sdiv i64 %call, 536870912
  %call.i = tail call noalias i8* @malloc(i64 %mul8) #3
  store i8* %call.i, i8** bitcast (i32*** @v to i8**), align 8
  %cmp16 = icmp sgt i32 %conv, 0
  %0 = bitcast i8* %call.i to i32**
  br i1 %cmp16, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %conv2 = trunc i64 %call1 to i32
  %mul710 = sdiv i64 %call1, 1073741824
  %add.i1 = add nsw i64 %mul710, 7
  %div.i2 = and i64 %add.i1, -8
  %cmp1014 = icmp sgt i32 %conv2, 0
  %wide.trip.count72 = urem i64 %call, 4294967296
  br i1 %cmp1014, label %for.body.us, label %for.body

for.body.us:                                      ; preds = %for.cond.cleanup12.us.for.body.us_crit_edge, %for.body.lr.ph
  %1 = phi i32** [ %.pre1, %for.cond.cleanup12.us.for.body.us_crit_edge ], [ %0, %for.body.lr.ph ]
  %indvars.iv5 = phi i64 [ %indvars.iv.next6, %for.cond.cleanup12.us.for.body.us_crit_edge ], [ 0, %for.body.lr.ph ]
  %call.i4.us = tail call noalias i8* @malloc(i64 %div.i2) #3
  %arrayidx.us = getelementptr inbounds i32*, i32** %1, i64 %indvars.iv5
  %2 = bitcast i32** %arrayidx.us to i8**
  store i8* %call.i4.us, i8** %2, align 8
  %wide.trip.count33 = urem i64 %call1, 4294967296
  br label %for.body13.us

for.body13.us:                                    ; preds = %for.body13.us, %for.body.us
  %indvars.iv1 = phi i64 [ %indvars.iv.next2, %for.body13.us ], [ 0, %for.body.us ]
  %call14.us = tail call i64 (...) @read() #4
  %conv15.us = trunc i64 %call14.us to i32
  %3 = load i32**, i32*** @v, align 8
  %arrayidx17.us = getelementptr inbounds i32*, i32** %3, i64 %indvars.iv5
  %4 = load i32*, i32** %arrayidx17.us, align 8
  %arrayidx19.us = getelementptr inbounds i32, i32* %4, i64 %indvars.iv1
  store i32 %conv15.us, i32* %arrayidx19.us, align 4
  %indvars.iv.next2 = add nuw nsw i64 %indvars.iv1, 1
  %exitcond4 = icmp eq i64 %indvars.iv.next2, %wide.trip.count33
  br i1 %exitcond4, label %for.cond.cleanup12.us, label %for.body13.us

for.cond.cleanup12.us:                            ; preds = %for.body13.us
  %indvars.iv.next6 = add nuw nsw i64 %indvars.iv5, 1
  %exitcond8 = icmp eq i64 %indvars.iv.next6, %wide.trip.count72
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
  %5 = phi i32** [ %.pre, %for.body.for.body_crit_edge ], [ %0, %for.body.lr.ph ]
  %indvars.iv9 = phi i64 [ %indvars.iv.next10, %for.body.for.body_crit_edge ], [ 0, %for.body.lr.ph ]
  %call.i4 = tail call noalias i8* @malloc(i64 %div.i2) #3
  %arrayidx = getelementptr inbounds i32*, i32** %5, i64 %indvars.iv9
  %6 = bitcast i32** %arrayidx to i8**
  store i8* %call.i4, i8** %6, align 8
  %indvars.iv.next10 = add nuw nsw i64 %indvars.iv9, 1
  %exitcond12 = icmp eq i64 %indvars.iv.next10, %wide.trip.count72
  br i1 %exitcond12, label %for.cond.cleanup, label %for.body.for.body_crit_edge

for.body.for.body_crit_edge:                      ; preds = %for.body
  %.pre = load i32**, i32*** @v, align 8
  br label %for.body

while.body:                                       ; preds = %for.cond.cleanup38, %for.cond.cleanup
  %Q.013 = phi i32 [ %dec, %for.cond.cleanup38 ], [ %conv24, %for.cond.cleanup ]
  %call25 = tail call i64 (...) @read() #4
  %call27 = tail call i64 (...) @read() #4
  %call29 = tail call i64 (...) @read() #4
  %call31 = tail call i64 (...) @read() #4
  %7 = load i32**, i32*** @v, align 8
  %add.ptr.i = getelementptr inbounds i32*, i32** %7, i64 %call25
  %8 = load i32*, i32** %add.ptr.i, align 8
  %add.ptr2.i = getelementptr inbounds i32, i32* %8, i64 %call29
  %add.ptr4.i = getelementptr inbounds i32, i32* %8, i64 1
  %add.ptr5.i = getelementptr inbounds i32, i32* %add.ptr4.i, i64 %call31
  %cmp.i.i1 = icmp eq i32* %add.ptr2.i, %add.ptr5.i
  br i1 %cmp.i.i1, label %min_at_row.exit, label %while.body.i.i.preheader

while.body.i.i.preheader:                         ; preds = %while.body
  %9 = sub i64 %call31, %call29
  %10 = mul i64 %9, 4
  %11 = sdiv i64 %10, 4
  %12 = add nuw nsw i64 %11, 1
  %xtraiter24 = urem i64 %12, 4
  %lcmp.mod = icmp eq i64 %xtraiter24, 0
  br i1 %lcmp.mod, label %while.body.i.i.prol.loopexit, label %while.body.i.i.prol

while.body.i.i.prol:                              ; preds = %while.body.i.i.prol, %while.body.i.i.preheader
  %e.0.i.i3.prol = phi i32* [ %spec.select.prol, %while.body.i.i.prol ], [ %add.ptr2.i, %while.body.i.i.preheader ]
  %p.addr.0.i.i2.prol = phi i32* [ %incdec.ptr.i.i.prol, %while.body.i.i.prol ], [ %add.ptr2.i, %while.body.i.i.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.i.i.prol ], [ %xtraiter24, %while.body.i.i.preheader ]
  %13 = load i32, i32* %p.addr.0.i.i2.prol, align 4
  %14 = load i32, i32* %e.0.i.i3.prol, align 4
  %cmp1.i.i.prol = icmp slt i32 %13, %14
  %spec.select.prol = select i1 %cmp1.i.i.prol, i32* %p.addr.0.i.i2.prol, i32* %e.0.i.i3.prol
  %incdec.ptr.i.i.prol = getelementptr inbounds i32, i32* %p.addr.0.i.i2.prol, i64 1
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %while.body.i.i.prol.loopexit, label %while.body.i.i.prol, !llvm.loop !7

while.body.i.i.prol.loopexit:                     ; preds = %while.body.i.i.prol, %while.body.i.i.preheader
  %spec.select.lcssa.unr = phi i32* [ undef, %while.body.i.i.preheader ], [ %spec.select.prol, %while.body.i.i.prol ]
  %e.0.i.i3.unr = phi i32* [ %add.ptr2.i, %while.body.i.i.preheader ], [ %spec.select.prol, %while.body.i.i.prol ]
  %p.addr.0.i.i2.unr = phi i32* [ %add.ptr2.i, %while.body.i.i.preheader ], [ %incdec.ptr.i.i.prol, %while.body.i.i.prol ]
  %15 = icmp ult i64 %11, 3
  br i1 %15, label %min_at_row.exit, label %while.body.i.i

while.body.i.i:                                   ; preds = %while.body.i.i, %while.body.i.i.prol.loopexit
  %e.0.i.i3 = phi i32* [ %spec.select.3, %while.body.i.i ], [ %e.0.i.i3.unr, %while.body.i.i.prol.loopexit ]
  %p.addr.0.i.i2 = phi i32* [ %incdec.ptr.i.i.3, %while.body.i.i ], [ %p.addr.0.i.i2.unr, %while.body.i.i.prol.loopexit ]
  %16 = load i32, i32* %p.addr.0.i.i2, align 4
  %17 = load i32, i32* %e.0.i.i3, align 4
  %cmp1.i.i = icmp slt i32 %16, %17
  %spec.select = select i1 %cmp1.i.i, i32* %p.addr.0.i.i2, i32* %e.0.i.i3
  %incdec.ptr.i.i = getelementptr inbounds i32, i32* %p.addr.0.i.i2, i64 1
  %18 = load i32, i32* %incdec.ptr.i.i, align 4
  %19 = load i32, i32* %spec.select, align 4
  %cmp1.i.i.1 = icmp slt i32 %18, %19
  %spec.select.1 = select i1 %cmp1.i.i.1, i32* %incdec.ptr.i.i, i32* %spec.select
  %incdec.ptr.i.i.1 = getelementptr inbounds i32, i32* %p.addr.0.i.i2, i64 2
  %20 = load i32, i32* %incdec.ptr.i.i.1, align 4
  %21 = load i32, i32* %spec.select.1, align 4
  %cmp1.i.i.2 = icmp slt i32 %20, %21
  %spec.select.2 = select i1 %cmp1.i.i.2, i32* %incdec.ptr.i.i.1, i32* %spec.select.1
  %incdec.ptr.i.i.2 = getelementptr inbounds i32, i32* %p.addr.0.i.i2, i64 3
  %22 = load i32, i32* %incdec.ptr.i.i.2, align 4
  %23 = load i32, i32* %spec.select.2, align 4
  %cmp1.i.i.3 = icmp slt i32 %22, %23
  %spec.select.3 = select i1 %cmp1.i.i.3, i32* %incdec.ptr.i.i.2, i32* %spec.select.2
  %incdec.ptr.i.i.3 = getelementptr inbounds i32, i32* %p.addr.0.i.i2, i64 4
  %cmp.i.i.3 = icmp eq i32* %incdec.ptr.i.i.3, %add.ptr5.i
  br i1 %cmp.i.i.3, label %min_at_row.exit, label %while.body.i.i

min_at_row.exit:                                  ; preds = %while.body.i.i, %while.body.i.i.prol.loopexit, %while.body
  %e.0.i.i.lcssa = phi i32* [ %add.ptr2.i, %while.body ], [ %spec.select.lcssa.unr, %while.body.i.i.prol.loopexit ], [ %spec.select.3, %while.body.i.i ]
  %conv26 = trunc i64 %call25 to i32
  %conv28 = trunc i64 %call27 to i32
  %24 = load i32, i32* %e.0.i.i.lcssa, align 4
  %cmp368 = icmp slt i32 %conv26, %conv28
  br i1 %cmp368, label %for.body39.lr.ph, label %for.cond.cleanup38

for.body39.lr.ph:                                 ; preds = %min_at_row.exit
  %25 = sub i64 %call31, %call29
  %26 = mul i64 %25, 4
  %27 = sdiv i64 %26, 4
  %28 = add nuw nsw i64 %27, 1
  br label %for.body39

for.cond.cleanup38:                               ; preds = %min_at_row.exit22, %min_at_row.exit
  %res.0.lcssa = phi i32 [ %24, %min_at_row.exit ], [ %res.0., %min_at_row.exit22 ]
  %dec = add nsw i32 %Q.013, -1
  %conv45 = sext i32 %res.0.lcssa to i64
  tail call void @write(i64 %conv45) #4
  %tobool = icmp eq i32 %dec, 0
  br i1 %tobool, label %while.end, label %while.body

for.body39:                                       ; preds = %min_at_row.exit22, %for.body39.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %min_at_row.exit22 ], [ %call25, %for.body39.lr.ph ]
  %res.09 = phi i32 [ %res.0., %min_at_row.exit22 ], [ %24, %for.body39.lr.ph ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %add.ptr.i6 = getelementptr inbounds i32*, i32** %7, i64 %indvars.iv.next
  %29 = load i32*, i32** %add.ptr.i6, align 8
  %add.ptr2.i8 = getelementptr inbounds i32, i32* %29, i64 %call29
  %add.ptr4.i10 = getelementptr inbounds i32, i32* %29, i64 1
  %add.ptr5.i11 = getelementptr inbounds i32, i32* %add.ptr4.i10, i64 %call31
  %cmp.i.i144 = icmp eq i32* %add.ptr2.i8, %add.ptr5.i11
  br i1 %cmp.i.i144, label %min_at_row.exit22, label %while.body.i.i17.preheader

while.body.i.i17.preheader:                       ; preds = %for.body39
  %xtraiter138 = urem i64 %28, 4
  %lcmp.mod2 = icmp eq i64 %xtraiter138, 0
  br i1 %lcmp.mod2, label %while.body.i.i17.prol.loopexit, label %while.body.i.i17.prol

while.body.i.i17.prol:                            ; preds = %while.body.i.i17.prol, %while.body.i.i17.preheader
  %e.0.i.i136.prol = phi i32* [ %spec.select1.prol, %while.body.i.i17.prol ], [ %add.ptr2.i8, %while.body.i.i17.preheader ]
  %p.addr.0.i.i125.prol = phi i32* [ %incdec.ptr.i.i20.prol, %while.body.i.i17.prol ], [ %add.ptr2.i8, %while.body.i.i17.preheader ]
  %prol.iter3 = phi i64 [ %prol.iter3.sub, %while.body.i.i17.prol ], [ %xtraiter138, %while.body.i.i17.preheader ]
  %30 = load i32, i32* %p.addr.0.i.i125.prol, align 4
  %31 = load i32, i32* %e.0.i.i136.prol, align 4
  %cmp1.i.i16.prol = icmp slt i32 %30, %31
  %spec.select1.prol = select i1 %cmp1.i.i16.prol, i32* %p.addr.0.i.i125.prol, i32* %e.0.i.i136.prol
  %incdec.ptr.i.i20.prol = getelementptr inbounds i32, i32* %p.addr.0.i.i125.prol, i64 1
  %prol.iter3.sub = add i64 %prol.iter3, -1
  %prol.iter3.cmp = icmp eq i64 %prol.iter3.sub, 0
  br i1 %prol.iter3.cmp, label %while.body.i.i17.prol.loopexit, label %while.body.i.i17.prol, !llvm.loop !8

while.body.i.i17.prol.loopexit:                   ; preds = %while.body.i.i17.prol, %while.body.i.i17.preheader
  %spec.select1.lcssa.unr = phi i32* [ undef, %while.body.i.i17.preheader ], [ %spec.select1.prol, %while.body.i.i17.prol ]
  %e.0.i.i136.unr = phi i32* [ %add.ptr2.i8, %while.body.i.i17.preheader ], [ %spec.select1.prol, %while.body.i.i17.prol ]
  %p.addr.0.i.i125.unr = phi i32* [ %add.ptr2.i8, %while.body.i.i17.preheader ], [ %incdec.ptr.i.i20.prol, %while.body.i.i17.prol ]
  %32 = icmp ult i64 %27, 3
  br i1 %32, label %min_at_row.exit22, label %while.body.i.i17

while.body.i.i17:                                 ; preds = %while.body.i.i17, %while.body.i.i17.prol.loopexit
  %e.0.i.i136 = phi i32* [ %spec.select1.3, %while.body.i.i17 ], [ %e.0.i.i136.unr, %while.body.i.i17.prol.loopexit ]
  %p.addr.0.i.i125 = phi i32* [ %incdec.ptr.i.i20.3, %while.body.i.i17 ], [ %p.addr.0.i.i125.unr, %while.body.i.i17.prol.loopexit ]
  %33 = load i32, i32* %p.addr.0.i.i125, align 4
  %34 = load i32, i32* %e.0.i.i136, align 4
  %cmp1.i.i16 = icmp slt i32 %33, %34
  %spec.select1 = select i1 %cmp1.i.i16, i32* %p.addr.0.i.i125, i32* %e.0.i.i136
  %incdec.ptr.i.i20 = getelementptr inbounds i32, i32* %p.addr.0.i.i125, i64 1
  %35 = load i32, i32* %incdec.ptr.i.i20, align 4
  %36 = load i32, i32* %spec.select1, align 4
  %cmp1.i.i16.1 = icmp slt i32 %35, %36
  %spec.select1.1 = select i1 %cmp1.i.i16.1, i32* %incdec.ptr.i.i20, i32* %spec.select1
  %incdec.ptr.i.i20.1 = getelementptr inbounds i32, i32* %p.addr.0.i.i125, i64 2
  %37 = load i32, i32* %incdec.ptr.i.i20.1, align 4
  %38 = load i32, i32* %spec.select1.1, align 4
  %cmp1.i.i16.2 = icmp slt i32 %37, %38
  %spec.select1.2 = select i1 %cmp1.i.i16.2, i32* %incdec.ptr.i.i20.1, i32* %spec.select1.1
  %incdec.ptr.i.i20.2 = getelementptr inbounds i32, i32* %p.addr.0.i.i125, i64 3
  %39 = load i32, i32* %incdec.ptr.i.i20.2, align 4
  %40 = load i32, i32* %spec.select1.2, align 4
  %cmp1.i.i16.3 = icmp slt i32 %39, %40
  %spec.select1.3 = select i1 %cmp1.i.i16.3, i32* %incdec.ptr.i.i20.2, i32* %spec.select1.2
  %incdec.ptr.i.i20.3 = getelementptr inbounds i32, i32* %p.addr.0.i.i125, i64 4
  %cmp.i.i14.3 = icmp eq i32* %incdec.ptr.i.i20.3, %add.ptr5.i11
  br i1 %cmp.i.i14.3, label %min_at_row.exit22, label %while.body.i.i17

min_at_row.exit22:                                ; preds = %while.body.i.i17, %while.body.i.i17.prol.loopexit, %for.body39
  %e.0.i.i13.lcssa = phi i32* [ %add.ptr2.i8, %for.body39 ], [ %spec.select1.lcssa.unr, %while.body.i.i17.prol.loopexit ], [ %spec.select1.3, %while.body.i.i17 ]
  %41 = load i32, i32* %e.0.i.i13.lcssa, align 4
  %cmp.i = icmp slt i32 %res.09, %41
  %res.0. = select i1 %cmp.i, i32 %res.09, i32 %41
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
