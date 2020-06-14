; ModuleID = 'test_backend.ll'
source_filename = "matmul1/src/matmul1.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: nounwind ssp uwtable
define void @matmul(i32 %dim, i64* %c, i64* %a, i64* %b) #0 {
entry:
  %cmp7 = icmp eq i32 %dim, 0
  br i1 %cmp7, label %for.end22, label %for.cond1.preheader.us.preheader

for.cond1.preheader.us.preheader:                 ; preds = %entry
  %0 = zext i32 %dim to i64
  br label %for.cond1.preheader.us

for.cond1.preheader.us:                           ; preds = %for.cond1.for.end19_crit_edge.us-lcssa.us.us, %for.cond1.preheader.us.preheader
  %i.08.us = phi i32 [ %inc21.us, %for.cond1.for.end19_crit_edge.us-lcssa.us.us ], [ 0, %for.cond1.preheader.us.preheader ]
  %mul.us = mul i32 %i.08.us, %dim
  br label %for.cond4.preheader.us.us

for.cond4.preheader.us.us:                        ; preds = %for.end.us.us, %for.cond1.preheader.us
  %indvars.iv1 = phi i64 [ %indvars.iv.next2, %for.end.us.us ], [ 0, %for.cond1.preheader.us ]
  %xtraiter111 = urem i64 %0, 2
  %1 = icmp eq i32 %dim, 1
  br i1 %1, label %for.end.us.us.unr-lcssa, label %for.cond4.preheader.us.us.new

for.cond4.preheader.us.us.new:                    ; preds = %for.cond4.preheader.us.us
  %unroll_iter = sub nsw i64 %0, %xtraiter111
  br label %for.body6.us.us

for.end.us.us.unr-lcssa:                          ; preds = %for.body6.us.us, %for.cond4.preheader.us.us
  %add12.us.us.lcssa.ph = phi i64 [ undef, %for.cond4.preheader.us.us ], [ %add12.us.us.1, %for.body6.us.us ]
  %indvars.iv.unr = phi i64 [ 0, %for.cond4.preheader.us.us ], [ %indvars.iv.next.1, %for.body6.us.us ]
  %sum.03.us.us.unr = phi i64 [ 0, %for.cond4.preheader.us.us ], [ %add12.us.us.1, %for.body6.us.us ]
  %lcmp.mod = icmp eq i64 %xtraiter111, 0
  br i1 %lcmp.mod, label %for.end.us.us.unr-lcssa.for.end.us.us_crit_edge, label %for.end.us.us.epilog-lcssa

for.end.us.us.unr-lcssa.for.end.us.us_crit_edge:  ; preds = %for.end.us.us.unr-lcssa
  %.pre = trunc i64 %indvars.iv1 to i32
  br label %for.end.us.us

for.end.us.us.epilog-lcssa:                       ; preds = %for.end.us.us.unr-lcssa
  %2 = trunc i64 %indvars.iv.unr to i32
  %mul7.us.us.epil = mul i32 %2, %dim
  %3 = trunc i64 %indvars.iv1 to i32
  %add8.us.us.epil = add i32 %mul7.us.us.epil, %3
  %idxprom9.us.us.epil = zext i32 %add8.us.us.epil to i64
  %4 = ptrtoint i64* %b to i64
  %5 = mul i64 %idxprom9.us.us.epil, 8
  %6 = add i64 %5, %4
  %7 = inttoptr i64 %6 to i64*
  %8 = load i64, i64* %7, align 8
  %add.us.us.epil = add i32 %mul.us, %2
  %idxprom.us.us.epil = zext i32 %add.us.us.epil to i64
  %9 = ptrtoint i64* %a to i64
  %10 = mul i64 %idxprom.us.us.epil, 8
  %11 = add i64 %10, %9
  %12 = inttoptr i64 %11 to i64*
  %13 = load i64, i64* %12, align 8
  %mul11.us.us.epil = mul i64 %8, %13
  %add12.us.us.epil = add i64 %mul11.us.us.epil, %sum.03.us.us.unr
  br label %for.end.us.us

