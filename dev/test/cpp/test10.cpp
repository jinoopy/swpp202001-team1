int *foo(int n, int *m) {
    for(int i=1; i<n; i++) { //loop
        m[i-1] = m[i] & 7; //LSB bitmask
    }
    return m;
}