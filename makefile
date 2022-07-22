	# gcc -mfloat-abi=softfp -mfpu=neon dct_loeffler_vectorized.c -S
# Compiler selection 
CC = gcc 
# Compiler flags 
CFLAGS = -c -mfloat-abi=hard -mfpu=neon -O2
# invoked with 'make all', makes executable and all dependencies 
all: dctv 

dctv: dct_loeffler_vectorized.o 
	$(CC) dct_loeffler_vectorized.o -o dctv 
dct_loeffler_vectorized.o: dct_loeffler_vectorized.c 
	$(CC) $(CFLAGS) dct_loeffler_vectorized.c

clean: 
	rm -rf *.o dctv