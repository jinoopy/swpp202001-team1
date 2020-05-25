; ModuleID = 'test2.ll'
source_filename = "binary_tree/src/binary_tree.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

; Function Attrs: nounwind ssp uwtable
define i64 @insert(i64* %root, i64 %data) #0 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %cleanup.3, %entry
  %curr.0 = phi i64* [ %root, %entry ], [ %curr.1.3, %cleanup.3 ]
  %retval.0 = phi i64 [ 0, %entry ], [ %retval.1.3, %cleanup.3 ]
  %0 = load i64, i64* %curr.0, align 8
  %cmp = icmp ugt i64 %0, %data
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %while.cond
  %add.ptr = getelementptr inbounds i64, i64* %curr.0, i64 1
  %1 = load i64, i64* %add.ptr, align 8
  %2 = inttoptr i64 %1 to i64*
  %cmp1 = icmp eq i64* %2, null
  br i1 %cmp1, label %if.then2, label %cleanup

if.then2:                                         ; preds = %if.then
  %call = call i8* @malloc(i64 24) #4
  %3 = bitcast i8* %call to i64*
  store i64 %data, i64* %3, align 8
  %add.ptr3 = getelementptr inbounds i64, i64* %3, i64 1
  store i64 0, i64* %add.ptr3, align 8
  %add.ptr4 = getelementptr inbounds i64, i64* %3, i64 2
  store i64 0, i64* %add.ptr4, align 8
  %4 = ptrtoint i64* %3 to i64
  %add.ptr5 = getelementptr inbounds i64, i64* %curr.0, i64 1
  store i64 %4, i64* %add.ptr5, align 8
  br label %cleanup

if.else:                                          ; preds = %while.cond
  %cmp6 = icmp ult i64 %0, %data
  br i1 %cmp6, label %if.then7, label %cleanup

if.then7:                                         ; preds = %if.else
  %add.ptr8 = getelementptr inbounds i64, i64* %curr.0, i64 2
  %5 = load i64, i64* %add.ptr8, align 8
  %6 = inttoptr i64 %5 to i64*
  %cmp9 = icmp eq i64* %6, null
  br i1 %cmp9, label %if.then10, label %cleanup

if.then10:                                        ; preds = %if.then7
  %call12 = call i8* @malloc(i64 24) #4
  %7 = bitcast i8* %call12 to i64*
  store i64 %data, i64* %7, align 8
  %add.ptr13 = getelementptr inbounds i64, i64* %7, i64 1
  store i64 0, i64* %add.ptr13, align 8
  %add.ptr14 = getelementptr inbounds i64, i64* %7, i64 2
  store i64 0, i64* %add.ptr14, align 8
  %8 = ptrtoint i64* %7 to i64
  %add.ptr15 = getelementptr inbounds i64, i64* %curr.0, i64 2
  store i64 %8, i64* %add.ptr15, align 8
  br label %cleanup

cleanup:                                          ; preds = %if.else, %if.then7, %if.then, %if.then10, %if.then2
  %curr.1 = phi i64* [ %curr.0, %if.then2 ], [ %curr.0, %if.then10 ], [ %2, %if.then ], [ %6, %if.then7 ], [ %curr.0, %if.else ]
  %cleanup.dest.slot.0 = phi i32 [ 1, %if.then2 ], [ 1, %if.then10 ], [ 2, %if.then ], [ 2, %if.then7 ], [ 1, %if.else ]
  %retval.1 = phi i64 [ 1, %if.then2 ], [ 1, %if.then10 ], [ %retval.0, %if.then ], [ %retval.0, %if.then7 ], [ 0, %if.else ]
  %cond = icmp eq i32 %cleanup.dest.slot.0, 2
  br i1 %cond, label %while.cond.1, label %cleanup19

cleanup19:                                        ; preds = %cleanup.3, %cleanup.2, %cleanup.1, %cleanup
  %retval.1.lcssa = phi i64 [ %retval.1, %cleanup ], [ %retval.1.1, %cleanup.1 ], [ %retval.1.2, %cleanup.2 ], [ %retval.1.3, %cleanup.3 ]
  ret i64 %retval.1.lcssa

