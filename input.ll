@gv = global i32 0

define i32 @main(i32 %arg) {
  %x = load i32, i32* @gv
  %y = add i32 %x, %x
  ret i32 %y
}

; declare i8* @malloc(i64)