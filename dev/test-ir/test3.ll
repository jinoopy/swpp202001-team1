define i32 @main() #0 {
  %ma0 = call i8* @malloc(i64 4)
  %bc0 = bitcast i8* %ma0 to i32*
  store i32 1, i32* %bc0
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = load i32, i32* %bc0
  ret i32 %2
}

declare i8* @malloc(i64) 