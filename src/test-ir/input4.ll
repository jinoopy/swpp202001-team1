
;Tests when no bitcast operation is done.
;Tests when no store operation is done.

define i32 @main() {
    %m0.0 = call i8* @malloc(i64 4)
    %ret = call i32 @foo(i8* %m0.0);
    ret i32 %ret
}

define i32 @foo(i8* %ptr) {
    %r0 = load i8, i8* %ptr
    %r1 = add i8 %r0, 3
    store i8 %r1, i8* %ptr
    %r2 = sext i8 %r0 to i32
    ret i32 %r2
}

define i8* @malloc(i64 %size.malloc) {
    %ptr.malloc = inttoptr i64 0 to i8*
    ret i8* %ptr.malloc
}