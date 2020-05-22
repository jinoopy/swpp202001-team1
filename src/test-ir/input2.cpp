bool foo(int a) {
    int sum = 0;
    for(int i=0; i<a; i++) {
        sum += i;
    }
    return (sum>0);
}

int foo2(int n) {
    int a = 5;
    int result = 0;
    for(int i=0; i<n; i++) {
        if(foo(a)) {
            result += i;
        }
    }
    return result;
}