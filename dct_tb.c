#include <stdio.h>
#define _USE_MATH_DEFINES 
#include <math.h> 

const int N = 8;
const double test_sequence[] = {1, 2, 3, 4, 5, 6, 7, 8};

int main()
{ 
    // Calculate constants for coefficient matrix
    double SF = sqrt((double) 2 / N);  
    double inv_r2 = 1 / sqrt(2); 

    // Coefficient matrix calculation 
    double D[8][8]; 
    for( int i = 0; i < N; i++) { // i is like n and j is like k
        for( int j = 0; j < N; j++) { 
            
            if(i == 0) { 
                D[i][j] = SF / inv_r2;
            } else { 
                D[i][j] = SF * cos((2 * i + 1) * (j * M_PI) / (2 * N));
            } 
            printf("%.3f ", D[i][j]); 
        }  
        printf("\n");
    } 

    // DCT calculation 
    double C[8] = {0};
    for( int i = 0; i < N; i++) { 
        for( int j = 0; j < N; j++) { 
            
            C[i] += test_sequence[j] * D[i][j]; 
        }
    }

    // Verify DCT 
    printf("DCT of sequence:\n");
    for( int i = 0; i < N; i++) { 
        printf("%.3f\t", C[i]);
    }

    printf("\n");
    return 0;
}