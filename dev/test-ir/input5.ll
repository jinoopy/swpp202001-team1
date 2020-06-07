define i32 @main() {
entry:
    %a = alloca i32
    %b = add i32 1, 1
    %c = add i64 1, 1
    %d = add i32 1, 1
    br label %BB1

BB1:
    %e = phi i32 [%d, %entry], [%k, %BB2]
    %f = phi i64 [%c, %entry], [%l, %BB2]
    %g = phi i32 [%b, %entry], [%i, %BB2]
    %h = phi i32* [%a, %entry], [%j, %BB2]
    br label %BB2

BB2:
    %i = add i32 2, 2
    %j = call i32* @pointer()
    %k = add i32 2, 2
    %l = add i64 2, 2
    br label %BB1
}

declare i32* @pointer()