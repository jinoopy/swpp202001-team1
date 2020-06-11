; ModuleID = 'test_g2m.ll'
source_filename = "test_g2m.ll"

@GV = global i32 0, align 4
@GV2 = global i32 1, align 4

define i32 @main() {
  %ma1 = call i8* @malloc(i64 4)
  %gv1 = bitcast i8* %ma1 to i32*
  store i32 1, i32* %gv1
  %ma0 = call i8* @malloc(i64 4)
  %gv0 = bitcast i8* %ma0 to i32*
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 10, i32* %gv1, align 4
  %gvtest = load i32, i32* %gv1, align 4
  %2 = call i32 @foo.1(i32* %gv0, i32* %gv1)
  ret i32 %2
}

declare i8* @malloc(i64)

define i32 @foo.1(i32* %gv0, i32* %gv1) {
  %1 = load i32, i32* %gv0, align 4
  %2 = mul nsw i32 2, %1
  ret i32 %2
}
