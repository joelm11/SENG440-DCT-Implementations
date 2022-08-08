# gcc -mfloat-abi=softfp -mfpu=neon dctv2.c -S
# Compiler selection 
CC = gcc 
# Compiler flags 
CFLAGS = -c -mfpu=neon-vfpv4 -Wall -mfloat-abi=hard -ffast-math -mcpu=cortex-a15 -O3
CFLAGS2 = -S -mfpu=neon-vfpv4 -Wall -mfloat-abi=hard -ffast-math -mcpu=cortex-a15 -O3
# invoked with 'make all', makes executable and all dependencies 
all: dctv2 

as: dctv2.s

test: dctv2t.s

dctv: dctv2.o 
	$(CC) dct_loeffler_vectorized.o -o dctv2 

dctv2.o: dctv2.c 
	$(CC) $(CFLAGS) dctv2.c

dctv2.s: dctv2.c 
	$(CC) $(CFLAGS2) dctv2.c 

dctv2t.s: dctv2t.c 
	$(CC) $(CFLAGS2) dctv2t.c

clean: 
	rm -rf *.o dctv