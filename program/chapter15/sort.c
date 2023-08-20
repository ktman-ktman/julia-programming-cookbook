#include <stddef.h>

void sort(double *xs, size_t n)
{
    for (size_t i = 0; i < n; i++) {
        for (size_t j = 0; j < n; j++) {
            if (xs[i] < xs[j]) {
                // swap x[i] and x[j]
                double tmp = xs[i];
                xs[i] = xs[j];
                xs[j] = tmp;
            }
        }
    }
}