for.end.us.us:                                    ; preds = %for.end.us.us.epilog-lcssa, %for.end.us.us.unr-lcssa.for.end.us.us_crit_edge
  %.pre-phi = phi i32 [ %.pre, %for.end.us.us.unr-lcssa.for.end.us.us_crit_edge ], [ %3, %for.end.us.us.epilog-lcssa ]
  %add12.us.us.lcssa = phi i64 [ %add12.us.us.lcssa.ph, %for.end.us.us.unr-lcssa.for.end.us.us_crit_edge ], [ %add12.us.us.epil, %for.end.us.us.epilog-lcssa ]
  %add14.us.us = add i32 %mul.us, %.pre-phi
  %idxprom15.us.us = zext i32 %add14.us.us to i64
  %14 = ptrtoint i64* %c to i64
  %15 = mul i64 %idxprom15.us.us, 8
  %16 = add i64 %15, %14
  %17 = inttoptr i64 %16 to i64*
  store i64 %add12.us.us.lcssa, i64* %17, align 8
  %indvars.iv.next2 = add nuw nsw i64 %indvars.iv1, 1
  %exitcond4 = icmp eq i64 %indvars.iv.next2, %0
  br i1 %exitcond4, label %for.cond1.for.end19_crit_edge.us-lcssa.us.us, label %for.cond4.preheader.us.us

for.body6.us.us:                                  ; preds = %for.body6.us.us, %for.cond4.preheader.us.us.new
  %indvars.iv = phi i64 [ 0, %for.cond4.preheader.us.us.new ], [ %indvars.iv.next.1, %for.body6.us.us ]
  %sum.03.us.us = phi i64 [ 0, %for.cond4.preheader.us.us.new ], [ %add12.us.us.1, %for.body6.us.us ]
  %niter = phi i64 [ %unroll_iter, %for.cond4.preheader.us.us.new ], [ %niter.nsub.1, %for.body6.us.us ]
  %18 = trunc i64 %indvars.iv to i32
  %add.us.us = add i32 %mul.us, %18
  %idxprom.us.us = zext i32 %add.us.us to i64
  %19 = ptrtoint i64* %a to i64
  %20 = mul i64 %idxprom.us.us, 8
  %21 = add i64 %20, %19
  %22 = inttoptr i64 %21 to i64*
  %23 = load i64, i64* %22, align 8
  %mul7.us.us = mul i32 %18, %dim
  %24 = trunc i64 %indvars.iv1 to i32
  %add8.us.us = add i32 %mul7.us.us, %24
  %idxprom9.us.us = zext i32 %add8.us.us to i64
  %25 = ptrtoint i64* %b to i64
  %26 = mul i64 %idxprom9.us.us, 8
  %27 = add i64 %26, %25
  %28 = inttoptr i64 %27 to i64*
  %29 = load i64, i64* %28, align 8
  %mul11.us.us = mul i64 %29, %23
  %add12.us.us = add i64 %mul11.us.us, %sum.03.us.us
  %30 = trunc i64 %indvars.iv to i32
  %31 = or i32 %30, 1
  %add.us.us.1 = add i32 %mul.us, %31
  %idxprom.us.us.1 = zext i32 %add.us.us.1 to i64
  %32 = ptrtoint i64* %a to i64
  %33 = mul i64 %idxprom.us.us.1, 8
  %34 = add i64 %33, %32
  %35 = inttoptr i64 %34 to i64*
  %36 = load i64, i64* %35, align 8
  %mul7.us.us.1 = mul i32 %31, %dim
  %add8.us.us.1 = add i32 %mul7.us.us.1, %24
  %idxprom9.us.us.1 = zext i32 %add8.us.us.1 to i64
  %37 = ptrtoint i64* %b to i64
  %38 = mul i64 %idxprom9.us.us.1, 8
  %39 = add i64 %38, %37
  %40 = inttoptr i64 %39 to i64*
  %41 = load i64, i64* %40, align 8
  %mul11.us.us.1 = mul i64 %41, %36
  %add12.us.us.1 = add i64 %add12.us.us, %mul11.us.us.1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2
  %niter.nsub.1 = add i64 %niter, -2
  %niter.ncmp.1 = icmp eq i64 %niter.nsub.1, 0
  br i1 %niter.ncmp.1, label %for.end.us.us.unr-lcssa, label %for.body6.us.us

