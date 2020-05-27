int foo(int n, int m) {
  if(n == 63) {
    return m & n; //LSB bitmask (gvn pass required)
  }
  else if(n == -1) {
    return m & n; //reg move & (gvn pass required)
  }
  return 0;
}