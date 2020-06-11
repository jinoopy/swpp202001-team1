@GV = global i32 0, align 4
@GV2 = global i32 1, align 4

define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 10, i32* @GV2, align 4
  %gvtest = load i32, i32* @GV2, align 4
  %2 = call i32 @foo()
  ret i32 %2
}

define i32 @foo() #0 {
  %1 = load i32, i32* @GV, align 4
  %2 = mul nsw i32 2, %1
  ret i32 %2
}

declare i8* @malloc(i64)

declare i64 @read(...) #2

declare void @write(i64) #2