for.cond1.for.end19_crit_edge.us-lcssa.us.us:     ; preds = %for.end.us.us
  %inc21.us = add nuw i32 %i.08.us, 1
  %exitcond5 = icmp eq i32 %inc21.us, %dim
  br i1 %exitcond5, label %for.end22, label %for.cond1.preheader.us

for.end22:                                        ; preds = %for.cond1.for.end19_crit_edge.us-lcssa.us.us, %entry
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @read_mat(i32 %dim, i64* %mat) #0 {
entry:
  %cmp3 = icmp eq i32 %dim, 0
  br i1 %cmp3, label %for.end6, label %for.cond1.preheader.us

for.cond1.preheader.us:                           ; preds = %for.end.us, %entry
  %i.04.us = phi i32 [ %inc5.us, %for.end.us ], [ 0, %entry ]
  %mul.us = mul i32 %i.04.us, %dim
  %wide.trip.count = zext i32 %dim to i64
  br label %for.body3.us

for.body3.us:                                     ; preds = %for.body3.us, %for.cond1.preheader.us
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body3.us ], [ 0, %for.cond1.preheader.us ]
  %call.us = tail call i64 (...) @read() #3
  %0 = trunc i64 %indvars.iv to i32
  %add.us = add i32 %mul.us, %0
  %idxprom.us = zext i32 %add.us to i64
  %1 = ptrtoint i64* %mat to i64
  %2 = mul i64 %idxprom.us, 8
  %3 = add i64 %2, %1
  %4 = inttoptr i64 %3 to i64*
  store i64 %call.us, i64* %4, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.end.us, label %for.body3.us

for.end.us:                                       ; preds = %for.body3.us
  %inc5.us = add nuw i32 %i.04.us, 1
  %exitcond1 = icmp eq i32 %inc5.us, %dim
  br i1 %exitcond1, label %for.end6, label %for.cond1.preheader.us

for.end6:                                         ; preds = %for.end.us, %entry
  ret void
}

declare i64 @read(...) #1

; Function Attrs: nounwind ssp uwtable
define void @print_mat(i32 %dim, i64* %mat) #0 {
entry:
  %cmp3 = icmp eq i32 %dim, 0
  br i1 %cmp3, label %for.end6, label %for.cond1.preheader.us

for.cond1.preheader.us:                           ; preds = %for.end.us, %entry
  %i.04.us = phi i32 [ %inc5.us, %for.end.us ], [ 0, %entry ]
  %mul.us = mul i32 %i.04.us, %dim
  %wide.trip.count = zext i32 %dim to i64
  br label %for.body3.us

for.body3.us:                                     ; preds = %for.body3.us, %for.cond1.preheader.us
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body3.us ], [ 0, %for.cond1.preheader.us ]
  %0 = trunc i64 %indvars.iv to i32
  %add.us = add i32 %mul.us, %0
  %idxprom.us = zext i32 %add.us to i64
  %1 = ptrtoint i64* %mat to i64
  %2 = mul i64 %idxprom.us, 8
  %3 = add i64 %2, %1
  %4 = inttoptr i64 %3 to i64*
  %5 = load i64, i64* %4, align 8
  tail call void @write(i64 %5) #3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.end.us, label %for.body3.us

for.end.us:                                       ; preds = %for.body3.us
  %inc5.us = add nuw i32 %i.04.us, 1
  %exitcond1 = icmp eq i32 %inc5.us, %dim
  br i1 %exitcond1, label %for.end6, label %for.cond1.preheader.us

for.end6:                                         ; preds = %for.end.us, %entry
  ret void
}

