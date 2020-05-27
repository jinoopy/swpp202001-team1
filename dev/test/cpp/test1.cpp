int foo(int n) {
    int res = n + n; //shift to MUL
    res += n * 2; //shift to MUL
    return res;
}