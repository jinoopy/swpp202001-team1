; ModuleID = 'test1.ll'
source_filename = "bubble_sort/src/bubble_sort.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: nounwind ssp uwtable
define i64* @get_inputs(i64 %n) #0 {
entry:
  %cmp = icmp eq i64 %n, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %mul = mul i64 %n, 8
  %call = call i8* @malloc(i64 %mul) #4
  %0 = bitcast i8* %call to i64*
  %cmp11 = icmp ult i64 0, %n
  br i1 %cmp11, label %for.body.lr.ph, label %return.loopexit

for.body.lr.ph:                                   ; preds = %if.end
  %1 = add i64 %n, -1
  %xtraiter = and i64 %n, 3
  %2 = icmp ult i64 %1, 3
  br i1 %2, label %for.cond.return.loopexit_crit_edge.unr-lcssa, label %for.body.lr.ph.new

for.body.lr.ph.new:                               ; preds = %for.body.lr.ph
  %unroll_iter = sub i64 %n, %xtraiter
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph.new
  %i.02 = phi i64 [ 0, %for.body.lr.ph.new ], [ %inc.3, %for.body ]
  %niter = phi i64 [ %unroll_iter, %for.body.lr.ph.new ], [ %niter.nsub.3, %for.body ]
  %call2 = call i64 (...) @read()
  %arrayidx = getelementptr inbounds i64, i64* %0, i64 %i.02
  store i64 %call2, i64* %arrayidx, align 8
  %inc = add nuw nsw i64 %i.02, 1
  %niter.nsub = sub i64 %niter, 1
  %call2.1 = call i64 (...) @read()
  %arrayidx.1 = getelementptr inbounds i64, i64* %0, i64 %inc
  store i64 %call2.1, i64* %arrayidx.1, align 8
  %inc.1 = add nuw nsw i64 %inc, 1
  %niter.nsub.1 = sub i64 %niter.nsub, 1
  %call2.2 = call i64 (...) @read()
  %arrayidx.2 = getelementptr inbounds i64, i64* %0, i64 %inc.1
  store i64 %call2.2, i64* %arrayidx.2, align 8
  %inc.2 = add nuw nsw i64 %inc.1, 1
  %niter.nsub.2 = sub i64 %niter.nsub.1, 1
  %call2.3 = call i64 (...) @read()
  %arrayidx.3 = getelementptr inbounds i64, i64* %0, i64 %inc.2
  store i64 %call2.3, i64* %arrayidx.3, align 8
  %inc.3 = add i64 %inc.2, 1
  %niter.nsub.3 = sub i64 %niter.nsub.2, 1
  %niter.ncmp.3 = icmp ne i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %for.body, label %for.cond.return.loopexit_crit_edge.unr-lcssa.loopexit, !llvm.loop !4

for.cond.return.loopexit_crit_edge.unr-lcssa.loopexit: ; preds = %for.body
  %split.ph.ph = phi i64* [ %0, %for.body ]
  %i.02.unr.ph = phi i64 [ %inc.3, %for.body ]
  br label %for.cond.return.loopexit_crit_edge.unr-lcssa

for.cond.return.loopexit_crit_edge.unr-lcssa:     ; preds = %for.cond.return.loopexit_crit_edge.unr-lcssa.loopexit, %for.body.lr.ph
  %split.ph = phi i64* [ undef, %for.body.lr.ph ], [ %split.ph.ph, %for.cond.return.loopexit_crit_edge.unr-lcssa.loopexit ]
  %i.02.unr = phi i64 [ 0, %for.body.lr.ph ], [ %i.02.unr.ph, %for.cond.return.loopexit_crit_edge.unr-lcssa.loopexit ]
  %lcmp.mod = icmp ne i64 %xtraiter, 0
  br i1 %lcmp.mod, label %for.body.epil.preheader, label %for.cond.return.loopexit_crit_edge

for.body.epil.preheader:                          ; preds = %for.cond.return.loopexit_crit_edge.unr-lcssa
  br label %for.body.epil

