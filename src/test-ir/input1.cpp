int main() {
  int a[1024];
  unsigned long n = 1024;
  int count = 0;
  for(unsigned long i=0; i<n;) {
    a[i] = i * i;
    i++;
    a[i] = i * i;
    i++;
    a[i] = i * i;
    i++;
    a[i] = i * i;
    i++;
  }
  for(unsigned long i=0; i<n; ) {
    count += a[i];
    i++;
    count += a[i];
    i++;
    count += a[i];
    i++;
    count += a[i];
    i++;
  }
  return count;
}
