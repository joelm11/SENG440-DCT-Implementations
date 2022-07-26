	# gcc -mfloat-abi=softfp -mfpu=neon dctv2.c -S
# Compiler selection 
CC = gcc 
# Compiler flags 
CFLAGS = -c -mfloat-abi=hard -mfpu=neon
# invoked with 'make all', makes executable and all dependencies 
all: dctv2 

dctv: dctv2.o 
	$(CC) dct_loeffler_vectorized.o -o dctv2 
dctv2.o: dctv2.c 
	$(CC) $(CFLAGS) dctv2.c

clean: 
	rm -rf *.o dctv