while.cond.1:                                     ; preds = %cleanup
  %9 = load i64, i64* %curr.1, align 8
  %cmp.1 = icmp ugt i64 %9, %data
  br i1 %cmp.1, label %if.then.1, label %if.else.1

if.else.1:                                        ; preds = %while.cond.1
  %cmp6.1 = icmp ult i64 %9, %data
  br i1 %cmp6.1, label %if.then7.1, label %cleanup.1

if.then7.1:                                       ; preds = %if.else.1
  %add.ptr8.1 = getelementptr inbounds i64, i64* %curr.1, i64 2
  %10 = load i64, i64* %add.ptr8.1, align 8
  %11 = inttoptr i64 %10 to i64*
  %cmp9.1 = icmp eq i64* %11, null
  br i1 %cmp9.1, label %if.then10.1, label %cleanup.1

if.then10.1:                                      ; preds = %if.then7.1
  %call12.1 = call i8* @malloc(i64 24) #4
  %12 = bitcast i8* %call12.1 to i64*
  store i64 %data, i64* %12, align 8
  %add.ptr13.1 = getelementptr inbounds i64, i64* %12, i64 1
  store i64 0, i64* %add.ptr13.1, align 8
  %add.ptr14.1 = getelementptr inbounds i64, i64* %12, i64 2
  store i64 0, i64* %add.ptr14.1, align 8
  %13 = ptrtoint i64* %12 to i64
  %add.ptr15.1 = getelementptr inbounds i64, i64* %curr.1, i64 2
  store i64 %13, i64* %add.ptr15.1, align 8
  br label %cleanup.1

if.then.1:                                        ; preds = %while.cond.1
  %add.ptr.1 = getelementptr inbounds i64, i64* %curr.1, i64 1
  %14 = load i64, i64* %add.ptr.1, align 8
  %15 = inttoptr i64 %14 to i64*
  %cmp1.1 = icmp eq i64* %15, null
  br i1 %cmp1.1, label %if.then2.1, label %cleanup.1

if.then2.1:                                       ; preds = %if.then.1
  %call.1 = call i8* @malloc(i64 24) #4
  %16 = bitcast i8* %call.1 to i64*
  store i64 %data, i64* %16, align 8
  %add.ptr3.1 = getelementptr inbounds i64, i64* %16, i64 1
  store i64 0, i64* %add.ptr3.1, align 8
  %add.ptr4.1 = getelementptr inbounds i64, i64* %16, i64 2
  store i64 0, i64* %add.ptr4.1, align 8
  %17 = ptrtoint i64* %16 to i64
  %add.ptr5.1 = getelementptr inbounds i64, i64* %curr.1, i64 1
  store i64 %17, i64* %add.ptr5.1, align 8
  br label %cleanup.1

cleanup.1:                                        ; preds = %if.then2.1, %if.then.1, %if.then10.1, %if.then7.1, %if.else.1
  %curr.1.1 = phi i64* [ %curr.1, %if.then2.1 ], [ %curr.1, %if.then10.1 ], [ %15, %if.then.1 ], [ %11, %if.then7.1 ], [ %curr.1, %if.else.1 ]
  %cleanup.dest.slot.0.1 = phi i32 [ 1, %if.then2.1 ], [ 1, %if.then10.1 ], [ 2, %if.then.1 ], [ 2, %if.then7.1 ], [ 1, %if.else.1 ]
  %retval.1.1 = phi i64 [ 1, %if.then2.1 ], [ 1, %if.then10.1 ], [ %retval.1, %if.then.1 ], [ %retval.1, %if.then7.1 ], [ 0, %if.else.1 ]
  %cond.1 = icmp eq i32 %cleanup.dest.slot.0.1, 2
  br i1 %cond.1, label %while.cond.2, label %cleanup19

while.cond.2:                                     ; preds = %cleanup.1
  %18 = load i64, i64* %curr.1.1, align 8
  %cmp.2 = icmp ugt i64 %18, %data
  br i1 %cmp.2, label %if.then.2, label %if.else.2

if.else.2:                                        ; preds = %while.cond.2
  %cmp6.2 = icmp ult i64 %18, %data
  br i1 %cmp6.2, label %if.then7.2, label %cleanup.2

