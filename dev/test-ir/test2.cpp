#include <stdlib.h>

int f(int n, int *arr) {
	for(int i = 0; i < n; i++) {
		arr[i] = i * i;
	}
	int *result = (int *)malloc(1 * sizeof(int));
	result[0] = 0;
	for(int i = 0; i < n; i++) {
		result[0] += arr[i] / i;
	}
	return result[0];
}