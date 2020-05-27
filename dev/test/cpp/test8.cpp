int foo(int n) {
    int a = (n > 10) || (n < 12); //1
    int b = (n == 1) && (n == 5); //0
    int c = a ^ b; //1
    int res = n & (c + 2); //LSB bitmask ? 
    res &= 7; //LSB bitmask, redundant op
    return res;
}