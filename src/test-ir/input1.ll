;Tests the basic case.

define i32 @main() {
    %m0.0 = call i8* @malloc(i64 4)
    %m0.1 = bitcast i8* %m0.0 to i32*
    store i32 0, i32* %m0.1
    %ret = call i32 @foo(i32* %m0.1);
    ret i32 %ret
}

define i32 @foo(i32* %ptr) {
    %r0 = load i32, i32* %ptr
    %r1 = add i32 %r0, 3
    store i32 %r1, i32* %ptr
    ret i32 %r1
}

define i8* @malloc(i64 %size.malloc) {
    %ptr.malloc = inttoptr i64 0 to i8*
    ret i8* %ptr.malloc
}