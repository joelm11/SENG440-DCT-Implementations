	.cpu cortex-a15
	.eabi_attribute 28, 1
	.eabi_attribute 23, 1
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"dctv2.c"
	.text
	.align	2
	.global	debug
	.arch armv7ve
	.syntax unified
	.arm
	.fpu neon-vfpv4
	.type	debug, %function
debug:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	r4, [sp, #-8]!
	movw	r4, #:lower16:.LC1
	str	lr, [sp, #4]
	movt	r4, #:upper16:.LC1
	vpush.64	{d8, d9}
	vmov	q4, q0  @ v8hi
	mov	r0, r4
	vmov.s16	r1, d0[0]
	bl	printf
	mov	r0, r4
	vmov.s16	r1, d8[1]
	bl	printf
	vmov.s16	r1, d8[2]
	mov	r0, r4
	bl	printf
	vmov.s16	r1, d8[3]
	mov	r0, r4
	bl	printf
	vmov.s16	r1, d9[0]
	mov	r0, r4
	bl	printf
	vmov.s16	r1, d9[1]
	mov	r0, r4
	bl	printf
	vmov.s16	r1, d9[2]
	mov	r0, r4
	bl	printf
	mov	r0, r4
	vmov.s16	r1, d9[3]
	bl	printf
	vldm	sp!, {d8-d9}
	mov	r0, #10
	ldr	r4, [sp]
	ldr	lr, [sp, #4]
	add	sp, sp, #8
	b	putchar
	.size	debug, .-debug
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon-vfpv4
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 192
	@ frame_needed = 0, uses_anonymous_args = 0
	str	r4, [sp, #-8]!
	str	lr, [sp, #4]
	vpush.64	{d8, d9, d10, d11, d12, d13, d14, d15}
	sub	sp, sp, #192
	bl	clock
	movw	r1, #:lower16:.LANCHOR0
	mov	r4, r0
	movt	r1, #:upper16:.LANCHOR0
	add	r0, sp, #64
	mov	r2, #128
	bl	memcpy
	add	r3, sp, #96
	add	r2, sp, #64
	vld4.16	{d0, d2, d4, d6}, [r3:64]
	vld4.16	{d24, d26, d28, d30}, [r2:64]
	add	r2, sp, #128
	vld4.16	{d1, d3, d5, d7}, [r2:64]
	vld4.16	{d25, d27, d29, d31}, [r3:64]
	vmov	q11, q0  @ v8hi
	vmov	q4, q1  @ v8hi
	vmov	q7, q2  @ v8hi
	vmov	q8, q3  @ v8hi
	vmov	q9, q12  @ v8hi
	vmov	q10, q13  @ v8hi
	vmov	q5, q14  @ v8hi
	vmov	q6, q15  @ v8hi
	vuzp.16	q9, q11
	vuzp.16	q10, q4
	vuzp.16	q5, q7
	vuzp.16	q6, q8
	.syntax divided
@ 86 "dctv2.c" 1
	@ Begin Stage 1
@ 0 "" 2
	.arm
	.syntax unified
	vadd.i16	q12, q8, q9
	vadd.i16	q13, q5, q4
	vsub.i16	q8, q9, q8
	vsub.i16	q5, q5, q4
	vadd.i16	q9, q7, q10
	vsub.i16	q7, q10, q7
	vadd.i16	q10, q6, q11
	vsub.i16	q6, q6, q11
	.syntax divided
@ 95 "dctv2.c" 1
	@ End Stage 1
@ 0 "" 2
	.arm
	.syntax unified
	vadd.i16	q1, q10, q12
	vadd.i16	q11, q13, q9
	vsub.i16	q10, q12, q10
	vsub.i16	q9, q9, q13
	vadd.i16	q4, q11, q1
	vsub.i16	q1, q1, q11
	.syntax divided
@ 105 "dctv2.c" 1
	@ Begin R6
@ 0 "" 2
	.arm
	.syntax unified
	vmov.i16	q11, #17  @ v8hi
	vadd.i16	q3, q10, q9
	vmov.i16	q12, #24  @ v8hi
	vmul.i16	q3, q3, q11
	vmov	q0, q3  @ v8hi
	vmla.i16	q0, q12, q10
	vmov.i16	q10, #65477  @ v8hi
	vmla.i16	q3, q10, q9
	vrshr.s16	q0, q0, #5
	vrshr.s16	q3, q3, #5
	.syntax divided
@ 120 "dctv2.c" 1
	@ End R6
@ 0 "" 2
	.arm
	.syntax unified
	vmov.i16	q15, #27  @ v8hi
	vadd.i16	q10, q6, q8
	vmov.i16	q13, #65527  @ v8hi
	vadd.i16	q9, q5, q7
	vmov.i16	q14, #31  @ v8hi
	vmov.i16	q12, #65511  @ v8hi
	vmov.i16	q11, #45  @ v8hi
	vmul.i16	q10, q10, q15
	vmul.i16	q9, q9, q14
	vmov	q2, q10  @ v8hi
	vmla.i16	q2, q13, q8
	vmov	q8, q2  @ v8hi
	vmov.i16	q2, #65492  @ v8hi
	vmla.i16	q10, q2, q6
	vmov	q6, q9  @ v8hi
	vmov.i16	q2, #65498  @ v8hi
	vmla.i16	q9, q12, q7
	vshr.s16	q8, q8, #5
	vmla.i16	q6, q2, q5
	vshr.s16	q10, q10, #5
	vrshr.s16	q9, q9, #5
	vrshr.s16	q6, q6, #5
	vadd.i16	q7, q9, q10
	vadd.i16	q2, q6, q8
	vadd.i16	q5, q7, q2
	vsub.i16	q2, q7, q2
	.syntax divided
@ 168 "dctv2.c" 1
	@ Begin Sqrt(2) Scaling
@ 0 "" 2
	.arm
	.syntax unified
	vsub.i16	q9, q10, q9
	vsub.i16	q8, q8, q6
	vmul.i16	q9, q9, q11
	vmul.i16	q8, q8, q11
	vrshr.s16	q9, q9, #5
	vrshr.s16	q8, q8, #5
	.syntax divided
@ 173 "dctv2.c" 1
	@ End Sqrt(2) Scaling
@ 0 "" 2
	.arm
	.syntax unified
	vtrn.16	q4, q5
	add	r1, sp, #64
	vtrn.16	q0, q9
	vtrn.16	q1, q8
	vtrn.16	q3, q2
	vmov	q10, q5  @ v8hi
	vmov	q6, q9  @ v4si
	vtrn.32	q4, q1
	vtrn.32	q0, q3
	vmov	q5, q10  @ v4si
	vtrn.32	q6, q2
	vzip.32	q4, q0
	vzip.32	q1, q3
	vmov	q9, q6  @ v4si
	vtrn.32	q5, q8
	vst1.64	{d0-d1}, [sp:64]
	vzip.32	q8, q2
	vmov	q10, q5  @ v4si
	vld1.64	{d0-d1}, [sp:64]
	vstr	d2, [sp, #16]
	vstr	d3, [sp, #24]
	vmov	q7, q4  @ v4si
	vzip.32	q10, q9
	vmov	q1, q8  @ v4si
	vldr	d16, [sp, #16]
	vldr	d17, [sp, #24]
	vmov	q4, q2  @ v4si
	vsub.i16	q6, q10, q3
	vadd.i16	q3, q3, q10
	vsub.i16	q10, q7, q4
	vadd.i16	q4, q4, q7
	vsub.i16	q7, q1, q0
	vadd.i16	q0, q0, q1
	vsub.i16	q5, q8, q9
	vadd.i16	q1, q9, q8
	vadd.i16	q9, q10, q7
	vadd.i16	q8, q6, q5
	vsub.i16	q2, q3, q1
	vadd.i16	q3, q3, q1
	vmul.i16	q15, q9, q15
	vsub.i16	q9, q4, q0
	vadd.i16	q4, q4, q0
	vmul.i16	q14, q8, q14
	vmov.i16	q8, #17  @ v8hi
	vadd.i16	q1, q2, q9
	vmov	q0, q15  @ v8hi
	vmul.i16	q1, q1, q8
	vmla.i16	q0, q10, q13
	vadd.i16	q10, q4, q3
	vsub.i16	q4, q4, q3
	vmov.i16	q3, #65492  @ v8hi
	vshr.s16	q4, q4, #3
	vmla.i16	q15, q7, q3
	vmov.i16	q3, #65498  @ v8hi
	vmov	q13, q0  @ v8hi
	vmov	q0, q14  @ v8hi
	vmla.i16	q14, q5, q3
	vrshr.s16	q13, q13, #5
	vmla.i16	q0, q6, q12
	vshr.s16	q6, q10, #3
	vrshr.s16	q15, q15, #5
	vmov	q10, q1  @ v8hi
	vst1.16	{d12-d13}, [r1:64]
	add	r1, sp, #80
	vrshr.s16	q14, q14, #5
	vst1.16	{d8-d9}, [r1:64]
	vrshr.s16	q12, q0, #5
	vadd.i16	q5, q15, q12
	vsub.i16	q8, q15, q12
	vmov.i16	q12, #24  @ v8hi
	vmul.i16	q8, q8, q11
	vmla.i16	q10, q9, q12
	vmov.i16	q12, #65477  @ v8hi
	vsub.i16	q9, q13, q14
	vadd.i16	q13, q13, q14
	vmla.i16	q1, q2, q12
	vrshr.s16	q8, q8, #5
	vmul.i16	q11, q9, q11
	vsub.i16	q12, q5, q13
	vrshr.s16	q9, q10, #5
	vadd.i16	q5, q13, q5
	vshr.s16	q8, q8, #3
	vshr.s16	q12, q12, #3
	vrshr.s16	q7, q1, #5
	vshr.s16	q9, q9, #3
	vrshr.s16	q11, q11, #5
	vshr.s16	q5, q5, #3
	vst1.16	{d24-d25}, [r2:64]
	add	r2, sp, #48
	vshr.s16	q7, q7, #3
	vst1.16	{d18-d19}, [r3:64]
	add	r3, sp, #32
	vshr.s16	q11, q11, #3
	vst1.64	{d18-d19}, [r3:64]
	add	r3, sp, #112
	vst1.64	{d24-d25}, [r2:64]
	vst1.16	{d14-d15}, [r3:64]
	add	r3, sp, #144
	vst1.64	{d22-d23}, [sp:64]
	vst1.16	{d16-d17}, [r3:64]
	add	r3, sp, #16
	vst1.64	{d16-d17}, [r3:64]
	add	r3, sp, #176
	vst1.16	{d10-d11}, [r3:64]
	add	r3, sp, #160
	vst1.16	{d22-d23}, [r3:64]
	bl	clock
	sub	r1, r0, r4
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	printf
	movw	r0, #:lower16:.LC3
	movt	r0, #:upper16:.LC3
	bl	puts
	vmov	q0, q6  @ v8hi
	bl	debug
	vmov	q0, q4  @ v8hi
	bl	debug
	add	r3, sp, #32
	vld1.64	{d18-d19}, [r3:64]
	vmov	q0, q9  @ v8hi
	bl	debug
	vmov	q0, q7  @ v8hi
	bl	debug
	add	r3, sp, #48
	vld1.64	{d24-d25}, [r3:64]
	vmov	q0, q12  @ v8hi
	bl	debug
	add	r3, sp, #16
	vld1.64	{d16-d17}, [r3:64]
	vmov	q0, q8  @ v8hi
	bl	debug
	vld1.64	{d22-d23}, [sp:64]
	vmov	q0, q11  @ v8hi
	bl	debug
	vmov	q0, q5  @ v8hi
	bl	debug
	mov	r0, #0
	add	sp, sp, #192
	@ sp needed
	vldm	sp!, {d8-d15}
	ldr	r4, [sp]
	add	sp, sp, #4
	ldr	pc, [sp], #4
	.size	main, .-main
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
.LC0:
	.short	1
	.short	2
	.short	3
	.short	4
	.short	5
	.short	6
	.short	7
	.short	8
	.short	1
	.short	2
	.short	3
	.short	4
	.short	5
	.short	6
	.short	7
	.short	8
	.short	1
	.short	2
	.short	3
	.short	4
	.short	5
	.short	6
	.short	7
	.short	8
	.short	1
	.short	2
	.short	3
	.short	4
	.short	5
	.short	6
	.short	7
	.short	8
	.short	1
	.short	2
	.short	3
	.short	4
	.short	5
	.short	6
	.short	7
	.short	8
	.short	1
	.short	2
	.short	3
	.short	4
	.short	5
	.short	6
	.short	7
	.short	8
	.short	1
	.short	2
	.short	3
	.short	4
	.short	5
	.short	6
	.short	7
	.short	8
	.short	1
	.short	2
	.short	3
	.short	4
	.short	5
	.short	6
	.short	7
	.short	8
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"%d\011\000"
.LC2:
	.ascii	"%d\012\000"
.LC3:
	.ascii	"Final DCT Output:\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
