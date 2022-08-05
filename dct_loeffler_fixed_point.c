// All cos and sqrt operations are pre-computed with scale-factors of 2^8 for better optimization
#include <stdio.h>
// pre-computed values for cos with a scale-factor of 2^8
int c[] = {213, 251, 98};
// pre-computed values for sin with a scale-factor of 2^8
int s[] = {142, 50, 237};
// pre-computed sqrt value with a scale-factor of 2^8
int q[] = {256, 362};

// swap the values of the provided ints
void swap(int *a, int *b, int *c) {
    int temp = *b;
    *b = *a;
    *a = *c;
    *c = temp;
}

void reflector(int *a, int *b) {
    
    int temp_a = *a + *b;

    int temp_b = *a - *b;

    *a = temp_a;
    *b = temp_b;
}

// The Rotator function can be impemented with butterfly operations in hardware.
void rotator(int *a, int *b, int k, int n) {
    
    int temp_a = (*a * q[k] * c[n]) + (*b * q[k] * s[n]);

    int temp_b = (*b * q[k] * c[n]) - (*a * q[k] * s[n]);
    
    *a = temp_a;
    *b = temp_b;
}



int main() {
    // the main input array for 1D-dct 
    int x[] = {1,2,3,4,5,6,7,8};
    
    // stage 1:
    int i;
    for (i = 4; i; i--) {
        reflector(&x[4-i], &x[3+i]);
     }

    // print result
    printf("Stage 1:\n\n");
    for (i = 8; i; i--) {
        printf("x[%d]: %d\n", 8-i, x[8-i]);
    }

    // stage 2:
    reflector(&x[0], &x[3]);
    reflector(&x[1], &x[2]);
    rotator(&x[4], &x[7], 0, 0);
    rotator(&x[5], &x[6], 0, 1);

    // print result
    printf("Stage 2:\n\n");
    for (i = 8; i; i--) {
        printf("x[%d]: %d\n", 8-i, x[8-i]);
    }

    // stage 3:
    reflector(&x[0], &x[1]);
    rotator(&x[2], &x[3], 1, 2);
    reflector(&x[4], &x[6]); 
    reflector(&x[7], &x[5]);
   
    // print result
    printf("Stage 3:\n\n");
    for (i = 8; i; i--) {
        printf("x[%d]: %d\n", 8-i, x[8-i]);
    }

    // stage 4:
    reflector(&x[7], &x[4]);
    int temp = q[1] * x[5];
  
    x[5] = temp;
    temp = q[1] * x[6];

    x[6] = temp;
    swap(&x[1], &x[4], &x[7]);
    swap(&x[3], &x[6], &x[5]);
    
    //print result
    printf("Stage 4:\n\n");
    for (i = 8; i; i--) {
        printf("x[%d]: %d\n", 8-i, x[8-i]);
    }

    // keep in mind that after loeffler's algorithm is done, the output array X has shifted:
    // x[0] = X[0], x[1] = X[4], x[2] = X[2], x[3] = X[6], x[4] = X[7], x[5] = X[3], x[6] = X[5], x[7] = X[1] 
    // now resolved by swap function before stage 4 results are printed
}