if.then7.2:                                       ; preds = %if.else.2
  %add.ptr8.2 = getelementptr inbounds i64, i64* %curr.1.1, i64 2
  %19 = load i64, i64* %add.ptr8.2, align 8
  %20 = inttoptr i64 %19 to i64*
  %cmp9.2 = icmp eq i64* %20, null
  br i1 %cmp9.2, label %if.then10.2, label %cleanup.2

if.then10.2:                                      ; preds = %if.then7.2
  %call12.2 = call i8* @malloc(i64 24) #4
  %21 = bitcast i8* %call12.2 to i64*
  store i64 %data, i64* %21, align 8
  %add.ptr13.2 = getelementptr inbounds i64, i64* %21, i64 1
  store i64 0, i64* %add.ptr13.2, align 8
  %add.ptr14.2 = getelementptr inbounds i64, i64* %21, i64 2
  store i64 0, i64* %add.ptr14.2, align 8
  %22 = ptrtoint i64* %21 to i64
  %add.ptr15.2 = getelementptr inbounds i64, i64* %curr.1.1, i64 2
  store i64 %22, i64* %add.ptr15.2, align 8
  br label %cleanup.2

if.then.2:                                        ; preds = %while.cond.2
  %add.ptr.2 = getelementptr inbounds i64, i64* %curr.1.1, i64 1
  %23 = load i64, i64* %add.ptr.2, align 8
  %24 = inttoptr i64 %23 to i64*
  %cmp1.2 = icmp eq i64* %24, null
  br i1 %cmp1.2, label %if.then2.2, label %cleanup.2

if.then2.2:                                       ; preds = %if.then.2
  %call.2 = call i8* @malloc(i64 24) #4
  %25 = bitcast i8* %call.2 to i64*
  store i64 %data, i64* %25, align 8
  %add.ptr3.2 = getelementptr inbounds i64, i64* %25, i64 1
  store i64 0, i64* %add.ptr3.2, align 8
  %add.ptr4.2 = getelementptr inbounds i64, i64* %25, i64 2
  store i64 0, i64* %add.ptr4.2, align 8
  %26 = ptrtoint i64* %25 to i64
  %add.ptr5.2 = getelementptr inbounds i64, i64* %curr.1.1, i64 1
  store i64 %26, i64* %add.ptr5.2, align 8
  br label %cleanup.2

cleanup.2:                                        ; preds = %if.then2.2, %if.then.2, %if.then10.2, %if.then7.2, %if.else.2
  %curr.1.2 = phi i64* [ %curr.1.1, %if.then2.2 ], [ %curr.1.1, %if.then10.2 ], [ %24, %if.then.2 ], [ %20, %if.then7.2 ], [ %curr.1.1, %if.else.2 ]
  %cleanup.dest.slot.0.2 = phi i32 [ 1, %if.then2.2 ], [ 1, %if.then10.2 ], [ 2, %if.then.2 ], [ 2, %if.then7.2 ], [ 1, %if.else.2 ]
  %retval.1.2 = phi i64 [ 1, %if.then2.2 ], [ 1, %if.then10.2 ], [ %retval.1.1, %if.then.2 ], [ %retval.1.1, %if.then7.2 ], [ 0, %if.else.2 ]
  %cond.2 = icmp eq i32 %cleanup.dest.slot.0.2, 2
  br i1 %cond.2, label %while.cond.3, label %cleanup19

while.cond.3:                                     ; preds = %cleanup.2
  %27 = load i64, i64* %curr.1.2, align 8
  %cmp.3 = icmp ugt i64 %27, %data
  br i1 %cmp.3, label %if.then.3, label %if.else.3

if.else.3:                                        ; preds = %while.cond.3
  %cmp6.3 = icmp ult i64 %27, %data
  br i1 %cmp6.3, label %if.then7.3, label %cleanup.3

if.then7.3:                                       ; preds = %if.else.3
  %add.ptr8.3 = getelementptr inbounds i64, i64* %curr.1.2, i64 2
  %28 = load i64, i64* %add.ptr8.3, align 8
  %29 = inttoptr i64 %28 to i64*
  %cmp9.3 = icmp eq i64* %29, null
  br i1 %cmp9.3, label %if.then10.3, label %cleanup.3

