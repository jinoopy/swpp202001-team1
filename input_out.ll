; ModuleID = 'input_out.ll'
source_filename = "input.ll"

@gv = global i32 0

define i32 @main(i32 %arg) {
  %alloca_ma0 = alloca i32
  %x = load i32, i32* %alloca_ma0
  %y = add i32 %x, %x
  ret i32 %y
}

declare i8* @malloc(i64)
