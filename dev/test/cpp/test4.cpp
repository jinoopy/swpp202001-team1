int foo(int n) {
    int res = n ^ 0; //reg move ^
    int a = 3;  //11
    int b = 31; //11111
    int c = -1; //1...1
    res &= a; //LSB bitmask
    res &= b; //LSB bitmask, redundant op
    res &= c; //reg move & , redundant op
    return res;
}