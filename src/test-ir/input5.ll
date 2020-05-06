define i32 @main() {
  %a0 = add i32 3, 5
  %b0 = add i32 4, 2
  %c0 = add i32 8, 3
  %d0 = add i32 6, 5
  %e0 = call i32 @foo(i32 %a0, i32 %b0, i32 %c0, i32 %d0)
  %f0 = call i32 @bar(i32 %a0, i32 %c0, i32 %b0, i32 %d0)
  %g0 = add i32 %e0, %f0
  ret i32 %g0
}

define i32 @foo(i32 %a1, i32 %b1, i32 %c1, i32 %d1) {
  %e1 = add i32 %a1, %b1
  %f1 = add i32 %c1, %d1
  %g1 = add i32 %e1, %f1
  %h1 = call i32 @bar(i32 %a1, i32 %b1, i32 %c1, i32 %d1)
  %i1 = add i32 %g1, %h1
  ret i32 %i1
}

define i32 @bar(i32 %a2, i32 %b2, i32 %c2, i32 %d2) {
  %e2 = mul i32 %a2, %b2
  %f2 = mul i32 %c2, %d2
  %g2 = mul i32 %e2, %f2
  ret i32 %g2
}