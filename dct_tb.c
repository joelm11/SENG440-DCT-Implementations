// Calculate DCT of arbitrary sequence using matrix of precalculated DCT coeffs. 
// C = D*x where D is NxN and x is an N length input
#include <stdio.h>
#define _USE_MATH_DEFINES 
#include <math.h> 

const int N = 8;
const double test_sequence[] = {1, 2, 3, 4, 5, 6, 7, 8};

int main()
{ 
    // Calculate constants for coefficient matrix
    double SF = sqrt( 2.0 / N);  
    double inv_r2 = (1.0 / sqrt(2.0)); 

    // Coefficient matrix calculation 
    double D[N][N]; 
    for( int k = 0; k < N; k++) { 
        for( int n = 0; n < N; n++) { 
            
            if(k == 0) { 
                D[k][n] = inv_r2;
            } else { 
                D[k][n] = cos((2 * n + 1) * (k * M_PI) / (2 * N));
            } 
        }  
    } 

    // DCT calculation 
    double C[N];
    for( int i = 0; i < N; i++) {  
        C[i] = 0;
        for( int j = 0; j < N; j++) { 
            
            C[i] += SF * test_sequence[j] * D[i][j]; 
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