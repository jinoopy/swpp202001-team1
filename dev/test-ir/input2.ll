@GV1 = global i32 0
@GV2 = global i32* getelementptr (i32, i32* @GV1)

declare i8* @malloc(i64)

define i32 @main() #0 {
  %ma0 = call i8* @malloc(i64 4)
  %bc0 = bitcast i8* %ma0 to i32*
  store i32 2, i32* %bc0
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %3 = call i32 @foo(i32* @GV1,i32* %bc0)
  store i32 %3, i32* %2, align 4
  %4 = load i32, i32* %bc0, align 4
  %5 = load i32, i32* %2, align 4
  %6 = add nsw i32 %4, %5
  ret i32 %6
}

define i32 @foo(i32* %arg, i32* %GV) #0 { 
  store i32* %GV, i32** @GV2
  %1 = load i32, i32* %GV, align 4 
  %2 = load i32, i32* %GV, align 4 
  %3 = mul nsw i32 %1, %2
  %4 = call i32 @foo(i32* @GV1,i32* %GV)
  ret i32 %3
}