declare void @write(i64) #1

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %color13 = alloca i64
  %color11 = alloca i64
  %color8 = alloca i64
  %call = tail call i64 (...) @read() #3
  %conv = trunc i64 %call to i32
  %call3 = tail call noalias i8* @malloc(i64 0) #4
  %call7 = tail call noalias i8* @malloc(i64 0) #4
  %call11 = tail call noalias i8* @malloc(i64 0) #4
  %call11.temp.s = ptrtoint i8* %call11 to i64
  store i64 %call11.temp.s, i64* %color13
  %cmp.i20 = icmp eq i32 %conv, 0
  br i1 %cmp.i20, label %for.cond.i3.preheader, label %for.cond1.i.preheader.us

for.cond1.i.preheader.us:                         ; preds = %for.end.i.us, %entry
  %i.0.i21.us = phi i32 [ %inc5.i.us, %for.end.i.us ], [ 0, %entry ]
  %mul.i.us = mul i32 %i.0.i21.us, %conv
  %wide.trip.count1811 = urem i64 %call, 4294967296
  br label %for.body3.i.us

for.body3.i.us:                                   ; preds = %for.body3.i.us, %for.cond1.i.preheader.us
  %indvars.iv16 = phi i64 [ %indvars.iv.next17, %for.body3.i.us ], [ 0, %for.cond1.i.preheader.us ]
  %call.i.us = tail call i64 (...) @read() #3
  %0 = trunc i64 %indvars.iv16 to i32
  %add.i.us = add i32 %mul.i.us, %0
  %idxprom.i.us = zext i32 %add.i.us to i64
  %1 = ptrtoint i8* %call3 to i64
  %2 = mul i64 %idxprom.i.us, 8
  %3 = add i64 %2, %1
  %4 = inttoptr i64 %3 to i64*
  store i64 %call.i.us, i64* %4, align 8
  %indvars.iv.next17 = add nuw nsw i64 %indvars.iv16, 1
  %exitcond19 = icmp eq i64 %indvars.iv.next17, %wide.trip.count1811
  br i1 %exitcond19, label %for.end.i.us, label %for.body3.i.us

for.end.i.us:                                     ; preds = %for.body3.i.us
  %inc5.i.us = add nuw i32 %i.0.i21.us, 1
  %exitcond20 = icmp eq i32 %inc5.i.us, %conv
  br i1 %exitcond20, label %for.cond.i3.preheader, label %for.cond1.i.preheader.us

for.cond.i3.preheader:                            ; preds = %for.end.i.us, %entry
  br i1 %cmp.i20, label %print_mat.exit, label %for.cond1.i7.preheader.us

for.cond1.i7.preheader.us:                        ; preds = %for.end.i16.us, %for.cond.i3.preheader
  %i.0.i116.us = phi i32 [ %inc5.i15.us, %for.end.i16.us ], [ 0, %for.cond.i3.preheader ]
  %mul.i9.us = mul i32 %i.0.i116.us, %conv
  %wide.trip.count1322 = urem i64 %call, 4294967296
  br label %for.body3.i14.us

for.body3.i14.us:                                 ; preds = %for.body3.i14.us, %for.cond1.i7.preheader.us
  %indvars.iv11 = phi i64 [ %indvars.iv.next12, %for.body3.i14.us ], [ 0, %for.cond1.i7.preheader.us ]
  %call.i8.us = tail call i64 (...) @read() #3
  %5 = trunc i64 %indvars.iv11 to i32
  %add.i10.us = add i32 %mul.i9.us, %5
  %idxprom.i11.us = zext i32 %add.i10.us to i64
  %6 = ptrtoint i8* %call7 to i64
  %7 = mul i64 %idxprom.i11.us, 8
  %8 = add i64 %7, %6
  %9 = inttoptr i64 %8 to i64*
  store i64 %call.i8.us, i64* %9, align 8
  %indvars.iv.next12 = add nuw nsw i64 %indvars.iv11, 1
  %exitcond14 = icmp eq i64 %indvars.iv.next12, %wide.trip.count1322
  br i1 %exitcond14, label %for.end.i16.us, label %for.body3.i14.us

