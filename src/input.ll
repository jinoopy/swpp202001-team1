
@GV = global i32 2, align 4

define i32 @main() #0 {
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %a, align 4
  %c = call i32 @foo()
  store i32 %c, i32* %b, align 4
  %d = load i32, i32* @GV, align 4
  %e = load i32, i32* %b, align 4
  %f = add nsw i32 %d, %e
  ret i32 %f
}

define i32 @foo() #0 {
  %g = load i32, i32* @GV, align 4
  %h = load i32, i32* @GV, align 4
  %i = mul nsw i32 %g, %h
  ret i32 %i
}
