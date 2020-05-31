int *foo(int n, int *m) {
  int i = 0;
  while((n & (n+1)) == 0) {
    m[i] &= n; //LSB bitmask ?
    n >>= 1; //shift to DIV
    i++;
  }
  return m;
}