int f(int n, int m) {
	int res = 0;
	for(int i=0; i<n; i++) {
		for(int j=0; j<n; j++) {
			res += i * j;
		}
	}
	return res;
}