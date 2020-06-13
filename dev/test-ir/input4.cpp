#include <stdlib.h>

int* foo(int* a) {
    a = (int*)malloc(sizeof(int) * 10);
    return a+5;
}