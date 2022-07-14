// All cos and sqrt operations are pre-computed with scale-factors of 2^7 for better optimization
#include <stdio.h>
// pre-computed values for cos with a scale-factor of 2^7
unsigned int c[] = {106, 126, 49};
// pre-computed values for sin with a scale-factor of 2^7
unsigned int s[] = {71, 25, 118};
// pre-computed sqrt value with a scale-factor of 2^7
unsigned int q[] = {128, 181};


void reflector(unsigned int *a, unsigned int *b) {
    
    unsigned int temp_a = *a + *b;
    // make sure the addition operation is saturated
    if (temp_a > 255) {
        temp_a = 255;
    }

    unsigned int temp_b = *a - *b;
    // make sure the subtraction operation is saturated
    if (temp_b  > 255) {
        temp_b = 0;
    }

    *a = temp_a;
    *b = temp_b;
}

// The Rotator function can be impemented with butterfly operations in hardware.
void rotator(unsigned int *a, unsigned int *b, unsigned int k, unsigned int n) {
    
    unsigned int temp_a = ((*a << 7) * q[k] * c[n]) + ((*b << 7) * q[k] * s[n]);
    // make sure the addition operation is saturated
    // 534773760 is 255 * 2^21 which is the current scale factor at this point
    if (temp_a > 534773760) {
        temp_a = 534773760;
    }

    unsigned int temp_b = ((*b << 7) * q[k] * c[n]) - ((*a << 7) * q[k] * s[n]);
    // make sure the subtraction operation is saturated 
    // 534773760 is 255 * 2^21 which is the current scale factor at this point
    if (temp_b > 534773760) {
        temp_b = 0;
    }
    
    *a = (temp_a >> 21);
    *b = (temp_b >> 21);
}



int main() {
    // the main input array for 1D-dct 
    unsigned int x[] = {32,42,57,77,45,22,56,97};
    
    // stage 1:
    int i;
    for (i = 4; i; i--) {
        reflector(&x[4-i], &x[3+i]);
    }

    // print result
    printf("Stage 1:\n\n");
    for (i = 8; i; i--) {
        printf("x[%d]: %u\n", 8-i, x[8-i]);
    }

    // stage 2:
    reflector(&x[0], &x[3]);
    reflector(&x[1], &x[2]);
    rotator(&x[4], &x[7], 0, 0);
    rotator(&x[5], &x[6], 0, 1);

    // print result
    printf("Stage 2:\n\n");
    for (i = 8; i; i--) {
        printf("x[%d]: %u\n", 8-i, x[8-i]);
    }

    // stage 3:
    reflector(&x[0], &x[1]);
    rotator(&x[2], &x[3], 1, 2);
    reflector(&x[4], &x[6]); 
    reflector(&x[7], &x[5]);
   
    // print result
    printf("Stage 3:\n\n");
    for (i = 8; i; i--) {
        printf("x[%d]: %u\n", 8-i, x[8-i]);
    }

    // stage 4:
    reflector(&x[7], &x[4]);
    unsigned int temp = q[1] * (x[5] << 7);
    // make sure the multiplication operation is saturated
    // 4177920 is 255 * 2^14 which is the current scale factor at this point
    if (temp > 4177920) {
        temp = 4177920;
    }
    x[5] = (temp >> 14);
    temp = q[1] * (x[6] << 7);
    // make sure the multiplication operation is saturated
    // 4177920 is 255 * 2^14 which is the current scale factor at this point
    if (temp > 4177920) {
        temp = 4177920;
    }
    x[6] = (temp >> 14);
    
    //print result
    printf("Stage 4:\n\n");
    for (i = 8; i; i--) {
        printf("x[%d]: %u\n", 8-i, x[8-i]);
    }

    // keep in mind that after loeffler's algorithm is done, the output array X has shifted:
    // x[0] = X[0], x[1] = X[4], x[2] = X[2], x[3] = X[6], x[4] = X[7], x[5] = X[3], x[6] = X[5], x[7] = X[1] 
}
