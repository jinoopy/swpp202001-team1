@GV = global i32 2, align 4
@arr = global [3 x i32] [i32 1, i32 2, i32 3]

define i32 @main() #0 {
  %idx_0 = getelementptr [3 x i32], [3 x i32]* @arr, i64 0, i64 0
  store i32 10, i32* %idx_0
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %3 = call i32 @foo()
  store i32 %3, i32* %2, align 4
  %4 = load i32, i32* @GV, align 4
  %5 = load i32, i32* %2, align 4
  %6 = add nsw i32 %4, %5
  ret i32 %6
}

define i32 @foo() #0 {
  %1 = load i32, i32* @GV, align 4
  %2 = load i32, i32* @GV, align 4
  %3 = mul nsw i32 %1, %2
  ret i32 %3
}