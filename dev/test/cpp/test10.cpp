int *foo(int n, int *m) {
    int res;
    for(int i=1; i<n; i++) {
        m[i-1] = m[i] & 7;
    }
    return m;
}