if.then10.3:                                      ; preds = %if.then7.3
  %call12.3 = call i8* @malloc(i64 24) #4
  %30 = bitcast i8* %call12.3 to i64*
  store i64 %data, i64* %30, align 8
  %add.ptr13.3 = getelementptr inbounds i64, i64* %30, i64 1
  store i64 0, i64* %add.ptr13.3, align 8
  %add.ptr14.3 = getelementptr inbounds i64, i64* %30, i64 2
  store i64 0, i64* %add.ptr14.3, align 8
  %31 = ptrtoint i64* %30 to i64
  %add.ptr15.3 = getelementptr inbounds i64, i64* %curr.1.2, i64 2
  store i64 %31, i64* %add.ptr15.3, align 8
  br label %cleanup.3

if.then.3:                                        ; preds = %while.cond.3
  %add.ptr.3 = getelementptr inbounds i64, i64* %curr.1.2, i64 1
  %32 = load i64, i64* %add.ptr.3, align 8
  %33 = inttoptr i64 %32 to i64*
  %cmp1.3 = icmp eq i64* %33, null
  br i1 %cmp1.3, label %if.then2.3, label %cleanup.3

if.then2.3:                                       ; preds = %if.then.3
  %call.3 = call i8* @malloc(i64 24) #4
  %34 = bitcast i8* %call.3 to i64*
  store i64 %data, i64* %34, align 8
  %add.ptr3.3 = getelementptr inbounds i64, i64* %34, i64 1
  store i64 0, i64* %add.ptr3.3, align 8
  %add.ptr4.3 = getelementptr inbounds i64, i64* %34, i64 2
  store i64 0, i64* %add.ptr4.3, align 8
  %35 = ptrtoint i64* %34 to i64
  %add.ptr5.3 = getelementptr inbounds i64, i64* %curr.1.2, i64 1
  store i64 %35, i64* %add.ptr5.3, align 8
  br label %cleanup.3

cleanup.3:                                        ; preds = %if.then2.3, %if.then.3, %if.then10.3, %if.then7.3, %if.else.3
  %curr.1.3 = phi i64* [ %curr.1.2, %if.then2.3 ], [ %curr.1.2, %if.then10.3 ], [ %33, %if.then.3 ], [ %29, %if.then7.3 ], [ %curr.1.2, %if.else.3 ]
  %cleanup.dest.slot.0.3 = phi i32 [ 1, %if.then2.3 ], [ 1, %if.then10.3 ], [ 2, %if.then.3 ], [ 2, %if.then7.3 ], [ 1, %if.else.3 ]
  %retval.1.3 = phi i64 [ 1, %if.then2.3 ], [ 1, %if.then10.3 ], [ %retval.1.2, %if.then.3 ], [ %retval.1.2, %if.then7.3 ], [ 0, %if.else.3 ]
  %cond.3 = icmp eq i32 %cleanup.dest.slot.0.3, 2
  br i1 %cond.3, label %while.cond, label %cleanup19, !llvm.loop !4
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: allocsize(0)
declare i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind ssp uwtable
define i64* @adjust(i64* %node) #0 {
entry:
  %add.ptr = getelementptr inbounds i64, i64* %node, i64 1
  %0 = load i64, i64* %add.ptr, align 8
  %1 = inttoptr i64 %0 to i64*
  %cmp = icmp eq i64* %1, null
  br i1 %cmp, label %if.then, label %while.cond.preheader

while.cond.preheader:                             ; preds = %entry
  %add.ptr21 = getelementptr inbounds i64, i64* %1, i64 2
  %2 = load i64, i64* %add.ptr21, align 8
  %3 = inttoptr i64 %2 to i64*
  %cmp32 = icmp ne i64* %3, null
  br i1 %cmp32, label %while.body.lr.ph, label %while.end

while.body.lr.ph:                                 ; preds = %while.cond.preheader
  br label %while.body

if.then:                                          ; preds = %entry
  %add.ptr1 = getelementptr inbounds i64, i64* %node, i64 2
  %4 = load i64, i64* %add.ptr1, align 8
  %5 = inttoptr i64 %4 to i64*
  br label %cleanup