for.end.i16.us:                                   ; preds = %for.body3.i14.us
  %inc5.i15.us = add nuw i32 %i.0.i116.us, 1
  %exitcond15 = icmp eq i32 %inc5.i15.us, %conv
  br i1 %exitcond15, label %for.cond.i20.preheader, label %for.cond1.i7.preheader.us

for.cond.i20.preheader:                           ; preds = %for.end.i16.us
  br label %for.cond1.i24.preheader.us.preheader

for.cond1.i24.preheader.us.preheader:             ; preds = %for.cond.i20.preheader
  br label %for.cond1.i24.preheader.us

for.cond1.i24.preheader.us:                       ; preds = %for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us, %for.cond1.i24.preheader.us.preheader
  %i.0.i1812.us = phi i32 [ %inc21.i.us, %for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us ], [ 0, %for.cond1.i24.preheader.us.preheader ]
  %i.0.i1812.us.temp.s = zext i32 %i.0.i1812.us to i64
  store i64 %i.0.i1812.us.temp.s, i64* %color11
  %i.0.i1812.us.temp.l = load i64, i64* %color11
  %i.0.i1812.us.temp.l1 = trunc i64 %i.0.i1812.us.temp.l to i32
  %mul.i26.us = mul i32 %i.0.i1812.us.temp.l1, %conv
  br label %for.cond4.i.preheader.us.us

for.cond4.i.preheader.us.us:                      ; preds = %for.end.i31.us.us, %for.cond1.i24.preheader.us
  %indvars.iv6 = phi i64 [ %indvars.iv.next7, %for.end.i31.us.us ], [ 0, %for.cond1.i24.preheader.us ]
  %xtraiter143 = urem i64 %call, 2
  %10 = icmp eq i64 %wide.trip.count1322, 1
  br i1 %10, label %for.end.i31.us.us.unr-lcssa, label %for.cond4.i.preheader.us.us.new

for.cond4.i.preheader.us.us.new:                  ; preds = %for.cond4.i.preheader.us.us
  %xtraiter143.temp.l2 = load i64, i64* %color8
  %unroll_iter = sub nsw i64 %wide.trip.count1322, %xtraiter143.temp.l2
  br label %for.body6.i.us.us

for.end.i31.us.us.unr-lcssa:                      ; preds = %for.body6.i.us.us, %for.cond4.i.preheader.us.us
  %add12.i.us.us.lcssa.ph = phi i64 [ undef, %for.cond4.i.preheader.us.us ], [ %add12.i.us.us.1, %for.body6.i.us.us ]
  %indvars.iv2.unr = phi i64 [ 0, %for.cond4.i.preheader.us.us ], [ %indvars.iv.next3.1, %for.body6.i.us.us ]
  %sum.0.i7.us.us.unr = phi i64 [ 0, %for.cond4.i.preheader.us.us ], [ %add12.i.us.us.1, %for.body6.i.us.us ]
  %xtraiter143.temp.l3 = load i64, i64* %color8
  %lcmp.mod = icmp eq i64 %xtraiter143.temp.l3, 0
  br i1 %lcmp.mod, label %for.end.i31.us.us, label %for.end.i31.us.us.epilog-lcssa

for.end.i31.us.us.epilog-lcssa:                   ; preds = %for.end.i31.us.us.unr-lcssa
  %mul7.i.us.us.epil = mul i64 %indvars.iv2.unr, %call
  %add8.i.us.us.epil = add i64 %mul7.i.us.us.epil, %indvars.iv6
  %11 = ptrtoint i8* %call7 to i64
  %idxprom9.i.us.us.epil54 = mul i64 %add8.i.us.us.epil, 8
  %12 = urem i64 %idxprom9.i.us.us.epil54, 4
  %13 = add i64 %12, %11
  %14 = inttoptr i64 %13 to i64*
  %15 = load i64, i64* %14, align 8
  %16 = trunc i64 %indvars.iv2.unr to i32
  %add.i27.us.us.epil = add i32 %mul.i26.us, %16
  %idxprom.i28.us.us.epil = zext i32 %add.i27.us.us.epil to i64
  %17 = ptrtoint i8* %call3 to i64
  %18 = mul i64 %idxprom.i28.us.us.epil, 8
  %19 = add i64 %18, %17
  %20 = inttoptr i64 %19 to i64*
  %21 = load i64, i64* %20, align 8
  %mul11.i.us.us.epil = mul i64 %15, %21
  %add12.i.us.us.epil = add i64 %mul11.i.us.us.epil, %sum.0.i7.us.us.unr
  br label %for.end.i31.us.us

