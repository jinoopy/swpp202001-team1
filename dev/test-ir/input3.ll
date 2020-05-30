declare i8* @malloc(i64)

define i32 @main() #0 {
  %GV = call i8* @malloc(i64 4)
  %bc0 = bitcast i8* %GV to i32*
  store i32 2, i32* %bc0
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 2, i32* %bc0, align 4
  %2 = load i32, i32* %bc0, align 4
  ret i32 %2
}