// Naive floating-point implementation of Loeffler's algorithm for 8-input Discrete Cosine Transform
// All cos and sqrt operations can be pre-computed for better optimization
#include <stdio.h>
#define _USE_MATH_DEFINES
#include <math.h>

void reflector(double *a, double *b) {

    double temp_a = *a + *b;
    double temp_b = *a - *b;

    *a = temp_a;
    *b = temp_b;
}

// The Rotator function can be impemented with butterfly operations in hardware.  
// Here the simplified rotator function has been implemented with reduced multiplications
void trotator(double *a, double *b, int k, int n) { 
    double o1, o2;
    double rad = (n * M_PI) / 16;
    double c = k * cos(rad) * (*a + *b); 
    
    o1 = (k * sin(rad) - k * cos(rad)) * *b + c; 
    o2 = -(k * sin(rad) + k * cos(rad)) * *a + c;

    *a = o1; 
    *b = o2;
}

int main() {
    
    // Input array for 1D-dct 
    double x[] = {1, 2, 3, 4, 5, 6, 7, 8};

    // Stage 1: 
    int i;
    for (i = 8; i > 4; i--) {
        reflector(&x[8-i], &x[i-1]);
    }

    // Stage 2: 
    reflector(&x[0], &x[3]);
    reflector(&x[1], &x[2]);
    trotator(&x[4], &x[7], 1, 3);
    trotator(&x[5], &x[6], 1, 1); 


    // Stage 3:
    reflector(&x[0], &x[1]);
    trotator(&x[2], &x[3], sqrt(2), 6);
    reflector(&x[4], &x[6]); 
    reflector(&x[7], &x[5]);
   
    // Stage 4:
    reflector(&x[7], &x[4]);
    double temp = sqrt(2) * x[5];
    x[5] = temp;
    temp = sqrt(2) * x[6];
    x[6] = temp;

    // Print final DCT product with attached final scale factor,
    // prints reordered to match input sequence ordering 
    printf("%.3f\t", x[0] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", x[7] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", x[2] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", x[5] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", x[1] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", x[6] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", x[3] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", x[4] * 1 / (2 * sqrt(2)));
    printf("\n"); 

    // keep in mind that after loeffler's algorithm is done, the output array X has shifted:
    // x[0] = X[0], x[1] = X[4], x[2] = X[2], x[3] = X[6], x[4] = X[7], x[5] = X[3], x[6] = X[5], x[7] = X[1] 
}