for.end.i31.us.us:                                ; preds = %for.end.i31.us.us.epilog-lcssa, %for.end.i31.us.us.unr-lcssa
  %add12.i.us.us.lcssa = phi i64 [ %add12.i.us.us.lcssa.ph, %for.end.i31.us.us.unr-lcssa ], [ %add12.i.us.us.epil, %for.end.i31.us.us.epilog-lcssa ]
  %22 = trunc i64 %indvars.iv6 to i32
  %add14.i.us.us = add i32 %mul.i26.us, %22
  %idxprom15.i.us.us = zext i32 %add14.i.us.us to i64
  %call11.temp.l = load i64, i64* %color13
  %call11.temp.l4 = inttoptr i64 %call11.temp.l to i8*
  %23 = ptrtoint i8* %call11.temp.l4 to i64
  %24 = mul i64 %idxprom15.i.us.us, 8
  %25 = add i64 %24, %23
  %26 = inttoptr i64 %25 to i64*
  store i64 %add12.i.us.us.lcssa, i64* %26, align 8
  %indvars.iv.next7 = add nuw nsw i64 %indvars.iv6, 1
  %exitcond9 = icmp eq i64 %indvars.iv.next7, %wide.trip.count1322
  br i1 %exitcond9, label %for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us, label %for.cond4.i.preheader.us.us

for.body6.i.us.us:                                ; preds = %for.body6.i.us.us, %for.cond4.i.preheader.us.us.new
  %indvars.iv2 = phi i64 [ 0, %for.cond4.i.preheader.us.us.new ], [ %indvars.iv.next3.1, %for.body6.i.us.us ]
  %sum.0.i7.us.us = phi i64 [ 0, %for.cond4.i.preheader.us.us.new ], [ %add12.i.us.us.1, %for.body6.i.us.us ]
  %niter = phi i64 [ %unroll_iter, %for.cond4.i.preheader.us.us.new ], [ %niter.nsub.1, %for.body6.i.us.us ]
  %27 = trunc i64 %indvars.iv2 to i32
  %add.i27.us.us = add i32 %mul.i26.us, %27
  %idxprom.i28.us.us = zext i32 %add.i27.us.us to i64
  %28 = ptrtoint i8* %call3 to i64
  %29 = mul i64 %idxprom.i28.us.us, 8
  %30 = add i64 %29, %28
  %31 = inttoptr i64 %30 to i64*
  %32 = load i64, i64* %31, align 8
  %mul7.i.us.us = mul i64 %indvars.iv2, %call
  %add8.i.us.us = add i64 %mul7.i.us.us, %indvars.iv6
  %33 = ptrtoint i8* %call7 to i64
  %idxprom9.i.us.us65 = mul i64 %add8.i.us.us, 8
  %34 = urem i64 %idxprom9.i.us.us65, 4
  %35 = add i64 %34, %33
  %36 = inttoptr i64 %35 to i64*
  %37 = load i64, i64* %36, align 8
  %mul11.i.us.us = mul i64 %37, %32
  %add12.i.us.us = add i64 %mul11.i.us.us, %sum.0.i7.us.us
  %indvars.iv.next3 = or i64 %indvars.iv2, 1
  %38 = trunc i64 %indvars.iv.next3 to i32
  %add.i27.us.us.1 = add i32 %mul.i26.us, %38
  %idxprom.i28.us.us.1 = zext i32 %add.i27.us.us.1 to i64
  %39 = ptrtoint i8* %call3 to i64
  %40 = mul i64 %idxprom.i28.us.us.1, 8
  %41 = add i64 %40, %39
  %42 = inttoptr i64 %41 to i64*
  %43 = load i64, i64* %42, align 8
  %mul7.i.us.us.1 = mul i64 %indvars.iv.next3, %call
  %add8.i.us.us.1 = add i64 %mul7.i.us.us.1, %indvars.iv6
  %44 = ptrtoint i8* %call7 to i64
  %idxprom9.i.us.us.176 = mul i64 %add8.i.us.us.1, 8
  %45 = urem i64 %idxprom9.i.us.us.176, 4
  %46 = add i64 %45, %44
  %47 = inttoptr i64 %46 to i64*
  %48 = load i64, i64* %47, align 8
  %mul11.i.us.us.1 = mul i64 %48, %43
  %add12.i.us.us.1 = add i64 %add12.i.us.us, %mul11.i.us.us.1
  %indvars.iv.next3.1 = add nuw nsw i64 %indvars.iv2, 2
  %niter.nsub.1 = add i64 %niter, -2
  %niter.ncmp.1 = icmp eq i64 %niter.nsub.1, 0
  br i1 %niter.ncmp.1, label %for.end.i31.us.us.unr-lcssa, label %for.body6.i.us.us

