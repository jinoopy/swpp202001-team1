int foo(int n, int m) {
    int a = n<1;
    int b = m>1;
    int res1 = a & b;
    
    bool c = n<2;
    bool d = m>2;
    int res2 = c & d;

    int e = n<3;
    bool f = m>3;
    int res3 = e & f;

    int g = n<4;
    int h = m>4;
    bool res4 = g & h;
    
    bool i = n<5;
    bool j = m>5;
    bool res5 = i & j;

    bool k = n<6;
    int l = m>6;
    bool res6 = k & l;
    
    int res7 = (n<7) & (m>7);
    bool res8 = (n<8) & (m>8);
    int res9 = n & m;
    return res1 + res2 + res3 + res4 + res5 + res6 + res7 + res8 + res9;
}