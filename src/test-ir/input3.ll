@GV = global i32 3, align 4

define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 2, i32* @GV, align 4
  %2 = load i32, i32* @GV, align 4
  ret i32 %2
}