for.body.epil:                                    ; preds = %for.body.epil, %for.body.epil.preheader
  %i.02.epil = phi i64 [ %i.02.unr, %for.body.epil.preheader ], [ %inc.epil, %for.body.epil ]
  %epil.iter = phi i64 [ %xtraiter, %for.body.epil.preheader ], [ %epil.iter.sub, %for.body.epil ]
  %call2.epil = call i64 (...) @read()
  %arrayidx.epil = getelementptr inbounds i64, i64* %0, i64 %i.02.epil
  store i64 %call2.epil, i64* %arrayidx.epil, align 8
  %inc.epil = add i64 %i.02.epil, 1
  %cmp1.epil = icmp ult i64 %inc.epil, %n
  %epil.iter.sub = sub i64 %epil.iter, 1
  %epil.iter.cmp = icmp ne i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %for.body.epil, label %for.cond.return.loopexit_crit_edge.epilog-lcssa, !llvm.loop !6

for.cond.return.loopexit_crit_edge.epilog-lcssa:  ; preds = %for.body.epil
  %split.ph3 = phi i64* [ %0, %for.body.epil ]
  br label %for.cond.return.loopexit_crit_edge

for.cond.return.loopexit_crit_edge:               ; preds = %for.cond.return.loopexit_crit_edge.unr-lcssa, %for.cond.return.loopexit_crit_edge.epilog-lcssa
  %split = phi i64* [ %split.ph, %for.cond.return.loopexit_crit_edge.unr-lcssa ], [ %split.ph3, %for.cond.return.loopexit_crit_edge.epilog-lcssa ]
  br label %return.loopexit

return.loopexit:                                  ; preds = %for.cond.return.loopexit_crit_edge, %if.end
  %retval.0.ph = phi i64* [ %split, %for.cond.return.loopexit_crit_edge ], [ %0, %if.end ]
  br label %return

return:                                           ; preds = %return.loopexit, %entry
  %retval.0 = phi i64* [ null, %entry ], [ %retval.0.ph, %return.loopexit ]
  ret i64* %retval.0
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2

declare i64 @read(...) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind ssp uwtable
define void @sort(i64 %n, i64* %ptr) #0 {
entry:
  %cmp = icmp eq i64 %n, 0
  br i1 %cmp, label %for.end15, label %for.cond.preheader

for.cond.preheader:                               ; preds = %entry
  %0 = add i64 %n, -1
  %1 = add i64 %n, -2
  %cmp13 = icmp ult i64 0, %n
  br i1 %cmp13, label %for.body.lr.ph, label %for.end15.loopexit

for.body.lr.ph:                                   ; preds = %for.cond.preheader
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.inc14
  %2 = phi i64 [ %1, %for.body.lr.ph ], [ %13, %for.inc14 ]
  %3 = phi i64 [ %0, %for.body.lr.ph ], [ %12, %for.inc14 ]
  %i.04 = phi i64 [ 0, %for.body.lr.ph ], [ %inc, %for.inc14 ]
  %sub = sub i64 %n, 1
  %cmp31 = icmp ugt i64 %sub, %i.04
  br i1 %cmp31, label %for.body5.lr.ph, label %for.inc14

for.body5.lr.ph:                                  ; preds = %for.body
  %xtraiter = and i64 %3, 3
  %lcmp.mod = icmp ne i64 %xtraiter, 0
  br i1 %lcmp.mod, label %for.body5.prol.preheader, label %for.body5.prol.loopexit

for.body5.prol.preheader:                         ; preds = %for.body5.lr.ph
  br label %for.body5.prol

for.body5.prol:                                   ; preds = %for.inc.prol, %for.body5.prol.preheader
  %j.02.prol = phi i64 [ %sub, %for.body5.prol.preheader ], [ %dec.prol, %for.inc.prol ]
  %prol.iter = phi i64 [ %xtraiter, %for.body5.prol.preheader ], [ %prol.iter.sub, %for.inc.prol ]
  %arrayidx.prol = getelementptr inbounds i64, i64* %ptr, i64 %j.02.prol
  %4 = load i64, i64* %arrayidx.prol, align 8
  %sub6.prol = sub i64 %j.02.prol, 1
  %arrayidx7.prol = getelementptr inbounds i64, i64* %ptr, i64 %sub6.prol
  %5 = load i64, i64* %arrayidx7.prol, align 8
  %cmp8.prol = icmp ult i64 %4, %5
  br i1 %cmp8.prol, label %if.then9.prol, label %for.inc.prol

if.then9.prol:                                    ; preds = %for.body5.prol
  %arrayidx10.prol = getelementptr inbounds i64, i64* %ptr, i64 %j.02.prol
  store i64 %5, i64* %arrayidx10.prol, align 8
  %sub11.prol = sub i64 %j.02.prol, 1
  %arrayidx12.prol = getelementptr inbounds i64, i64* %ptr, i64 %sub11.prol
  store i64 %4, i64* %arrayidx12.prol, align 8
  br label %for.inc.prol

