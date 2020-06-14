; ModuleID = '_backend.ll'
source_filename = "test.ll"

define i32 @main(i32 %arg) {
entry:
  switch i32 %arg, label %defa [
    i32 0, label %BB1
    i32 1, label %BB2
  ]

BB1:                                              ; preds = %entry
  ret i32 0

BB2:                                              ; preds = %entry
  ret i32 1

defa:                                             ; preds = %entry
  ret i32 -1
}
