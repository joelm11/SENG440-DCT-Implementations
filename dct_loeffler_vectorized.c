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

void debug(int16x4_t data) 
{ 
    int16_t result;   
    result = vget_lane_s16(data, 0);
    printf("%d\t", result); 
    result = vget_lane_s16(data, 1);
    printf("%d\t", result);
    result = vget_lane_s16(data, 2);
    printf("%d\t", result);
    result = vget_lane_s16(data, 3);
    printf("%d\t", result);
};

void test(int16_t *temp) 
{ 

    printf("Passed value: %d\n", *temp);
};


//  TODO: Implement saturating arithmetic (for all stages)
int main() 
{
    
    // Assume 8-bit input to DCT (pixel value) 
    const int16_t x1[] = {1, 2, 3, 4, 5, 6, 7, 8};

    /*  STAGE 1: */  
    // Load values into NEON registers   
    int16x4_t top1, bot1;  
    int16x4_t top2, bot2; 
    
    // Load first 4 inputs to NEON register
    top1 = vld1_s16(x1); 
    // Load last 4 inputs to NEON register
    bot1 = vld1_s16(x1 + 4); 
    // Reverse to make reflector operation convenient
    bot1 = vrev64_s16(bot1); 
    // Add vectors and store result in larger intermediate vector
    top2 = vadd_s16(top1, bot1);
    // Note that these are now reversed in order within the vector
    bot2 = vsub_s16(top1, bot1); 
 
    // DEBUG
    printf("Stage 1:\n"); 
    debug(top2); 
    debug(bot2);
    printf("\n");

    /*  STAGE 2: */ 
    // Top Coefficients 
    int16x4_t s2_out_top, s2_out_bot;  
    top1 = vsetlane_s16((vget_lane_s16(top2, 0) + vget_lane_s16(top2, 3)), top1, 0); 
    // top1[3] = top2[0] - top2[3]; 
    top1 = vsetlane_s16((vget_lane_s16(top2, 0) - vget_lane_s16(top2, 3)), top1, 3);
    // top1[1] = top2[1] + top2[2]; 
    top1 = vsetlane_s16((vget_lane_s16(top2, 1) + vget_lane_s16(top2, 2)), top1, 1);
    // top1[2] = top2[1] - top2[2];
    top1 = vsetlane_s16((vget_lane_s16(top2, 1) - vget_lane_s16(top2, 2)), top1, 2);
    // Bottom coefficients (Keep in mind bot array input in reversed order)
    trotator(&bot2[3], &bot2[0], &bot1[0], &bot1[3], 1);
    trotator(&bot2[2], &bot2[1], &bot1[1], &bot1[2], 0);   

    // DEBUG  
    printf("Stage 2:\n");
    debug(top1); 
    debug(bot1);
    printf("\n");

    /*  STAGE 3 */ 
    // Top coefficients 
    int16x4_t s3_out_top, s3_out_bot;
    s3_out_top[0] = s2_out_top[0] + s2_out_top[1]; 
    s3_out_top[1] = s2_out_top[0] - s2_out_top[1];  
    // Rotator implementation as a function, will likely greatly benefit from assembly inlining 
    // Addition of c_temp can be vectorized 
    // All other operations are scalar 
    // VMLA VMLA_LANE VMUL_N
    trotator(&s2_out_top[2], &s2_out_top[3], &s3_out_top[2], &s3_out_top[3], 2);   

    // Bottom coefficients
    s3_out_bot[0] = s2_out_bot[0] + s2_out_bot[2];
    s3_out_bot[2] = s2_out_bot[0] - s2_out_bot[2];
    s3_out_bot[3] = s2_out_bot[3] + s2_out_bot[1];
    s3_out_bot[1] = s2_out_bot[3] - s2_out_bot[1];
   
    // DEBUG
    printf("Stage 3:\n"); 
    debug(s3_out_top); 
    debug(s3_out_bot);
    printf("\n");

    /* STAGE 4: */  
    int16_t temp = s3_out_bot[3];
    s3_out_bot[3] = s3_out_bot[3] + s3_out_bot[0]; 
    s3_out_bot[0] = temp - s3_out_bot[0];  
    s3_out_bot[1] *= sqrt(2);
    s3_out_bot[2] *= sqrt(2);  

    // Check output of stage
    printf("Stage 4:\n"); 
    debug(s3_out_top); 
    debug(s3_out_bot);
    printf("\n");

    // Print final DCT product with attached final scale factor,
    // prints reordered to match input sequence ordering 
    printf("%.3f\t", s3_out_top[0] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", s3_out_bot[3] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", s3_out_top[2] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", s3_out_bot[1] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", s3_out_top[1] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", s3_out_bot[2] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", s3_out_top[3] * 1 / (2 * sqrt(2)));
    printf("%.3f\t", s3_out_bot[0] * 1 / (2 * sqrt(2)));
    printf("\n"); 

    // keep in mind that after loeffler's algorithm is done, the output array X has shifted:
    // x[0] = X[0], x[1] = X[4], x[2] = X[2], x[3] = X[6], x[4] = X[7], x[5] = X[3], x[6] = X[5], x[7] = X[1] 
}
