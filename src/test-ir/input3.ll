declare i32* @malloc(i64)

define i32 @main() #0 {
  %GV = call i32* @malloc(i64 4)
  store i32 2, i32* %GV
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 2, i32* %GV, align 4
  %2 = load i32, i32* %GV, align 4
  ret i32 %2
}