int foo(int n) {
    int result = 0;
    int i = 0;
    while(1) {
        if(i>=n) break;
        result++;
        i++;
    }
    return result;
}