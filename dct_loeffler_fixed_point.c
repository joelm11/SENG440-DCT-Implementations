// Implementation of Loeffler using fixed-point arithmetic 

#include <stdio.h>

// Pre-computed values for Cosine, Sine, and root(2) with a scale-factor of 2^7 
// Indices of sinusoid arrays correspond to [0] = f(3pi/16), [1] = f(pi/16), [2] = f(6pi/16) 
// Q[0] = root(2), Q[1] = ?
unsigned int C[] = {106, 126, 49};
unsigned int S[] = {71, 25, 118};
unsigned int Q[] = {128, 181}; 

// Pre-computed constants for the simplified rotator operation with SF = 2^7  
// Ox[0] = (k = 1, C = 1), Ox[1] = (k = 1, C = 3), Ox[2] = (k = root(2), C = 6) 
unsigned int O1_consts[] = {};     
unsigned int O2_consts[] = {};
unsigned int C[] = {106, 126, 49}; // NOTE: Reorder these probably

void reflector(unsigned int *a, unsigned int *b) {

    // TODO: There is an assembly instruction for saturated arithmetic that should be utilized here
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



//  TODO: Implement saturating arithmetic (for all stages)
int main() {
    
    // Assume 8-bit input to DCT (pixel value) 
    unsigned int x[] = {1, 2, 3, 4, 5, 6, 7, 8};
    unsigned int s1_out[8];
    unsigned int s2_out[8];
    unsigned int s3_out[8];
    unsigned int s4_out[8];

    // Stage 1: 
    s1_out[0] = x[0] + x[7]; 
    s1_out[7] = x[0] - x[7]; 
    s1_out[1] = x[1] + x[6];
    s1_out[6] = x[1] - x[6]; 
    s1_out[2] = x[2] + x[5];
    s1_out[5] = x[2] - x[5]; 
    s1_out[3] = x[3] + x[4];
    s1_out[4] = x[3] - x[4];

    // Stage 2:
    s2_out[0] = s1_out[0] + s1_out[3];
    s2_out[3] = s1_out[0] - s1_out[3]; 
    s2_out[1] = s1_out[1] + s1_out[2];
    s2_out[2] = s1_out[1] - s1_out[2];
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