for.inc.prol:                                     ; preds = %if.then9.prol, %for.body5.prol
  %dec.prol = add i64 %j.02.prol, -1
  %cmp3.prol = icmp ugt i64 %dec.prol, %i.04
  %prol.iter.sub = sub i64 %prol.iter, 1
  %prol.iter.cmp = icmp ne i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.body5.prol, label %for.body5.prol.loopexit.unr-lcssa, !llvm.loop !7

for.body5.prol.loopexit.unr-lcssa:                ; preds = %for.inc.prol
  %j.02.unr.ph = phi i64 [ %dec.prol, %for.inc.prol ]
  br label %for.body5.prol.loopexit

for.body5.prol.loopexit:                          ; preds = %for.body5.prol.loopexit.unr-lcssa, %for.body5.lr.ph
  %j.02.unr = phi i64 [ %sub, %for.body5.lr.ph ], [ %j.02.unr.ph, %for.body5.prol.loopexit.unr-lcssa ]
  %6 = icmp ult i64 %2, 3
  br i1 %6, label %for.cond2.for.inc14_crit_edge, label %for.body5.lr.ph.new

for.body5.lr.ph.new:                              ; preds = %for.body5.prol.loopexit
  br label %for.body5

for.body5:                                        ; preds = %for.inc.3, %for.body5.lr.ph.new
  %j.02 = phi i64 [ %j.02.unr, %for.body5.lr.ph.new ], [ %dec.3, %for.inc.3 ]
  %arrayidx = getelementptr inbounds i64, i64* %ptr, i64 %j.02
  %7 = load i64, i64* %arrayidx, align 8
  %sub6 = sub i64 %j.02, 1
  %arrayidx7 = getelementptr inbounds i64, i64* %ptr, i64 %sub6
  %8 = load i64, i64* %arrayidx7, align 8
  %cmp8 = icmp ult i64 %7, %8
  br i1 %cmp8, label %if.then9, label %for.inc

if.then9:                                         ; preds = %for.body5
  %arrayidx10 = getelementptr inbounds i64, i64* %ptr, i64 %j.02
  store i64 %8, i64* %arrayidx10, align 8
  %sub11 = sub i64 %j.02, 1
  %arrayidx12 = getelementptr inbounds i64, i64* %ptr, i64 %sub11
  store i64 %7, i64* %arrayidx12, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body5, %if.then9
  %dec = add i64 %j.02, -1
  %arrayidx.1 = getelementptr inbounds i64, i64* %ptr, i64 %dec
  %9 = load i64, i64* %arrayidx.1, align 8
  %sub6.1 = sub i64 %dec, 1
  %arrayidx7.1 = getelementptr inbounds i64, i64* %ptr, i64 %sub6.1
  %10 = load i64, i64* %arrayidx7.1, align 8
  %cmp8.1 = icmp ult i64 %9, %10
  br i1 %cmp8.1, label %if.then9.1, label %for.inc.1

for.cond2.for.inc14_crit_edge.unr-lcssa:          ; preds = %for.inc.3
  br label %for.cond2.for.inc14_crit_edge

for.cond2.for.inc14_crit_edge:                    ; preds = %for.body5.prol.loopexit, %for.cond2.for.inc14_crit_edge.unr-lcssa
  %i.06 = phi i64 [ %i.04, %for.body5.prol.loopexit ], [ %i.04, %for.cond2.for.inc14_crit_edge.unr-lcssa ]
  br label %for.inc14

for.inc14:                                        ; preds = %for.cond2.for.inc14_crit_edge, %for.body
  %i.05 = phi i64 [ %i.06, %for.cond2.for.inc14_crit_edge ], [ %i.04, %for.body ]
  %inc = add i64 %i.05, 1
  %11 = mul i64 %inc, -1
  %12 = add i64 %0, %11
  %13 = add i64 %1, %11
  %cmp1 = icmp ult i64 %inc, %n
  br i1 %cmp1, label %for.body, label %for.cond.for.end15.loopexit_crit_edge

for.cond.for.end15.loopexit_crit_edge:            ; preds = %for.inc14
  br label %for.end15.loopexit

for.end15.loopexit:                               ; preds = %for.cond.for.end15.loopexit_crit_edge, %for.cond.preheader
  br label %for.end15

