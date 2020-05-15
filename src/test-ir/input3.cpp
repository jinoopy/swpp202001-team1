void f() {
  short a[100];
  unsigned long long i, n = 100;
  for(i=0; i<n;) {
    a[i] = i % 3;
    i++;
    a[i] = i % 3;
    i++;
    a[i] = i % 3;
    i++;
    a[i] = i % 3;
    i++;
  }
}
