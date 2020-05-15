define i32 @main() {
  %a = call i32 @value()
  %b = call i32 @value()
  %c = call i32 @value()
  %d = call i32 @value()
  %e = call i32 @foo(i32 %a, i32 %b, i32 %c, i32 %d)
  %f = call i32 @foo(i32 %d, i32 %c, i32 %b, i32 %a) ;alive: a, b, c, d, e : max-clique
  %g = add i32 %e, %f
  ret i32 %g
}

declare i32 @value()
declare i32 @foo(i32, i32, i32, i32)