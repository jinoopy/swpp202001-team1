;Tests recursive functions.

define i32 @main() {
    %m0.0 = call i8* @malloc(i64 4)
    %m0.1 = bitcast i8* %m0.0 to i32*
    store i32 0, i32* %m0.1
    call void @foo(i32 10, i32* %m0.1);
    ret i32 0
}

define void @foo(i32 %n, i32* %ptr) {
    %r0 = load i32, i32* %ptr
    %r1 = add i32 %r0, %n
    store i32 %r1, i32* %ptr
    %n.next = sub i32 %n, 1
    %n.cmp = icmp eq i32 %n.next, 0
    br i1 %n.cmp, label %stop, label %recur
stop:
    ret void
recur:
    call void @foo(i32 %n.next, i32* %ptr)
    ret void
}

define i8* @malloc(i64 %size.malloc) {
    %ptr.malloc = inttoptr i64 0 to i8*
    ret i8* %ptr.malloc
}