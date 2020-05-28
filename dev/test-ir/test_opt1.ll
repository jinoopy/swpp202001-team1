; ModuleID = 'test1.ll'
source_filename = "test1.ll"

define i32 @_Z1fi(i32 %0) {
  %2 = icmp slt i32 0, %0
  br i1 %2, label %.lr.ph, label %18

.lr.ph:                                           ; preds = %1
  %3 = add i32 %0, -1
  %xtraiter = and i32 %0, 3
  %4 = icmp ult i32 %3, 3
  br i1 %4, label %._crit_edge.unr-lcssa, label %.lr.ph.new

.lr.ph.new:                                       ; preds = %.lr.ph
  %unroll_iter = sub i32 %0, %xtraiter
  br label %5

5:                                                ; preds = %5, %.lr.ph.new
  %.03 = phi i32 [ 0, %.lr.ph.new ], [ %13, %5 ]
  %.012 = phi i32 [ 0, %.lr.ph.new ], [ %12, %5 ]
  %niter = phi i32 [ %unroll_iter, %.lr.ph.new ], [ %niter.nsub.3, %5 ]
  %6 = add nsw i32 %.012, %.03
  %7 = add nuw nsw i32 %.03, 1
  %niter.nsub = sub i32 %niter, 1
  %8 = add nsw i32 %6, %7
  %9 = add nuw nsw i32 %7, 1
  %niter.nsub.1 = sub i32 %niter.nsub, 1
  %10 = add nsw i32 %8, %9
  %11 = add nuw nsw i32 %9, 1
  %niter.nsub.2 = sub i32 %niter.nsub.1, 1
  %12 = add nsw i32 %10, %11
  %13 = add nsw i32 %11, 1
  %niter.nsub.3 = sub i32 %niter.nsub.2, 1
  %niter.ncmp.3 = icmp ne i32 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %5, label %._crit_edge.unr-lcssa.loopexit, !llvm.loop !0

._crit_edge.unr-lcssa.loopexit:                   ; preds = %5
  %split.ph.ph = phi i32 [ %12, %5 ]
  %.03.unr.ph = phi i32 [ %13, %5 ]
  %.012.unr.ph = phi i32 [ %12, %5 ]
  br label %._crit_edge.unr-lcssa

._crit_edge.unr-lcssa:                            ; preds = %._crit_edge.unr-lcssa.loopexit, %.lr.ph
  %split.ph = phi i32 [ undef, %.lr.ph ], [ %split.ph.ph, %._crit_edge.unr-lcssa.loopexit ]
  %.03.unr = phi i32 [ 0, %.lr.ph ], [ %.03.unr.ph, %._crit_edge.unr-lcssa.loopexit ]
  %.012.unr = phi i32 [ 0, %.lr.ph ], [ %.012.unr.ph, %._crit_edge.unr-lcssa.loopexit ]
  %lcmp.mod = icmp ne i32 %xtraiter, 0
  br i1 %lcmp.mod, label %.epil.preheader, label %._crit_edge

.epil.preheader:                                  ; preds = %._crit_edge.unr-lcssa
  br label %14

14:                                               ; preds = %14, %.epil.preheader
  %.03.epil = phi i32 [ %.03.unr, %.epil.preheader ], [ %16, %14 ]
  %.012.epil = phi i32 [ %.012.unr, %.epil.preheader ], [ %15, %14 ]
  %epil.iter = phi i32 [ %xtraiter, %.epil.preheader ], [ %epil.iter.sub, %14 ]
  %15 = add nsw i32 %.012.epil, %.03.epil
  %16 = add nsw i32 %.03.epil, 1
  %17 = icmp slt i32 %16, %0
  %epil.iter.sub = sub i32 %epil.iter, 1
  %epil.iter.cmp = icmp ne i32 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %14, label %._crit_edge.epilog-lcssa, !llvm.loop !2

._crit_edge.epilog-lcssa:                         ; preds = %14
  %split.ph4 = phi i32 [ %15, %14 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.unr-lcssa, %._crit_edge.epilog-lcssa
  %split = phi i32 [ %split.ph, %._crit_edge.unr-lcssa ], [ %split.ph4, %._crit_edge.epilog-lcssa ]
  br label %18

18:                                               ; preds = %._crit_edge, %1
  %.01.lcssa = phi i32 [ %split, %._crit_edge ], [ 0, %1 ]
  ret i32 %.01.lcssa
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.unroll.disable"}
!2 = distinct !{!2, !1}
