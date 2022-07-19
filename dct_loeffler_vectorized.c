// Vectorized implementation of Loeffler using fixed-point arithmetic for 16-bit integers 
// Scale factors may be doubled for 32-bit integers 
/* Vectorized Loeffler Implementation Notes:  
    - To keep the entirety of intermediate constants within NEON registers, 
        the DCT will be computed in 2 halves.
    - Will require clever placement of elements within vectors 
    - Reflectors we can add and subtract elements simulaneously 
    - Rotators we can load all necessary constants into registers 
        - Can add the cosine term to both intermediate outputs
        - Vector shift for fixed point arithmetic 
    
*/

#include <stdio.h>
#include <math.h>   
#include <stdint.h>
#include "arm_neon.h"

// Pre-computed constants for the simplified rotator operation with SF = 2^5  
// Ox[0] = (k = 1, C = 1), Ox[1] = (k = 1, C = 3), Ox[2] = (k = root(2), C = 6) 
short int O1_consts[] = {-25, -9, 24};     
short int O2_consts[] = {-38, -44, -59};
short int C[] = {31, 27, 17}; 

// The Rotator function can be impemented with butterfly operations in hardware.  
// Here the simplified rotator function has been implemented with reduced multiplications
void trotator(short int *ain, short int *bin, short int *aout, short int *bout, int k) 
{ 
    
    short int o1, o2, c_temp; 

    c_temp = C[k] * (*ain + *bin);
    o1 = O1_consts[k] * *bin + c_temp; 
    o2 = O2_consts[k] * *ain + c_temp;

    *aout = o1 >> 5; 
    *bout = o2 >> 5;
} 

void debug(short int* data) 
{ 
    for(int i = 0; i < 8; i++) { 

        printf("%d\t", data[i]); 
    }   printf("\n");
};



//  TODO: Implement saturating arithmetic (for all stages)
int main() {
    
    // Assume 8-bit input to DCT (pixel value) 
    uint8_t x[] = {1, 2, 3, 4, 5, 6, 7, 8};

    // STAGE 1:  
    // Load values into NEON registers  
    // Load first 4 values into one register 
    // Load next 4 values into another register 
    // Add them, then subtract them
    uint8x8_t s1_start; 
    s1_start = vld1_u8(x); 
    // Execute reflectors
    // s1_out[0] = x[0] + x[7]; 
    // s1_out[7] = x[0] - x[7]; 
    // s1_out[1] = x[1] + x[6];
    // s1_out[6] = x[1] - x[6]; 
    // s1_out[2] = x[2] + x[5];
    // s1_out[5] = x[2] - x[5]; 
    // s1_out[3] = x[3] + x[4];
    // s1_out[4] = x[3] - x[4];

    // // Stage 2:
    // s2_out[0] = s1_out[0] + s1_out[3];
    // s2_out[3] = s1_out[0] - s1_out[3]; 
    // s2_out[1] = s1_out[1] + s1_out[2];
    // s2_out[2] = s1_out[1] - s1_out[2];
    // trotator(&s1_out[4], &s1_out[7], &s2_out[4], &s2_out[7], 1);
    // trotator(&s1_out[5], &s1_out[6], &s2_out[5], &s2_out[6], 0); 

    // // Check output of stage
    // printf("Stage 2 output\n");  
    // debug(s2_out);


    // // Stage 3:
    // s3_out[0] = s2_out[0] + s2_out[1]; 
    // s3_out[1] = s2_out[0] - s2_out[1]; 
    // trotator(&s2_out[2], &s2_out[3], &s3_out[2], &s3_out[3], 2); 
    // s3_out[4] = s2_out[4] + s2_out[6];
    // s3_out[6] = s2_out[4] - s2_out[6];
    // s3_out[7] = s2_out[7] + s2_out[5];
    // s3_out[5] = s2_out[7] - s2_out[5];
   
    // // Check output of stage
    // printf("Stage 3 output\n");  
    // debug(s3_out);

    // // Stage 4:   
    // int temp = s3_out[7];
    // s3_out[7] = s3_out[7] + s3_out[4]; 
    // s3_out[4] = temp - s3_out[4];  
    // s3_out[5] *= sqrt(2);
    // s3_out[6] *= sqrt(2);  

    // // Check output of stage
    // printf("Stage 4 output\n");  
    // debug(s3_out);

    // // Print final DCT product with attached final scale factor,
    // // prints reordered to match input sequence ordering 
    // printf("%.3f\t", s3_out[0] * 1 / (2 * sqrt(2)));
    // printf("%.3f\t", s3_out[7] * 1 / (2 * sqrt(2)));
    // printf("%.3f\t", s3_out[2] * 1 / (2 * sqrt(2)));
    // printf("%.3f\t", s3_out[5] * 1 / (2 * sqrt(2)));
    // printf("%.3f\t", s3_out[1] * 1 / (2 * sqrt(2)));
    // printf("%.3f\t", s3_out[6] * 1 / (2 * sqrt(2)));
    // printf("%.3f\t", s3_out[3] * 1 / (2 * sqrt(2)));
    // printf("%.3f\t", s3_out[4] * 1 / (2 * sqrt(2)));
    // printf("\n"); 

    // keep in mind that after loeffler's algorithm is done, the output array X has shifted:
    // x[0] = X[0], x[1] = X[4], x[2] = X[2], x[3] = X[6], x[4] = X[7], x[5] = X[3], x[6] = X[5], x[7] = X[1] 
}
