;Tests for multiple functions which both call to same function.

define i32 @main() {
    %m0.0 = call i8* @malloc(i64 4)
    %m0.1 = bitcast i8* %m0.0 to i32*
    store i32 5, i32* %m0.1
    %foo = call i32 @foo(i32* %m0.1);
    %bar = call i32 @bar(i32 5, i32* %m0.1);
    %ret = add i32 %foo, %bar
    ret i32 %ret
}

define i32 @foo(i32* %ptr) {
    %r0 = load i32, i32* %ptr
    %r1 = add i32 %r0, 3
    store i32 %r1, i32* %ptr
    %r2 = call i32 @bar(i32 -2, i32* %ptr)
    ret i32 %r1
}

define i32 @bar(i32 %n, i32* %ptr2) {
    %r3 = load i32, i32* %ptr2
    %r4 = mul i32 %r3, %n
    store i32 %r4, i32* %ptr2
    ret i32 %r4
}

define i8* @malloc(i64 %size.malloc) {
    %ptr.malloc = inttoptr i64 0 to i8*
    ret i8* %ptr.malloc
}