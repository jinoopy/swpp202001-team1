int *foo(int n, int *m) {
  int i = 0;
  while((n & (n+1)) == 0) {
    m[i] &= n;
    n >>= 1;
    i++;
  }
  return m;
}