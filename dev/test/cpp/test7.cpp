int foo(int n) {
    int a = 15;
    int b = 63;
    int c = a & n; //LSB bitmask
    c &= b;        //LSB bitmask, redundant op
    int res = (c << 0) + c; //reg move << , shift to MUL
    return res;
}