; ModuleID = 'test1_out.ll'
source_filename = "test1.ll"

define i32 @main() local_unnamed_addr {
  ret i32 1
}

declare i8* @malloc(i64) local_unnamed_addr

declare i8* @malloc.1(i64)