while.body:                                       ; preds = %while.body.3, %while.body.lr.ph
  %rightmost.03 = phi i64* [ %1, %while.body.lr.ph ], [ %20, %while.body.3 ]
  %add.ptr4 = getelementptr inbounds i64, i64* %rightmost.03, i64 2
  %6 = load i64, i64* %add.ptr4, align 8
  %7 = inttoptr i64 %6 to i64*
  %add.ptr2 = getelementptr inbounds i64, i64* %7, i64 2
  %8 = load i64, i64* %add.ptr2, align 8
  %9 = inttoptr i64 %8 to i64*
  %cmp3 = icmp ne i64* %9, null
  br i1 %cmp3, label %while.body.1, label %while.cond.while.end_crit_edge

while.cond.while.end_crit_edge:                   ; preds = %while.body.3, %while.body.2, %while.body.1, %while.body
  %split = phi i64* [ %7, %while.body ], [ %12, %while.body.1 ], [ %16, %while.body.2 ], [ %20, %while.body.3 ]
  %split4 = phi i64* [ %rightmost.03, %while.body ], [ %7, %while.body.1 ], [ %12, %while.body.2 ], [ %16, %while.body.3 ]
  br label %while.end

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader
  %rightmost.0.lcssa = phi i64* [ %split, %while.cond.while.end_crit_edge ], [ %1, %while.cond.preheader ]
  %parent.0.lcssa = phi i64* [ %split4, %while.cond.while.end_crit_edge ], [ null, %while.cond.preheader ]
  %cmp5 = icmp ne i64* %parent.0.lcssa, null
  br i1 %cmp5, label %if.then6, label %cleanup

if.then6:                                         ; preds = %while.end
  %add.ptr7 = getelementptr inbounds i64, i64* %rightmost.0.lcssa, i64 1
  %10 = load i64, i64* %add.ptr7, align 8
  %add.ptr8 = getelementptr inbounds i64, i64* %parent.0.lcssa, i64 2
  store i64 %10, i64* %add.ptr8, align 8
  br label %cleanup

cleanup:                                          ; preds = %while.end, %if.then6, %if.then
  %retval.0 = phi i64* [ %5, %if.then ], [ %rightmost.0.lcssa, %if.then6 ], [ %rightmost.0.lcssa, %while.end ]
  ret i64* %retval.0

while.body.1:                                     ; preds = %while.body
  %add.ptr4.1 = getelementptr inbounds i64, i64* %7, i64 2
  %11 = load i64, i64* %add.ptr4.1, align 8
  %12 = inttoptr i64 %11 to i64*
  %add.ptr2.1 = getelementptr inbounds i64, i64* %12, i64 2
  %13 = load i64, i64* %add.ptr2.1, align 8
  %14 = inttoptr i64 %13 to i64*
  %cmp3.1 = icmp ne i64* %14, null
  br i1 %cmp3.1, label %while.body.2, label %while.cond.while.end_crit_edge

while.body.2:                                     ; preds = %while.body.1
  %add.ptr4.2 = getelementptr inbounds i64, i64* %12, i64 2
  %15 = load i64, i64* %add.ptr4.2, align 8
  %16 = inttoptr i64 %15 to i64*
  %add.ptr2.2 = getelementptr inbounds i64, i64* %16, i64 2
  %17 = load i64, i64* %add.ptr2.2, align 8
  %18 = inttoptr i64 %17 to i64*
  %cmp3.2 = icmp ne i64* %18, null
  br i1 %cmp3.2, label %while.body.3, label %while.cond.while.end_crit_edge

while.body.3:                                     ; preds = %while.body.2
  %add.ptr4.3 = getelementptr inbounds i64, i64* %16, i64 2
  %19 = load i64, i64* %add.ptr4.3, align 8
  %20 = inttoptr i64 %19 to i64*
  %add.ptr2.3 = getelementptr inbounds i64, i64* %20, i64 2
  %21 = load i64, i64* %add.ptr2.3, align 8
  %22 = inttoptr i64 %21 to i64*
  %cmp3.3 = icmp ne i64* %22, null
  br i1 %cmp3.3, label %while.body, label %while.cond.while.end_crit_edge, !llvm.loop !6
}

