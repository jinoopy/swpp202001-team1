int foo(int n) {
    int a = 3;
    int b = 2;
    int c = a + b;
    n = n + c;
    n = n + n;
    return n;
}