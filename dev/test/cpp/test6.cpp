int foo(int n, int m) {
    int a = n - (0 * n); //reg move -
    int b = m << 3; //shift to MUL
    int res = (a<3) & (b>10); //1bit(non-boolean) AND
    return res;
}