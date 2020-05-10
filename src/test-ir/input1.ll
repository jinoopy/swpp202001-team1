define i32 @main() {
    %m0.0 = call i8* @malloc(i64 4)
    %m0.1 = bitcast i32* %m0.0
    store i32 0, i32* %m0.1
    call @foo(%m0.1);
}

define void @foo(i32* %ptr) {
    %r0 = load i32 %ptr
    %r1 = add i32 %0, 3
    store i32 %r1, i32* %ptr
}