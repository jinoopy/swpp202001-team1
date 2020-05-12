int main() {
  int a[1024];
  unsigned long long n = 1024, i;
  for(i=0; i<n;) {
    a[i] = i;
    i++;
    a[i] = i;
    i++;
    a[i] = i;
    i++;
    a[i] = i;
    i++;
  }
  for(i=0; i<n/2;) {
    a[i] = a[n-i-1];
	i++;
	a[i] = a[n-i-1];
	i++;
	a[i] = a[n-i-1];
	i++;
	a[i] = a[n-i-1];
	i++;
  }
  return 0;
}