for.end15:                                        ; preds = %for.end15.loopexit, %entry
  ret void

if.then9.1:                                       ; preds = %for.inc
  %arrayidx10.1 = getelementptr inbounds i64, i64* %ptr, i64 %dec
  store i64 %10, i64* %arrayidx10.1, align 8
  %sub11.1 = sub i64 %dec, 1
  %arrayidx12.1 = getelementptr inbounds i64, i64* %ptr, i64 %sub11.1
  store i64 %9, i64* %arrayidx12.1, align 8
  br label %for.inc.1

for.inc.1:                                        ; preds = %if.then9.1, %for.inc
  %dec.1 = add i64 %dec, -1
  %arrayidx.2 = getelementptr inbounds i64, i64* %ptr, i64 %dec.1
  %14 = load i64, i64* %arrayidx.2, align 8
  %sub6.2 = sub i64 %dec.1, 1
  %arrayidx7.2 = getelementptr inbounds i64, i64* %ptr, i64 %sub6.2
  %15 = load i64, i64* %arrayidx7.2, align 8
  %cmp8.2 = icmp ult i64 %14, %15
  br i1 %cmp8.2, label %if.then9.2, label %for.inc.2

if.then9.2:                                       ; preds = %for.inc.1
  %arrayidx10.2 = getelementptr inbounds i64, i64* %ptr, i64 %dec.1
  store i64 %15, i64* %arrayidx10.2, align 8
  %sub11.2 = sub i64 %dec.1, 1
  %arrayidx12.2 = getelementptr inbounds i64, i64* %ptr, i64 %sub11.2
  store i64 %14, i64* %arrayidx12.2, align 8
  br label %for.inc.2

for.inc.2:                                        ; preds = %if.then9.2, %for.inc.1
  %dec.2 = add i64 %dec.1, -1
  %arrayidx.3 = getelementptr inbounds i64, i64* %ptr, i64 %dec.2
  %16 = load i64, i64* %arrayidx.3, align 8
  %sub6.3 = sub i64 %dec.2, 1
  %arrayidx7.3 = getelementptr inbounds i64, i64* %ptr, i64 %sub6.3
  %17 = load i64, i64* %arrayidx7.3, align 8
  %cmp8.3 = icmp ult i64 %16, %17
  br i1 %cmp8.3, label %if.then9.3, label %for.inc.3

if.then9.3:                                       ; preds = %for.inc.2
  %arrayidx10.3 = getelementptr inbounds i64, i64* %ptr, i64 %dec.2
  store i64 %17, i64* %arrayidx10.3, align 8
  %sub11.3 = sub i64 %dec.2, 1
  %arrayidx12.3 = getelementptr inbounds i64, i64* %ptr, i64 %sub11.3
  store i64 %16, i64* %arrayidx12.3, align 8
  br label %for.inc.3

for.inc.3:                                        ; preds = %if.then9.3, %for.inc.2
  %dec.3 = add i64 %dec.2, -1
  %cmp3.3 = icmp ugt i64 %dec.3, %i.04
  br i1 %cmp3.3, label %for.body5, label %for.cond2.for.inc14_crit_edge.unr-lcssa, !llvm.loop !8
}

; Function Attrs: nounwind ssp uwtable
define void @put_inputs(i64 %n, i64* %ptr) #0 {
entry:
  %cmp = icmp eq i64 %n, 0
  br i1 %cmp, label %for.end, label %for.cond.preheader

for.cond.preheader:                               ; preds = %entry
  %cmp11 = icmp ult i64 0, %n
  br i1 %cmp11, label %for.body.lr.ph, label %for.end.loopexit

for.body.lr.ph:                                   ; preds = %for.cond.preheader
  %0 = add i64 %n, -1
  %xtraiter = and i64 %n, 3
  %1 = icmp ult i64 %0, 3
  br i1 %1, label %for.cond.for.end.loopexit_crit_edge.unr-lcssa, label %for.body.lr.ph.new

