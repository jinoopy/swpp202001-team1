int foo(int n, int m) {
  if(n == 63) {
    return m & n;
  }
  else if(n == -1) {
    return m & n;
  }
  return 0;
}