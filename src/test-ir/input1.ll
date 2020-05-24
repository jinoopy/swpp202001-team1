define i8 @main() #0 {
  %ma0 = call i8* @malloc(i64 4)
  store i8 1, i8* %ma0
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = load i8, i8* %ma0
  ret i8 %2
}

declare i8* @malloc(i64)