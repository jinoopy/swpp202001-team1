int foo(int n) {
    int a = n & (n - n - 1); //reg move &
    int b = n >> 2; //shift to DIV
    bool res = (a > 10) & (b < 3 || b == 10); //1bit(boolean) AND
    return res;
}