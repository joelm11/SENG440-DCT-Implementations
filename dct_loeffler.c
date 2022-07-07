// All cos and sqrt operations can be pre-computed for better optimization
#include <stdio.h>
#define _USE_MATH_DEFINES
#include <math.h>


void reflector(double *a, double *b) {
    double temp_a = *a + *b;
    // make sure the addition operation is saturated
    if (temp_a > 255) {
        temp_a = 255;
    }
    double temp_b = *a - *b;
    // make sure the subtraction operation is saturated
    if (temp_b  > 255) {
        temp_b = 0;
    }

    *a = temp_a;
    *b = temp_b;
}

// The Rotator function can be impemented with butterfly operations in hardware.
void rotator(double *a, double *b, double k, double n) {
    double c = (n * M_PI) / 16;
    double temp_a = (*a * k * cos(c)) + (*b * k * sin(c));
    // make sure the addition operation is saturated
    if (temp_a > 255) {
        temp_a = 255;
    }
    double temp_b = (*b * k * cos(c)) - (*a * k * sin(c));
    // make sure the subtraction operation is saturated
    if (temp_b < 0) {
        temp_b = 0;
    }

    *a = temp_a;
    *b = temp_b;
}



int main() {
    // the main input array for 1D-dct 
    double x[] = {1,2,3,4,5,6,7,8};

    // stage 1: 
    // Straightforward and should be correct
    int i;
    for (i = 8; i > 4; i--) {
        reflector(&x[8-i], &x[i-1]);
    }

    // stage 2: 
    // Should be correct
    reflector(&x[0], &x[3]);
    reflector(&x[1], &x[2]);
    rotator(&x[4], &x[7], 1, 3);
    rotator(&x[5], &x[6], 1, 1);

    // stage 3:
    // 
    reflector(&x[0], &x[1]);
    rotator(&x[2], &x[3], sqrt(2), 6);
    reflector(&x[4], &x[6]); 
    reflector(&x[7], &x[5]);
   
    // stage 4:
    reflector(&x[7], &x[4]);
    double temp = sqrt(2) * (double) x[5];
    x[5] = temp;
    temp = sqrt(2) * (double) x[6];
    x[6] = temp;
    
    //print result
    for (i = 8; i; i--) {
        printf("x[%d]: %.3f\t", 8-i, x[8-i]);
    }
    printf("\n");
    // keep in mind that after loeffler's algorithm is done, the output array X has shifted:
    // x[0] = X[0], x[1] = X[4], x[2] = X[2], x[3] = X[6], x[4] = X[7], x[5] = X[3], x[6] = X[5], x[7] = X[1] 
}