; Function Attrs: nounwind ssp uwtable
define i64 @remove(i64* %root, i64 %data) #0 {
entry:
  %0 = load i64, i64* %root, align 8
  %cmp = icmp eq i64 %0, %data
  br i1 %cmp, label %cleanup24, label %while.cond.preheader

while.cond.preheader:                             ; preds = %entry
  br label %while.cond

while.cond:                                       ; preds = %while.cond.backedge, %while.cond.preheader
  %curr.0 = phi i64* [ %root, %while.cond.preheader ], [ %curr.1, %while.cond.backedge ]
  %retval.0 = phi i64 [ 0, %while.cond.preheader ], [ %retval.1, %while.cond.backedge ]
  %1 = load i64, i64* %curr.0, align 8
  %cmp1 = icmp ugt i64 %1, %data
  br i1 %cmp1, label %if.then2, label %if.else

if.then2:                                         ; preds = %while.cond
  %add.ptr = getelementptr inbounds i64, i64* %curr.0, i64 1
  %2 = load i64, i64* %add.ptr, align 8
  %3 = inttoptr i64 %2 to i64*
  %cmp3 = icmp eq i64* %3, null
  br i1 %cmp3, label %cleanup, label %if.end5

if.end5:                                          ; preds = %if.then2
  %4 = load i64, i64* %3, align 8
  %cmp6 = icmp eq i64 %4, %data
  br i1 %cmp6, label %if.then7, label %cleanup

if.then7:                                         ; preds = %if.end5
  %call = call i64* @adjust(i64* %3)
  %5 = ptrtoint i64* %call to i64
  %add.ptr8 = getelementptr inbounds i64, i64* %curr.0, i64 1
  store i64 %5, i64* %add.ptr8, align 8
  %6 = bitcast i64* %3 to i8*
  call void @free(i8* %6)
  br label %cleanup

if.else:                                          ; preds = %while.cond
  %cmp10 = icmp ult i64 %1, %data
  br i1 %cmp10, label %if.then11, label %cleanup

if.then11:                                        ; preds = %if.else
  %add.ptr12 = getelementptr inbounds i64, i64* %curr.0, i64 2
  %7 = load i64, i64* %add.ptr12, align 8
  %8 = inttoptr i64 %7 to i64*
  %cmp13 = icmp eq i64* %8, null
  br i1 %cmp13, label %cleanup, label %if.end15

if.end15:                                         ; preds = %if.then11
  %9 = load i64, i64* %8, align 8
  %cmp16 = icmp eq i64 %9, %data
  br i1 %cmp16, label %if.then17, label %cleanup

if.then17:                                        ; preds = %if.end15
  %call18 = call i64* @adjust(i64* %8)
  %10 = ptrtoint i64* %call18 to i64
  %add.ptr19 = getelementptr inbounds i64, i64* %curr.0, i64 2
  store i64 %10, i64* %add.ptr19, align 8
  %11 = bitcast i64* %8 to i8*
  call void @free(i8* %11)
  br label %cleanup

cleanup:                                          ; preds = %if.else, %if.end15, %if.then11, %if.end5, %if.then2, %if.then17, %if.then7
  %curr.1 = phi i64* [ %curr.0, %if.then7 ], [ %curr.0, %if.then17 ], [ %curr.0, %if.then2 ], [ %3, %if.end5 ], [ %curr.0, %if.then11 ], [ %8, %if.end15 ], [ %curr.0, %if.else ]
  %cleanup.dest.slot.0 = phi i32 [ 1, %if.then7 ], [ 1, %if.then17 ], [ 1, %if.then2 ], [ 2, %if.end5 ], [ 1, %if.then11 ], [ 2, %if.end15 ], [ 0, %if.else ]
  %retval.1 = phi i64 [ 1, %if.then7 ], [ 1, %if.then17 ], [ 0, %if.then2 ], [ %retval.0, %if.end5 ], [ 0, %if.then11 ], [ %retval.0, %if.end15 ], [ %retval.0, %if.else ]
  switch i32 %cleanup.dest.slot.0, label %cleanup24.loopexit [
    i32 0, label %while.cond.backedge
    i32 2, label %while.cond.backedge
  ]

while.cond.backedge:                              ; preds = %cleanup, %cleanup
  br label %while.cond

