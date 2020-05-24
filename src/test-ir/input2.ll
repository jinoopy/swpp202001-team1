declare i32* @malloc(i64)

define i32 @main() #0 {
  %ma0 = call i32* @malloc(i64 4)
  %ptr = getelementptr i32, i32* %ma0
  store i32 2, i32* %ma0
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %3 = call i32 @foo(i32* %ma0)
  store i32 %3, i32* %2, align 4
  %4 = load i32, i32* %ma0, align 4
  %5 = load i32, i32* %2, align 4
  %6 = add nsw i32 %4, %5
  ret i32 %6
}

define i32 @foo(i32* %GV) #0 { 
  %1 = load i32, i32* %GV, align 4 
  %2 = load i32, i32* %GV, align 4 
  %3 = mul nsw i32 %1, %2
  ret i32 %3
}