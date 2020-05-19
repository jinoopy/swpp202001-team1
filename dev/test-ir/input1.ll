define i32 @main() {
entry:
  %a = call i32 @anyValue()
  %b = call i32 @anyValue()
  %c = call i32 @anyValue()
  %cmp = icmp eq i32 %a, %b
  br i1 %cmp, label %BB1, label %BB2
BB1:
  %d = call i32 @anyValue()
  %e = call i32 @anyValue()
  %f = call i32 @foo(i32 %b, i32 %c, i32 %d, i32 %e)
  br label %BB2
BB2:
  %g = phi i32 [%d, %BB1], [0, %entry]
  %h = phi i32 [%e, %BB1], [0, %entry]
  %i = call i32 @foo(i32 %a, i32 %b, i32 %g, i32 %h)
  %j = call i32 @foo(i32 %c, i32 %a, i32 %g, i32 %h)
  ret i32 0
}

declare i32 @anyValue()
declare i32 @foo(i32, i32, i32, i32)