cleanup24.loopexit:                               ; preds = %cleanup
  %retval.2.ph = phi i64 [ %retval.1, %cleanup ]
  br label %cleanup24

cleanup24:                                        ; preds = %cleanup24.loopexit, %entry
  %retval.2 = phi i64 [ 0, %entry ], [ %retval.2.ph, %cleanup24.loopexit ]
  ret i64 %retval.2
}

declare void @free(i8*) #3

; Function Attrs: nounwind ssp uwtable
define void @traverse(i64* %node) #0 {
entry:
  %cmp = icmp eq i64* %node, null
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %0 = load i64, i64* %node, align 8
  %add.ptr = getelementptr inbounds i64, i64* %node, i64 1
  %1 = load i64, i64* %add.ptr, align 8
  %2 = inttoptr i64 %1 to i64*
  %add.ptr1 = getelementptr inbounds i64, i64* %node, i64 2
  %3 = load i64, i64* %add.ptr1, align 8
  %4 = inttoptr i64 %3 to i64*
  call void @traverse(i64* %2)
  call void @write(i64 %0)
  call void @traverse(i64* %4)
  br label %return

return:                                           ; preds = %entry, %if.end
  ret void
}

declare void @write(i64) #3

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %call = call i8* @malloc(i64 24) #4
  %0 = bitcast i8* %call to i64*
  %call1 = call i64 (...) @read()
  store i64 %call1, i64* %0, align 8
  %add.ptr = getelementptr inbounds i64, i64* %0, i64 1
  store i64 0, i64* %add.ptr, align 8
  %add.ptr2 = getelementptr inbounds i64, i64* %0, i64 2
  store i64 0, i64* %add.ptr2, align 8
  %call3 = call i64 (...) @read()
  %cmp1 = icmp ult i64 0, %call3
  br i1 %cmp1, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %1 = add i64 %call3, -1
  %xtraiter = and i64 %call3, 3
  %2 = icmp ult i64 %1, 3
  br i1 %2, label %for.cond.for.end_crit_edge.unr-lcssa, label %for.body.lr.ph.new

for.body.lr.ph.new:                               ; preds = %for.body.lr.ph
  %unroll_iter = sub i64 %call3, %xtraiter
  br label %for.body

for.body:                                         ; preds = %for.inc.3, %for.body.lr.ph.new
  %i.02 = phi i64 [ 0, %for.body.lr.ph.new ], [ %inc.3, %for.inc.3 ]
  %niter = phi i64 [ %unroll_iter, %for.body.lr.ph.new ], [ %niter.nsub.3, %for.inc.3 ]
  %call4 = call i64 (...) @read()
  %call5 = call i64 (...) @read()
  %cmp6 = icmp eq i64 %call4, 0
  br i1 %cmp6, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %call7 = call i64 @insert(i64* %0, i64 %call5)
  br label %for.inc

if.else:                                          ; preds = %for.body
  %call8 = call i64 @remove(i64* %0, i64 %call5)
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else
  %inc = add nuw nsw i64 %i.02, 1
  %niter.nsub = sub i64 %niter, 1
  %call4.1 = call i64 (...) @read()
  %call5.1 = call i64 (...) @read()
  %cmp6.1 = icmp eq i64 %call4.1, 0
  br i1 %cmp6.1, label %if.then.1, label %if.else.1

for.cond.for.end_crit_edge.unr-lcssa.loopexit:    ; preds = %for.inc.3
  %i.02.unr.ph = phi i64 [ %inc.3, %for.inc.3 ]
  br label %for.cond.for.end_crit_edge.unr-lcssa

for.cond.for.end_crit_edge.unr-lcssa:             ; preds = %for.cond.for.end_crit_edge.unr-lcssa.loopexit, %for.body.lr.ph
  %i.02.unr = phi i64 [ 0, %for.body.lr.ph ], [ %i.02.unr.ph, %for.cond.for.end_crit_edge.unr-lcssa.loopexit ]
  %lcmp.mod = icmp ne i64 %xtraiter, 0
  br i1 %lcmp.mod, label %for.body.epil.preheader, label %for.cond.for.end_crit_edge

for.body.epil.preheader:                          ; preds = %for.cond.for.end_crit_edge.unr-lcssa
  br label %for.body.epil

