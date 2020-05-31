int foo(int n, int m) {
    int res = n + 0; //reg move +
    int a = m >> 0; //reg move >>
    int b = m | 0; //reg move |
    res *= a + b; //shift to MUL ?
    res += m;
    return res;
}