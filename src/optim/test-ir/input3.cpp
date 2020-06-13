int foo(int i, int j, int** arr) {
    int brr[10] = {1, 4, 6, 3, 5};
    return arr[brr[i]][brr[j]];
}