for.body.epil:                                    ; preds = %for.inc.epil, %for.body.epil.preheader
  %i.02.epil = phi i64 [ %i.02.unr, %for.body.epil.preheader ], [ %inc.epil, %for.inc.epil ]
  %epil.iter = phi i64 [ %xtraiter, %for.body.epil.preheader ], [ %epil.iter.sub, %for.inc.epil ]
  %call4.epil = call i64 (...) @read()
  %call5.epil = call i64 (...) @read()
  %cmp6.epil = icmp eq i64 %call4.epil, 0
  br i1 %cmp6.epil, label %if.then.epil, label %if.else.epil

if.else.epil:                                     ; preds = %for.body.epil
  %call8.epil = call i64 @remove(i64* %0, i64 %call5.epil)
  br label %for.inc.epil

if.then.epil:                                     ; preds = %for.body.epil
  %call7.epil = call i64 @insert(i64* %0, i64 %call5.epil)
  br label %for.inc.epil

for.inc.epil:                                     ; preds = %if.then.epil, %if.else.epil
  %inc.epil = add i64 %i.02.epil, 1
  %cmp.epil = icmp ult i64 %inc.epil, %call3
  %epil.iter.sub = sub i64 %epil.iter, 1
  %epil.iter.cmp = icmp ne i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %for.body.epil, label %for.cond.for.end_crit_edge.epilog-lcssa, !llvm.loop !7

for.cond.for.end_crit_edge.epilog-lcssa:          ; preds = %for.inc.epil
  br label %for.cond.for.end_crit_edge

for.cond.for.end_crit_edge:                       ; preds = %for.cond.for.end_crit_edge.unr-lcssa, %for.cond.for.end_crit_edge.epilog-lcssa
  br label %for.end

for.end:                                          ; preds = %for.cond.for.end_crit_edge, %entry
  call void @traverse(i64* %0)
  ret i32 0

if.else.1:                                        ; preds = %for.inc
  %call8.1 = call i64 @remove(i64* %0, i64 %call5.1)
  br label %for.inc.1

if.then.1:                                        ; preds = %for.inc
  %call7.1 = call i64 @insert(i64* %0, i64 %call5.1)
  br label %for.inc.1

for.inc.1:                                        ; preds = %if.then.1, %if.else.1
  %inc.1 = add nuw nsw i64 %inc, 1
  %niter.nsub.1 = sub i64 %niter.nsub, 1
  %call4.2 = call i64 (...) @read()
  %call5.2 = call i64 (...) @read()
  %cmp6.2 = icmp eq i64 %call4.2, 0
  br i1 %cmp6.2, label %if.then.2, label %if.else.2

if.else.2:                                        ; preds = %for.inc.1
  %call8.2 = call i64 @remove(i64* %0, i64 %call5.2)
  br label %for.inc.2

if.then.2:                                        ; preds = %for.inc.1
  %call7.2 = call i64 @insert(i64* %0, i64 %call5.2)
  br label %for.inc.2

for.inc.2:                                        ; preds = %if.then.2, %if.else.2
  %inc.2 = add nuw nsw i64 %inc.1, 1
  %niter.nsub.2 = sub i64 %niter.nsub.1, 1
  %call4.3 = call i64 (...) @read()
  %call5.3 = call i64 (...) @read()
  %cmp6.3 = icmp eq i64 %call4.3, 0
  br i1 %cmp6.3, label %if.then.3, label %if.else.3

if.else.3:                                        ; preds = %for.inc.2
  %call8.3 = call i64 @remove(i64* %0, i64 %call5.3)
  br label %for.inc.3

if.then.3:                                        ; preds = %for.inc.2
  %call7.3 = call i64 @insert(i64* %0, i64 %call5.3)
  br label %for.inc.3

for.inc.3:                                        ; preds = %if.then.3, %if.else.3
  %inc.3 = add i64 %inc.2, 1
  %niter.nsub.3 = sub i64 %niter.nsub.2, 1
  %niter.ncmp.3 = icmp ne i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %for.body, label %for.cond.for.end_crit_edge.unr-lcssa.loopexit, !llvm.loop !8
}

declare i64 @read(...) #3

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
