// Vectorized implementation of Loeffler using fixed-point arithmetic for 16-bit integers 
// Implementation credit for vector transposition: https://chromium.googlesource.com/chromium/deps/libjpeg_turbo/+/408fab0d8ec3d5aaf274607d688064326d91f725/simd/arm/common/jfdctint-neon.c
// Note: NEON guide recommends using lots of variables so the compiler can better optimize 
// and pipeline subsequent assembly
#include <stdio.h>
#include <math.h>   
#include <stdint.h>
#include "arm_neon.h" 

/**  
    Constants for use in rotators.  
    All constants have an attached scale factor of 2^5.
**/
#define COS6_CONST 17 
#define COS3_CONST 27 
#define COS1_CONST 31 
#define R6O1CONST 24 
#define R6O2CONST -59 
#define R3O1CONST -9 
#define R3O2CONST -44 
#define R1O1CONST -25 
#define R1O2CONST -38 
#define ROOT2 = 45

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
void debug2(int32x4_t data) 
{ 
    int32_t result;   
    result = vgetq_lane_s32(data, 0);
    printf("%d\t", result>>16); 
    // result = vgetq_lane_s32(data, 1);
    printf("%d\t", result & 0xFFFF); 
        result = vgetq_lane_s32(data, 1);
    printf("%d\t", result>>16); 
    // result = vgetq_lane_s32(data, 1);
    printf("%d\t", result & 0xFFFF); 
        result = vgetq_lane_s32(data, 2);
    printf("%d\t", result>>16); 
    // result = vgetq_lane_s32(data, 1);
    printf("%d\t", result & 0xFFFF); 
        result = vgetq_lane_s32(data, 3);
    printf("%d\t", result>>16); 
    // result = vgetq_lane_s32(data, 1);
    printf("%d\n", result & 0xFFFF); 
}
//  TODO: Implement saturating arithmetic (for all stages)
int main() 
{ 

    // Constant values for rotator operations  
 

    const int16_t root2 = 45;

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
    */   



    int16x8x4_t rows1to3, rows4to7; 
    
    // vld4q() as it is the largest load possible
    rows1to3 = vld4q_s16(x1); 
    rows4to7 = vld4q_s16(x1 + 16); 
    

    // Deinterleave elements so that q0 and q1 are two separate columns
    int16x8x2_t cols0_4 = vuzpq_s16(rows1to3.val[0], rows4to7.val[0]); 
    int16x8x2_t cols1_5 = vuzpq_s16(rows1to3.val[1], rows4to7.val[1]); 
    int16x8x2_t cols2_6 = vuzpq_s16(rows1to3.val[2], rows4to7.val[2]); 
    int16x8x2_t cols3_7 = vuzpq_s16(rows1to3.val[3], rows4to7.val[3]); 
    
    // Load each column into individual registers  
    int16x8_t col0 = cols0_4.val[0]; 
    int16x8_t col4 = cols0_4.val[1]; 
    int16x8_t col1 = cols1_5.val[0]; 
    int16x8_t col5 = cols1_5.val[1];
    int16x8_t col2 = cols2_6.val[0];
    int16x8_t col6 = cols2_6.val[1];
    int16x8_t col3 = cols3_7.val[0];
    int16x8_t col7 = cols3_7.val[1];   

    /* BEGIN CALCULATE EVEN DCT */ 
    // Stage 1   
    __asm("@ Begin Stage 1");
    int16x8_t col0s1 = vaddq_s16(col0, col7); 
    int16x8_t col7s1 = vsubq_s16(col0, col7);
    int16x8_t col1s1 = vaddq_s16(col1, col6);
    int16x8_t col6s1 = vsubq_s16(col1, col6);
    int16x8_t col2s1 = vaddq_s16(col2, col5);
    int16x8_t col5s1 = vsubq_s16(col2, col5);
    int16x8_t col3s1 = vaddq_s16(col3, col4);
    int16x8_t col4s1 = vsubq_s16(col3, col4); 
    __asm("@ End Stage 1"); 
    // Stage 2 
    int16x8_t col0s2 = vaddq_s16(col0s1, col3s1); 
    int16x8_t col1s2 = vaddq_s16(col1s1, col2s1); 
    int16x8_t col2s2 = vsubq_s16(col1s1, col2s1); 
    int16x8_t col3s2 = vsubq_s16(col0s1, col3s1); 
    // Stage 3  
    int16x8_t col0s3 = vaddq_s16(col0s2, col1s2); 
    int16x8_t col1s3 = vsubq_s16(col0s2, col1s2);
    // Begin Rotator 6      
    __asm("@ Begin R6"); 
    int16x8_t cos6_const = vdupq_n_s16(COS6_CONST);   // Load with scalars  
    int16x8_t r6o1consts = vdupq_n_s16(R6O1CONST);
    int16x8_t r6o2consts = vdupq_n_s16(R6O2CONST); 
    int16x8_t r6_inputs_sum = vaddq_s16(col2s2, col3s2); 
    int16x8_t c_temp6 = vmulq_s16(cos6_const, r6_inputs_sum); 
    int16x8_t r6o1temp1 = vmulq_s16(r6o1consts, col3s2);
    int16x8_t r6o2temp1 = vmulq_s16(r6o2consts, col2s2); 
    int16x8_t r6o1temp2 = vaddq_s16(r6o1temp1, c_temp6); 
    int16x8_t r6o2temp2 = vaddq_s16(r6o2temp1, c_temp6); 
    int16x8_t col2s3 = vrshrq_n_s16(r6o1temp2, 5);     // Scale back down 
    int16x8_t col3s3 = vrshrq_n_s16(r6o2temp2, 5);  
    __asm("@ End R6");
    // End Rotator 6
    /* END CALCULATE EVEN DCT*/ 

    /* BEGIN CALCULATE ODD DCT */ 
    // Stage 2 
    // Begin Rotator 3   
    int16x8_t cos3_const = vdupq_n_s16(COS3_CONST);   // Load with scalars  
    int16x8_t r3o1consts = vdupq_n_s16(R3O1CONST);
    int16x8_t r3o2consts = vdupq_n_s16(R3O2CONST);
    int16x8_t r3temp = vaddq_s16(col4s1, col7s1); 
    int16x8_t c_temp3 = vmulq_s16(cos3_const, r3temp); 
    int16x8_t r3o1temp1 = vmulq_s16(r3o1consts, col7s1);
    int16x8_t r3o2temp1 = vmulq_s16(r3o2consts, col4s1); 
    int16x8_t r3o1temp2 = vaddq_s16(r3o1temp1, c_temp3); 
    int16x8_t r3o2temp2 = vaddq_s16(r3o2temp1, c_temp3); 
    int16x8_t col4s2 = vshrq_n_s16(r3o1temp2, 5);     // Scale back down 
    int16x8_t col7s2 = vshrq_n_s16(r3o2temp2, 5); 
    // End Rotator 3  
    // Begin Rotator 1       
    int16x8_t cos1_const = vdupq_n_s16(COS1_CONST);   // Load with scalars  
    int16x8_t r1o1consts = vdupq_n_s16(R1O1CONST);
    int16x8_t r1o2consts = vdupq_n_s16(R1O2CONST); 
    int16x8_t r1temp = vaddq_s16(col5s1, col6s1); 
    int16x8_t c_temp1 = vmulq_s16(cos1_const, r1temp); 
    int16x8_t r1o1temp1 = vmulq_s16(r1o1consts, col6s1);
    int16x8_t r1o2temp1 = vmulq_s16(r1o2consts, col5s1); 
    int16x8_t r1o1temp2 = vaddq_s16(r1o1temp1, c_temp1); 
    int16x8_t r1o2temp2 = vaddq_s16(r1o2temp1, c_temp1); 
    int16x8_t col5s2 = vshrq_n_s16(r1o1temp2, 5);     // Scale back down 
    int16x8_t col6s2 = vshrq_n_s16(r1o2temp2, 5); 
    // End Rotator 1 
    // Stage 3  
    int16x8_t col4s3 = vaddq_s16(col4s2, col6s2);
    int16x8_t col6s3 = vsubq_s16(col4s2, col6s2);
    int16x8_t col7s3 = vaddq_s16(col7s2, col5s2);
    int16x8_t col5s3 = vsubq_s16(col7s2, col5s2);
    // Stage 4 
    int16x8_t col7s4 = vaddq_s16(col7s3, col4s3);
    int16x8_t col4s4 = vsubq_s16(col7s3, col4s3);  
    int16x8_t col5s4 = vmulq_n_s16(col5s3, root2); 
    col5s4 = vshrq_n_s16(col5s4, 5);
    int16x8_t col6s4 = vmulq_n_s16(col6s3, root2); 
    col6s4 = vshrq_n_s16(col6s4, 5);
    /* END CALCULATE ODD DCT */  \
    // DEBUG
    // printf("Completed Horizontal DCT:\n");
    // debug(col0s3);
    // debug(col1s3);
    // debug(col2s3);
    // debug(col3s3);
    // debug(col4s4);
    // debug(col5s4);
    // debug(col6s4);
    // debug(col7s4);
    /* VERTICAL DCT */ 
    // Reshape data for DCT 
    int16x8x2_t cols_01 = vtrnq_s16(col0s3, col7s4);                            // Interleave adjacent rows (products)
    int16x8x2_t cols_23 = vtrnq_s16(col3s3, col5s4);
    int16x8x2_t cols_45 = vtrnq_s16(col1s3, col6s4);
    int16x8x2_t cols_67 = vtrnq_s16(col3s3, col4s4); 
    int32x4x2_t cols_0145_l = vtrnq_s32(vreinterpretq_s32_s16(cols_01.val[0]),  // Interleave alternating interleaved adjacent rows
                                        vreinterpretq_s32_s16(cols_45.val[0]));
    int32x4x2_t cols_0145_h = vtrnq_s32(vreinterpretq_s32_s16(cols_01.val[1]),
                                        vreinterpretq_s32_s16(cols_45.val[1]));
    int32x4x2_t cols_2367_l = vtrnq_s32(vreinterpretq_s32_s16(cols_23.val[0]),
                                        vreinterpretq_s32_s16(cols_67.val[0]));
    int32x4x2_t cols_2367_h = vtrnq_s32(vreinterpretq_s32_s16(cols_23.val[1]),
                                        vreinterpretq_s32_s16(cols_67.val[1])); 
    int32x4x2_t rows_04 = vzipq_s32(cols_0145_l.val[0], cols_2367_l.val[0]);    // By another vector interleaving resultant vector becomes ordered
    int32x4x2_t rows_15 = vzipq_s32(cols_0145_h.val[0], cols_2367_h.val[0]);    // result of horizontal DCT
    int32x4x2_t rows_26 = vzipq_s32(cols_0145_l.val[1], cols_2367_l.val[1]);
    int32x4x2_t rows_37 = vzipq_s32(cols_0145_h.val[1], cols_2367_h.val[1]);
    int16x8_t row0 = vreinterpretq_s16_s32(rows_04.val[0]);                     // Extract horizontal DCT products for vertical DCT
    int16x8_t row1 = vreinterpretq_s16_s32(rows_15.val[0]);
    int16x8_t row2 = vreinterpretq_s16_s32(rows_26.val[0]);
    int16x8_t row3 = vreinterpretq_s16_s32(rows_37.val[0]);
    int16x8_t row4 = vreinterpretq_s16_s32(rows_04.val[1]);
    int16x8_t row5 = vreinterpretq_s16_s32(rows_15.val[1]);
    int16x8_t row6 = vreinterpretq_s16_s32(rows_26.val[1]);
    int16x8_t row7 = vreinterpretq_s16_s32(rows_37.val[1]);
    /* BEGIN CALCULATE EVEN DCT */  
    // Stage 1
    int16x8_t row0s1 = vaddq_s16(row0, row7); 
    int16x8_t row7s1 = vsubq_s16(row0, row7);
    int16x8_t row1s1 = vaddq_s16(row1, row6);
    int16x8_t row6s1 = vsubq_s16(row1, row6);
    int16x8_t row2s1 = vaddq_s16(row2, row5);
    int16x8_t row5s1 = vsubq_s16(row2, row5);
    int16x8_t row3s1 = vaddq_s16(row3, row4);
    int16x8_t row4s1 = vsubq_s16(row3, row4);  
    // Stage 2 
    int16x8_t row0s2 = vaddq_s16(row0s1, row3s1); 
    int16x8_t row1s2 = vaddq_s16(row1s1, row2s1); 
    int16x8_t row2s2 = vsubq_s16(row1s1, row2s1); 
    int16x8_t row3s2 = vsubq_s16(row0s1, row3s1);  
    // Stage 3 
    int16x8_t row0s3 = vaddq_s16(row0s2, row1s2); 
    int16x8_t row1s3 = vsubq_s16(row0s2, row1s2);
    // Begin Rotator 6     
    r6_inputs_sum = vaddq_s16(row2s2, row3s2);      // Sum rotator inputs
    c_temp6 = vmulq_s16(cos6_const, r6_inputs_sum); // Calculate constant term
    r6o1temp1 = vmulq_s16(r6o1consts, row3s2);      // Calculate O1 temp
    r6o2temp1 = vmulq_s16(r6o2consts, row2s2);      // Calculate O2 temp
    r6o1temp2 = vaddq_s16(r6o1temp1, c_temp6);      // Add constant term to both outputs
    r6o2temp2 = vaddq_s16(r6o2temp1, c_temp6);      
    int16x8_t row2s3 = vshrq_n_s16(r6o1temp2, 5);   // Remove SF from result and round 
    int16x8_t row3s3 = vshrq_n_s16(r6o2temp2, 5);  
    // End Rotator 6
    /* END CALCULATE EVEN DCT*/
    /* BEGIN CALCULATE ODD DCT*/  
    // Stage 2
    r3temp = vaddq_s16(row4s1, row7s1); 
    c_temp3 = vmulq_s16(cos3_const, r3temp); 
    r3o1temp1 = vmulq_s16(r3o1consts, row7s1);
    r3o2temp1 = vmulq_s16(r3o2consts, row4s1); 

    r3o1temp2 = vaddq_s16(r3o1temp1, c_temp3); 
    r3o2temp2 = vaddq_s16(r3o2temp1, c_temp3); 
    int16x8_t row4s2 = vshrq_n_s16(r3o1temp2, 5);     // Scale back down 
    int16x8_t row7s2 = vshrq_n_s16(r3o2temp2, 5); 
    // End Rotator 3  
    // Begin Rotator 1      
    r1temp = vaddq_s16(row5s1, row6s1); 
    c_temp1 = vmulq_s16(cos1_const, r1temp); 
    r1o1temp1 = vmulq_s16(r1o1consts, row6s1);
    r1o2temp1 = vmulq_s16(r1o2consts, row5s1); 
    r1o1temp2 = vaddq_s16(r1o1temp1, c_temp1); 
    r1o2temp2 = vaddq_s16(r1o2temp1, c_temp1); 
    int16x8_t row5s2 = vshrq_n_s16(r1o1temp2, 5);     // Scale back down 
    int16x8_t row6s2 = vshrq_n_s16(r1o2temp2, 5); 
    // End Rotator 1  
    // Stage 3 
    int16x8_t row4s3 = vaddq_s16(row4s2, row6s2);
    int16x8_t row6s3 = vsubq_s16(row4s2, row6s2);
    int16x8_t row7s3 = vaddq_s16(row7s2, row5s2);
    int16x8_t row5s3 = vsubq_s16(row7s2, row5s2); 
    // Stage 4 
    int16x8_t row7s4 = vaddq_s16(row7s3, row4s3);
    int16x8_t row4s4 = vsubq_s16(row7s3, row4s3);  
    int16x8_t row5s4 = vmulq_n_s16(row5s3, root2); 
    row5s4 = vshrq_n_s16(row5s4, 5);
    int16x8_t row6s4 = vmulq_n_s16(row6s3, root2); 
    row6s4 = vshrq_n_s16(row6s4, 5);
    /* END CALCULATE ODD DCT*/ 

    // As final formatting divide all values by 8 (1/2root(2) done twice)
    printf("Completed Vertical DCT:\n"); 
    debug(vshrq_n_s16(row0s3, 3)); 
    debug(row1s3);
    debug(row2s3);
    debug(row3s3);
    debug(row4s4);
    debug(row5s4);
    debug(row6s4);
    debug(row7s4); 
    // Store back to memory

}