for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us: ; preds = %for.end.i31.us.us
  %i.0.i1812.us.temp.l5 = load i64, i64* %color11
  %i.0.i1812.us.temp.l6 = trunc i64 %i.0.i1812.us.temp.l5 to i32
  %inc21.i.us = add nuw i32 %i.0.i1812.us.temp.l6, 1
  %exitcond10 = icmp eq i32 %inc21.i.us, %conv
  br i1 %exitcond10, label %for.cond1.i38.preheader.us, label %for.cond1.i24.preheader.us

for.cond1.i38.preheader.us:                       ; preds = %for.end.i46.us, %for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us
  %i.0.i324.us = phi i32 [ %inc5.i45.us, %for.end.i46.us ], [ 0, %for.cond1.i24.for.end19.i_crit_edge.us-lcssa.us.us ]
  %mul.i39.us = mul i32 %i.0.i324.us, %conv
  br label %for.body3.i44.us

for.body3.i44.us:                                 ; preds = %for.body3.i44.us, %for.cond1.i38.preheader.us
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body3.i44.us ], [ 0, %for.cond1.i38.preheader.us ]
  %49 = trunc i64 %indvars.iv to i32
  %add.i40.us = add i32 %mul.i39.us, %49
  %idxprom.i41.us = zext i32 %add.i40.us to i64
  %call11.temp.l7 = load i64, i64* %color13
  %call11.temp.l8 = inttoptr i64 %call11.temp.l7 to i8*
  %50 = ptrtoint i8* %call11.temp.l8 to i64
  %51 = mul i64 %idxprom.i41.us, 8
  %52 = add i64 %51, %50
  %53 = inttoptr i64 %52 to i64*
  %54 = load i64, i64* %53, align 8
  tail call void @write(i64 %54) #3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count1322
  br i1 %exitcond, label %for.end.i46.us, label %for.body3.i44.us

for.end.i46.us:                                   ; preds = %for.body3.i44.us
  %inc5.i45.us = add nuw i32 %i.0.i324.us, 1
  %exitcond1 = icmp eq i32 %inc5.i45.us, %conv
  br i1 %exitcond1, label %print_mat.exit, label %for.cond1.i38.preheader.us

print_mat.exit:                                   ; preds = %for.end.i46.us, %for.cond.i3.preheader
  ret i32 0
}

; Function Attrs: allocsize(0)
declare noalias i8* @malloc(i64) #2

attributes #0 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind allocsize(0) }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 15]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"clang version 10.0.0 (git@github.com:llvm/llvm-project.git d32170dbd5b0d54436537b6b75beaf44324e0c28)"}
