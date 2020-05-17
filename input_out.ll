; ModuleID = 'input.ll'
source_filename = "input.ll"

; The Loop Optimization Pipeline 1 as defined in config.json is applied.

define dso_local i32 @main() {
  br label %1

1:                                                ; preds = %0, %8
  %.015 = phi i32 [ 0, %0 ], [ %9, %8 ]
  %.024 = phi i32 [ 0, %0 ], [ %.1.lcssa, %8 ]
  br label %2

2:                                                ; preds = %1, %4
  %.03 = phi i32 [ 0, %1 ], [ %5, %4 ]
  %.11 = phi i32 [ %.024, %1 ], [ %3, %4 ]
  %3 = add nsw i32 %.11, %.03
  br label %4

4:                                                ; preds = %2
  %5 = add nsw i32 %.03, 1
  %6 = icmp slt i32 %5, 100
  br i1 %6, label %2, label %7

7:                                                ; preds = %4
  %.1.lcssa = phi i32 [ %3, %4 ]
  br label %8

8:                                                ; preds = %7
  %9 = add nsw i32 %.015, 1
  %10 = icmp slt i32 %9, 100
  br i1 %10, label %1, label %11

11:                                               ; preds = %8
  %.02.lcssa = phi i32 [ %.1.lcssa, %8 ]
  ret i32 %.02.lcssa
}
