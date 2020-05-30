; ModuleID = 'test2.ll'
source_filename = "test2.ll"

define i32 @_Z1fii(i32 %0, i32 %1) {
  %3 = add i32 %0, -1
  %4 = icmp slt i32 0, %0
  br i1 %4, label %.preheader.lr.ph, label %27

.preheader.lr.ph:                                 ; preds = %2
  br label %.preheader

.preheader:                                       ; preds = %47, %.preheader.lr.ph
  %.017 = phi i32 [ 0, %.preheader.lr.ph ], [ %48, %47 ]
  %.026 = phi i32 [ 0, %.preheader.lr.ph ], [ %.1.lcssa.1, %47 ]
  %5 = icmp slt i32 0, %0
  br i1 %5, label %.lr.ph, label %24

.lr.ph:                                           ; preds = %.preheader
  %xtraiter = and i32 %0, 3
  %6 = icmp ult i32 %3, 3
  br i1 %6, label %._crit_edge.unr-lcssa, label %.lr.ph.new

.lr.ph.new:                                       ; preds = %.lr.ph
  %unroll_iter = sub i32 %0, %xtraiter
  br label %7

7:                                                ; preds = %7, %.lr.ph.new
  %.04 = phi i32 [ 0, %.lr.ph.new ], [ %19, %7 ]
  %.13 = phi i32 [ %.026, %.lr.ph.new ], [ %18, %7 ]
  %niter = phi i32 [ %unroll_iter, %.lr.ph.new ], [ %niter.nsub.3, %7 ]
  %8 = mul nsw i32 %.017, %.04
  %9 = add nsw i32 %.13, %8
  %10 = add nuw nsw i32 %.04, 1
  %niter.nsub = sub i32 %niter, 1
  %11 = mul nsw i32 %.017, %10
  %12 = add nsw i32 %9, %11
  %13 = add nuw nsw i32 %10, 1
  %niter.nsub.1 = sub i32 %niter.nsub, 1
  %14 = mul nsw i32 %.017, %13
  %15 = add nsw i32 %12, %14
  %16 = add nuw nsw i32 %13, 1
  %niter.nsub.2 = sub i32 %niter.nsub.1, 1
  %17 = mul nsw i32 %.017, %16
  %18 = add nsw i32 %15, %17
  %19 = add nsw i32 %16, 1
  %niter.nsub.3 = sub i32 %niter.nsub.2, 1
  %niter.ncmp.3 = icmp ne i32 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %7, label %._crit_edge.unr-lcssa.loopexit, !llvm.loop !0

._crit_edge.unr-lcssa.loopexit:                   ; preds = %7
  %split.ph.ph = phi i32 [ %18, %7 ]
  %.04.unr.ph = phi i32 [ %19, %7 ]
  %.13.unr.ph = phi i32 [ %18, %7 ]
  br label %._crit_edge.unr-lcssa

._crit_edge.unr-lcssa:                            ; preds = %._crit_edge.unr-lcssa.loopexit, %.lr.ph
  %split.ph = phi i32 [ undef, %.lr.ph ], [ %split.ph.ph, %._crit_edge.unr-lcssa.loopexit ]
  %.04.unr = phi i32 [ 0, %.lr.ph ], [ %.04.unr.ph, %._crit_edge.unr-lcssa.loopexit ]
  %.13.unr = phi i32 [ %.026, %.lr.ph ], [ %.13.unr.ph, %._crit_edge.unr-lcssa.loopexit ]
  %lcmp.mod = icmp ne i32 %xtraiter, 0
  br i1 %lcmp.mod, label %.epil.preheader, label %._crit_edge

.epil.preheader:                                  ; preds = %._crit_edge.unr-lcssa
  br label %20

20:                                               ; preds = %20, %.epil.preheader
  %.04.epil = phi i32 [ %.04.unr, %.epil.preheader ], [ %23, %20 ]
  %.13.epil = phi i32 [ %.13.unr, %.epil.preheader ], [ %22, %20 ]
  %epil.iter = phi i32 [ %xtraiter, %.epil.preheader ], [ %epil.iter.sub, %20 ]
  %21 = mul nsw i32 %.017, %.04.epil
  %22 = add nsw i32 %.13.epil, %21
  %23 = add nsw i32 %.04.epil, 1
  %epil.iter.sub = sub i32 %epil.iter, 1
  %epil.iter.cmp = icmp ne i32 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %20, label %._crit_edge.epilog-lcssa, !llvm.loop !2

._crit_edge.epilog-lcssa:                         ; preds = %20
  %split.ph5 = phi i32 [ %22, %20 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.unr-lcssa, %._crit_edge.epilog-lcssa
  %split = phi i32 [ %split.ph, %._crit_edge.unr-lcssa ], [ %split.ph5, %._crit_edge.epilog-lcssa ]
  br label %24

24:                                               ; preds = %._crit_edge, %.preheader
  %.019 = phi i32 [ %.017, %._crit_edge ], [ %.017, %.preheader ]
  %.1.lcssa = phi i32 [ %split, %._crit_edge ], [ %.026, %.preheader ]
  %25 = add nsw i32 %.019, 1
  %26 = icmp slt i32 %25, %0
  br i1 %26, label %.preheader.1, label %._crit_edge11

._crit_edge11:                                    ; preds = %47, %24
  %split12 = phi i32 [ %.1.lcssa, %24 ], [ %.1.lcssa.1, %47 ]
  br label %27

27:                                               ; preds = %._crit_edge11, %2
  %.02.lcssa = phi i32 [ %split12, %._crit_edge11 ], [ 0, %2 ]
  ret i32 %.02.lcssa

.preheader.1:                                     ; preds = %24
  %28 = icmp slt i32 0, %0
  br i1 %28, label %.lr.ph.1, label %47

.lr.ph.1:                                         ; preds = %.preheader.1
  %xtraiter.1 = and i32 %0, 3
  %29 = icmp ult i32 %3, 3
  br i1 %29, label %._crit_edge.unr-lcssa.1, label %.lr.ph.new.1

.lr.ph.new.1:                                     ; preds = %.lr.ph.1
  %unroll_iter.1 = sub i32 %0, %xtraiter.1
  br label %30

30:                                               ; preds = %30, %.lr.ph.new.1
  %.04.1 = phi i32 [ 0, %.lr.ph.new.1 ], [ %42, %30 ]
  %.13.1 = phi i32 [ %.1.lcssa, %.lr.ph.new.1 ], [ %41, %30 ]
  %niter.1 = phi i32 [ %unroll_iter.1, %.lr.ph.new.1 ], [ %niter.nsub.3.1, %30 ]
  %31 = mul nsw i32 %25, %.04.1
  %32 = add nsw i32 %.13.1, %31
  %33 = add nuw nsw i32 %.04.1, 1
  %niter.nsub.113 = sub i32 %niter.1, 1
  %34 = mul nsw i32 %25, %33
  %35 = add nsw i32 %32, %34
  %36 = add nuw nsw i32 %33, 1
  %niter.nsub.1.1 = sub i32 %niter.nsub.113, 1
  %37 = mul nsw i32 %25, %36
  %38 = add nsw i32 %35, %37
  %39 = add nuw nsw i32 %36, 1
  %niter.nsub.2.1 = sub i32 %niter.nsub.1.1, 1
  %40 = mul nsw i32 %25, %39
  %41 = add nsw i32 %38, %40
  %42 = add nsw i32 %39, 1
  %niter.nsub.3.1 = sub i32 %niter.nsub.2.1, 1
  %niter.ncmp.3.1 = icmp ne i32 %niter.nsub.3.1, 0
  br i1 %niter.ncmp.3.1, label %30, label %._crit_edge.unr-lcssa.loopexit.1, !llvm.loop !0

._crit_edge.unr-lcssa.loopexit.1:                 ; preds = %30
  %split.ph.ph.1 = phi i32 [ %41, %30 ]
  %.04.unr.ph.1 = phi i32 [ %42, %30 ]
  %.13.unr.ph.1 = phi i32 [ %41, %30 ]
  br label %._crit_edge.unr-lcssa.1

._crit_edge.unr-lcssa.1:                          ; preds = %._crit_edge.unr-lcssa.loopexit.1, %.lr.ph.1
  %split.ph.1 = phi i32 [ undef, %.lr.ph.1 ], [ %split.ph.ph.1, %._crit_edge.unr-lcssa.loopexit.1 ]
  %.04.unr.1 = phi i32 [ 0, %.lr.ph.1 ], [ %.04.unr.ph.1, %._crit_edge.unr-lcssa.loopexit.1 ]
  %.13.unr.1 = phi i32 [ %.1.lcssa, %.lr.ph.1 ], [ %.13.unr.ph.1, %._crit_edge.unr-lcssa.loopexit.1 ]
  %lcmp.mod.1 = icmp ne i32 %xtraiter.1, 0
  br i1 %lcmp.mod.1, label %.epil.preheader.1, label %._crit_edge.1

.epil.preheader.1:                                ; preds = %._crit_edge.unr-lcssa.1
  br label %43

43:                                               ; preds = %43, %.epil.preheader.1
  %.04.epil.1 = phi i32 [ %.04.unr.1, %.epil.preheader.1 ], [ %46, %43 ]
  %.13.epil.1 = phi i32 [ %.13.unr.1, %.epil.preheader.1 ], [ %45, %43 ]
  %epil.iter.1 = phi i32 [ %xtraiter.1, %.epil.preheader.1 ], [ %epil.iter.sub.1, %43 ]
  %44 = mul nsw i32 %25, %.04.epil.1
  %45 = add nsw i32 %.13.epil.1, %44
  %46 = add nsw i32 %.04.epil.1, 1
  %epil.iter.sub.1 = sub i32 %epil.iter.1, 1
  %epil.iter.cmp.1 = icmp ne i32 %epil.iter.sub.1, 0
  br i1 %epil.iter.cmp.1, label %43, label %._crit_edge.epilog-lcssa.1, !llvm.loop !2

._crit_edge.epilog-lcssa.1:                       ; preds = %43
  %split.ph5.1 = phi i32 [ %45, %43 ]
  br label %._crit_edge.1

._crit_edge.1:                                    ; preds = %._crit_edge.epilog-lcssa.1, %._crit_edge.unr-lcssa.1
  %split.1 = phi i32 [ %split.ph.1, %._crit_edge.unr-lcssa.1 ], [ %split.ph5.1, %._crit_edge.epilog-lcssa.1 ]
  br label %47

47:                                               ; preds = %._crit_edge.1, %.preheader.1
  %.1.lcssa.1 = phi i32 [ %split.1, %._crit_edge.1 ], [ %.1.lcssa, %.preheader.1 ]
  %48 = add nsw i32 %25, 1
  %49 = icmp slt i32 %48, %0
  br i1 %49, label %.preheader, label %._crit_edge11, !llvm.loop !3
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.unroll.disable"}
!2 = distinct !{!2, !1}
!3 = distinct !{!3, !1}
