int foo(int n) {
    int a, b = 10;
    int result = 0;
    for(int i=0; i<n; i++) {
        a = 2 * b;
        if(a<n) result++;
    }
    return result;
}