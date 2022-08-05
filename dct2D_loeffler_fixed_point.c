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
    // the main input array for 2D-dct 
    int x[8][8] = {
        {1,2,3,4,5,6,7,8},
        {9,10,11,12,13,14,15,16},
        {17,18,19,20,21,22,23,24},
        {25,26,27,28,29,30,31,32},
        {33,34,35,36,37,38,39,40},
        {41,42,43,44,45,46,47,48},
        {49,50,51,52,53,54,55,56},
        {57,58,59,60,61,62,63,64}
    };
    
    int n;
    for(n = 0; n < 8; n++) {
    
        // stage 1:
        int i;
        for (i = 4; i; i--) {
            reflector(&x[n][4-i], &x[n][3+i]);
        }

        // stage 2:
        reflector(&x[n][0], &x[n][3]);
        reflector(&x[n][1], &x[n][2]);
        rotator(&x[n][4], &x[n][7], 0, 0);
        rotator(&x[n][5], &x[n][6], 0, 1);

        // stage 3:
        reflector(&x[n][0], &x[n][1]);
        rotator(&x[n][2], &x[n][3], 1, 2);
        reflector(&x[n][4], &x[n][6]); 
        reflector(&x[n][7], &x[n][5]);

        // stage 4:
        reflector(&x[n][7], &x[n][4]);
        int temp = q[1] * x[n][5];
  
        x[n][5] = temp;
        temp = q[1] * x[n][6];

        x[n][6] = temp;
        swap(&x[n][1], &x[n][4], &x[n][7]);
        swap(&x[n][3], &x[n][6], &x[n][5]);
        
    }
    printf("\n");
    
    for(n = 0; n < 8; n++) {
    
        // stage 1:
        int i;
        for (i = 4; i; i--) {
            reflector(&x[4-i][n], &x[3+i][n]);
        }

        // stage 2:
        reflector(&x[0][n], &x[3][n]);
        reflector(&x[1][n], &x[2][n]);
        rotator(&x[4][n], &x[7][n], 0, 0);
        rotator(&x[5][n], &x[6][n], 0, 1);

        // stage 3:
        reflector(&x[0][n], &x[1][n]);
        rotator(&x[2][n], &x[3][n], 1, 2);
        reflector(&x[4][n], &x[6][n]); 
        reflector(&x[7][n], &x[5][n]);

        // stage 4:
        reflector(&x[7][n], &x[4][n]);
        int temp = q[1] * x[5][n];
  
        x[5][n] = temp;
        temp = q[1] * x[6][n];

        x[6][n] = temp;
        swap(&x[1][n], &x[4][n], &x[7][n]);
        swap(&x[3][n], &x[6][n], &x[5][n]);
        
    }
    int m;
    // print the result
    // numbers have not been scaled back down in order to preserve accuracy
    for(n = 0; n < 8; n++) {
        for(m = 0; m < 8; m++) {
            printf(" %d ", x[n][m]);
        }
        printf("\n");
    }
}
