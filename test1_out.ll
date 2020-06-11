; ModuleID = 'test1.ll'
source_filename = "test1.ll"

define i32 @main() {
  %alloca_ma0 = alloca i32
  store i32 1, i32* %alloca_ma0
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = load i32, i32* %alloca_ma0
  ret i32 %2
}

declare i8* @malloc(i64)
