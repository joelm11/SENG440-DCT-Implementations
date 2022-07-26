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

#define DCT_INPUT_SIZE 4 
#define DCT_INPUT_LENGTH 8

// TODO: Code these as macros
// Pre-computed constants for the simplified rotator operation with SF = 2^5  
// Ox[0] = (k = 1, C = 1), Ox[1] = (k = 1, C = 3), Ox[2] = (k = root(2), C = 6) 
short int O1_consts[] = {-25, -9, 24};     
short int O2_consts[] = {-38, -44, -59};
short int C[] = {31, 27, 17}; 

// The Rotator function can be impemented with butterfly operations in hardware.  
// Here the simplified rotator function has been implemented with reduced multiplications
void trotator(int16_t *ain, int16_t *bin, int16_t *aout, int16_t *bout, int k) 
{ 

    short int o1, o2, c_temp; 

    c_temp = C[k] * (*ain + *bin);
    o1 = O1_consts[k] * *bin + c_temp; 
    o2 = O2_consts[k] * *ain + c_temp;

    // Could make this nicer to preserve a bit of precision
    *aout = o1 >> 5; 
    *bout = o2 >> 5;
} 

void debug(int16x8_t data) 
{ 
    int16_t result;   
    result = vgetq_lane_s16(data, 0);
    printf("%d\t", result); 
    result = vgetq_lane_s16(data, 1);
    printf("%d\t", result);
    result = vgetq_lane_s16(data, 2);
    printf("%d\t", result);
    result = vgetq_lane_s16(data, 3);
    printf("%d\t", result); 
    result = vgetq_lane_s16(data, 4);
    printf("%d\t", result); 
    result = vgetq_lane_s16(data, 5);
    printf("%d\t", result);
    result = vgetq_lane_s16(data, 6);
    printf("%d\t", result);
    result = vgetq_lane_s16(data, 7);
    printf("%d\t", result); 
    printf("\n");
};

void test(int16_t *temp) 
{ 

    printf("Passed value: %d\n", *temp);
};


//  TODO: Implement saturating arithmetic (for all stages)
int main() 
{
    
    // Assume 8-bit input to DCT (pixel value) 
    const int16_t x1[] =   {1, 2, 3, 4, 5, 6, 7, 8, 
                            1, 2, 3, 4, 5, 6, 7, 8,
                            1, 2, 3, 4, 5, 6, 7, 8, 
                            1, 2, 3, 4, 5, 6, 7, 8, 
                            1, 2, 3, 4, 5, 6, 7, 8, 
                            1, 2, 3, 4, 5, 6, 7, 8, 
                            1, 2, 3, 4, 5, 6, 7, 8, 
                            1, 2, 3, 4, 5, 6, 7, 8,
                            };

    /*  Load 8x8 Block:    
    *
    *   Implementation credit: https://chromium.googlesource.com/chromium/deps/libjpeg_turbo/+/408fab0d8ec3d5aaf274607d688064326d91f725/simd/arm/common/jfdctint-neon.c
    */  
    
    int16x8x4_t rows1to3, rows4to7; 
    
    // vld4q() as it the largest load possible
    rows1to3 = vld4q_s16(x1); 
    rows4to7 = vld4q_s16(x1 + 16); 
    
    // Deinterleave elements so that q0 and q1 are two separate columns
    int16x8x2_t cols0_4 = vuzpq_s16(rows1to3.val[0], rows4to7.val[0]); 
    int16x8x2_t cols1_5 = vuzpq_s16(rows1to3.val[1], rows4to7.val[1]); 
    int16x8x2_t cols2_6 = vuzpq_s16(rows1to3.val[2], rows4to7.val[2]); 
    int16x8x2_t cols3_7 = vuzpq_s16(rows1to3.val[3], rows4to7.val[3]); 
    
    // Load each column into individual registers  
    // Note: NEON guide recommends using lots of variables so the compiler can better optimize 
    // and pipeline subsequent assembly
    int16x8_t col0 = cols0_4.val[0]; 
    int16x8_t col7 = cols0_4.val[1]; 
    int16x8_t col1 = cols1_5.val[0]; 
    int16x8_t col5 = cols1_5.val[1];
    int16x8_t col2 = cols2_6.val[0];
    int16x8_t col6 = cols2_6.val[1];
    int16x8_t col3 = cols3_7.val[0];
    int16x8_t col4 = cols3_7.val[1]; 
    
    
}