for.body.lr.ph.new:                               ; preds = %for.body.lr.ph
  %unroll_iter = sub i64 %n, %xtraiter
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph.new
  %i.02 = phi i64 [ 0, %for.body.lr.ph.new ], [ %inc.3, %for.body ]
  %niter = phi i64 [ %unroll_iter, %for.body.lr.ph.new ], [ %niter.nsub.3, %for.body ]
  %arrayidx = getelementptr inbounds i64, i64* %ptr, i64 %i.02
  %2 = load i64, i64* %arrayidx, align 8
  call void @write(i64 %2)
  %inc = add nuw nsw i64 %i.02, 1
  %niter.nsub = sub i64 %niter, 1
  %arrayidx.1 = getelementptr inbounds i64, i64* %ptr, i64 %inc
  %3 = load i64, i64* %arrayidx.1, align 8
  call void @write(i64 %3)
  %inc.1 = add nuw nsw i64 %inc, 1
  %niter.nsub.1 = sub i64 %niter.nsub, 1
  %arrayidx.2 = getelementptr inbounds i64, i64* %ptr, i64 %inc.1
  %4 = load i64, i64* %arrayidx.2, align 8
  call void @write(i64 %4)
  %inc.2 = add nuw nsw i64 %inc.1, 1
  %niter.nsub.2 = sub i64 %niter.nsub.1, 1
  %arrayidx.3 = getelementptr inbounds i64, i64* %ptr, i64 %inc.2
  %5 = load i64, i64* %arrayidx.3, align 8
  call void @write(i64 %5)
  %inc.3 = add i64 %inc.2, 1
  %niter.nsub.3 = sub i64 %niter.nsub.2, 1
  %niter.ncmp.3 = icmp ne i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %for.body, label %for.cond.for.end.loopexit_crit_edge.unr-lcssa.loopexit, !llvm.loop !9

for.cond.for.end.loopexit_crit_edge.unr-lcssa.loopexit: ; preds = %for.body
  %i.02.unr.ph = phi i64 [ %inc.3, %for.body ]
  br label %for.cond.for.end.loopexit_crit_edge.unr-lcssa

for.cond.for.end.loopexit_crit_edge.unr-lcssa:    ; preds = %for.cond.for.end.loopexit_crit_edge.unr-lcssa.loopexit, %for.body.lr.ph
  %i.02.unr = phi i64 [ 0, %for.body.lr.ph ], [ %i.02.unr.ph, %for.cond.for.end.loopexit_crit_edge.unr-lcssa.loopexit ]
  %lcmp.mod = icmp ne i64 %xtraiter, 0
  br i1 %lcmp.mod, label %for.body.epil.preheader, label %for.cond.for.end.loopexit_crit_edge

for.body.epil.preheader:                          ; preds = %for.cond.for.end.loopexit_crit_edge.unr-lcssa
  br label %for.body.epil

for.body.epil:                                    ; preds = %for.body.epil, %for.body.epil.preheader
  %i.02.epil = phi i64 [ %i.02.unr, %for.body.epil.preheader ], [ %inc.epil, %for.body.epil ]
  %epil.iter = phi i64 [ %xtraiter, %for.body.epil.preheader ], [ %epil.iter.sub, %for.body.epil ]
  %arrayidx.epil = getelementptr inbounds i64, i64* %ptr, i64 %i.02.epil
  %6 = load i64, i64* %arrayidx.epil, align 8
  call void @write(i64 %6)
  %inc.epil = add i64 %i.02.epil, 1
  %cmp1.epil = icmp ult i64 %inc.epil, %n
  %epil.iter.sub = sub i64 %epil.iter, 1
  %epil.iter.cmp = icmp ne i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %for.body.epil, label %for.cond.for.end.loopexit_crit_edge.epilog-lcssa, !llvm.loop !10

for.cond.for.end.loopexit_crit_edge.epilog-lcssa: ; preds = %for.body.epil
  br label %for.cond.for.end.loopexit_crit_edge

for.cond.for.end.loopexit_crit_edge:              ; preds = %for.cond.for.end.loopexit_crit_edge.unr-lcssa, %for.cond.for.end.loopexit_crit_edge.epilog-lcssa
  br label %for.end.loopexit

for.end.loopexit:                                 ; preds = %for.cond.for.end.loopexit_crit_edge, %for.cond.preheader
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  ret void
}

declare void @write(i64) #3

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %cmp = icmp eq i64 %call, 0
  br i1 %cmp, label %cleanup, label %if.end

if.end:                                           ; preds = %entry
  %call1 = call i64* @get_inputs(i64 %call)
  call void @sort(i64 %call, i64* %call1)
  call void @put_inputs(i64 %call, i64* %call1)
  br label %cleanup

cleanup:                                          ; preds = %entry, %if.end
  ret i32 0
}

attributes #0 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { allocsize(0) }

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
!9 = distinct !{!9, !5}
!10 = distinct !{!10, !5}
