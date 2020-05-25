; ModuleID = 'input.ll'
source_filename = "input.ll"

define dso_local i32 @main() {
  br label %1

1:                                                ; preds = %11, %0
  %.02 = phi i32 [ 0, %0 ], [ %.1, %11 ]
  %.01 = phi i32 [ 0, %0 ], [ %12, %11 ]
  %2 = icmp slt i32 %.01, 100
  br i1 %2, label %3, label %13

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %8, %3
  %.1 = phi i32 [ %.02, %3 ], [ %7, %8 ]
  %.0 = phi i32 [ 0, %3 ], [ %9, %8 ]
  %5 = icmp slt i32 %.0, 100
  br i1 %5, label %6, label %10

6:                                                ; preds = %4
  %7 = add nsw i32 %.1, %.0
  br label %8

8:                                                ; preds = %6
  %9 = add nsw i32 %.0, 1
  br label %4

10:                                               ; preds = %4
  br label %11

11:                                               ; preds = %10
  %12 = add nsw i32 %.01, 1
  br label %1

13:                                               ; preds = %1
  ret i32 %.02
}
