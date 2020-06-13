define i32 @main() #0 {
  %1 = call i8* @malloc(i64 4)
  %2 = call i8* @malloc(i64 4)
  %3 = bitcast i8* %1 to i32*
  %4 = bitcast i8* %2 to i32*
  store i32 1, i32* %3
  store i32 2, i32* %4
  %5 = load i32, i32* %3
  %6 = load i32, i32* %4
  %cond = icmp eq i32 %5, %6
  br i1 %cond, label %bb_true, label %bb_false

bb_true:
  %7 = alloca i32, align 4
  %8 = load i32, i32* %4
  store i32 0, i32* %7, align 4
  store i32 %8, i32* %3
  br label %bb_ret

bb_false:
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %5, i32* %9, align 4
  %11 = load i32, i32* %3
  store i32 %11, i32* %10, align 4
  br label %bb_ret

bb_ret:
  ret i32 0

}

declare i8* @malloc(i64) 