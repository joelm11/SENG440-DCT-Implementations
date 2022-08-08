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
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.arch armv7ve
	.syntax unified
	.arm
	.fpu neon-vfpv4
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 168
	@ frame_needed = 0, uses_anonymous_args = 0
	strd	r4, [sp, #-12]!
	str	lr, [sp, #8]
	vpush.64	{d8, d9, d10, d11, d12, d13, d14, d15}
	sub	sp, sp, #172
	bl	clock
	mov	r4, r0
	bl	clock
	movw	r1, #:lower16:.LANCHOR0
	mov	r2, #128
	str	r0, [sp, #4]
	movt	r1, #:upper16:.LANCHOR0
	add	r0, sp, #40
	bl	memcpy
	add	r3, sp, #72
	add	r2, sp, #40
	vld4.16	{d0, d2, d4, d6}, [r3:64]
	vld4.16	{d16, d18, d20, d22}, [r2:64]
	add	r2, sp, #104
	vld4.16	{d1, d3, d5, d7}, [r2:64]
	vld4.16	{d17, d19, d21, d23}, [r3:64]
	vmov	q13, q0  @ v8hi
	vmov	q12, q1  @ v8hi
	vmov	q15, q2  @ v8hi
	vmov	q5, q3  @ v8hi
	vmov	q7, q8  @ v8hi
	vmov	q4, q9  @ v8hi
	vmov	q14, q10  @ v8hi
	vmov	q6, q11  @ v8hi
	vuzp.16	q7, q13
	vuzp.16	q4, q12
	vuzp.16	q14, q15
	vuzp.16	q6, q5
	.syntax divided
@ 66 "dctv2.c" 1
	@ Begin Stage 1
@ 0 "" 2
	.arm
	.syntax unified
	vadd.i16	q8, q5, q7
	vadd.i16	q11, q15, q4
	vsub.i16	q9, q4, q15
	vsub.i16	q7, q7, q5
	vadd.i16	q15, q14, q12
	vsub.i16	q12, q14, q12
	vadd.i16	q14, q6, q13
	vsub.i16	q6, q6, q13
	.syntax divided
@ 75 "dctv2.c" 1
	@ End Stage 1
@ 0 "" 2
	.arm
	.syntax unified
	vadd.i16	q0, q14, q8
	vadd.i16	q13, q15, q11
	vsub.i16	q8, q8, q14
	vsub.i16	q11, q11, q15
	vadd.i16	q5, q13, q0
	vsub.i16	q0, q0, q13
	.syntax divided
@ 85 "dctv2.c" 1
	@ Begin R6
@ 0 "" 2
	.arm
	.syntax unified
	vmov.i16	q10, #65477  @ v8hi
	vadd.i16	q8, q8, q11
	vmov.i16	q13, #17  @ v8hi
	vmul.i16	q11, q10, q11
	vmla.i16	q11, q8, q13
	vrshr.s16	q11, q11, #5
	.syntax divided
@ 101 "dctv2.c" 1
	@ End R6
@ 0 "" 2
	.arm
	.syntax unified
	vmov.i16	q1, #27  @ v8hi
	vadd.i16	q4, q6, q7
	vadd.i16	q8, q12, q9
	vmov.i16	q2, #31  @ v8hi
	vmov.i16	q3, #65527  @ v8hi
	vmov.i16	q15, #65492  @ v8hi
	vmov.i16	q14, #65511  @ v8hi
	vmov.i16	q13, #45  @ v8hi
	vmul.i16	q4, q4, q1
	vmul.i16	q8, q8, q2
	vmov	q10, q4  @ v8hi
	vmla.i16	q4, q15, q6
	vmov	q6, q8  @ v8hi
	vmla.i16	q8, q14, q9
	vmla.i16	q10, q3, q7
	vmov.i16	q7, #65498  @ v8hi
	vshr.s16	q4, q4, #5
	vmla.i16	q6, q7, q12
	vrshr.s16	q8, q8, #5
	vshr.s16	q10, q10, #5
	vadd.i16	q7, q8, q4
	vrshr.s16	q6, q6, #5
	vadd.i16	q9, q6, q10
	vadd.i16	q12, q7, q9
	vsub.i16	q9, q7, q9
	.syntax divided
@ 151 "dctv2.c" 1
	@ Begin Sqrt(2) Scaling
@ 0 "" 2
	.arm
	.syntax unified
	vsub.i16	q8, q4, q8
	vsub.i16	q10, q10, q6
	vmul.i16	q8, q8, q13
	vmul.i16	q10, q10, q13
	vrshr.s16	q7, q8, #5
	vrshr.s16	q10, q10, #5
	.syntax divided
@ 156 "dctv2.c" 1
	@ End Sqrt(2) Scaling
@ 0 "" 2
	.arm
	.syntax unified
	vtrn.16	q0, q10
	add	r1, sp, #40
	vmov	q8, q7  @ v8hi
	vtrn.16	q5, q12
	vmov	q6, q0  @ v8hi
	vmov	q0, q11  @ v8hi
	vtrn.16	q11, q9
	vmov	q4, q5  @ v8hi
	vtrn.16	q0, q8
	vstr	d18, [sp, #8]
	vstr	d19, [sp, #16]
	vmov	q9, q11  @ v8hi
	vmov	q7, q0  @ v8hi
	vmov	q0, q6  @ v4si
	vmov	q6, q12  @ v4si
	vtrn.32	q4, q0
	vtrn.32	q6, q10
	vmov	q5, q4  @ v4si
	vmov	q4, q7  @ v4si
	vmov	q7, q8  @ v4si
	vmov	q12, q6  @ v4si
	vtrn.32	q4, q9
	vmov	q11, q9  @ v4si
	vldr	d18, [sp, #8]
	vldr	d19, [sp, #16]
	vzip.32	q5, q4
	vzip.32	q0, q11
	vstr	d10, [sp, #8]
	vstr	d11, [sp, #16]
	vtrn.32	q7, q9
	vstr	d8, [sp, #24]
	vstr	d9, [sp, #32]
	vmov	q4, q0  @ v4si
	vmov	q0, q10  @ v4si
	vldr	d20, [sp, #24]
	vldr	d21, [sp, #32]
	vmov	q8, q9  @ v4si
	vldr	d18, [sp, #8]
	vldr	d19, [sp, #16]
	vzip.32	q0, q8
	vmov	q5, q8  @ v4si
	vmov	q8, q7  @ v4si
	vsub.i16	q6, q0, q10
	vadd.i16	q10, q10, q0
	vzip.32	q12, q8
	vsub.i16	q7, q9, q5
	vadd.i16	q5, q5, q9
	vsub.i16	q9, q12, q11
	vadd.i16	q11, q11, q12
	vsub.i16	q12, q4, q8
	vadd.i16	q8, q8, q4
	vadd.i16	q4, q7, q6
	vadd.i16	q0, q9, q12
	vmul.i16	q1, q4, q1
	vmul.i16	q2, q0, q2
	vsub.i16	q0, q11, q8
	vadd.i16	q11, q11, q8
	vsub.i16	q8, q5, q10
	vadd.i16	q5, q5, q10
	vmov	q4, q1  @ v8hi
	vmla.i16	q1, q6, q15
	vadd.i16	q15, q0, q8
	vadd.i16	q6, q5, q11
	vsub.i16	q11, q5, q11
	vmla.i16	q4, q7, q3
	vmov.i16	q7, #65498  @ v8hi
	vshr.s16	q6, q6, #3
	vshr.s16	q11, q11, #3
	vrshr.s16	q1, q1, #5
	vmov	q3, q4  @ v8hi
	vmov	q4, q2  @ v8hi
	vst1.16	{d12-d13}, [r1:64]
	vmla.i16	q2, q12, q7
	add	r1, sp, #56
	vmov.i16	q12, #24  @ v8hi
	vst1.16	{d22-d23}, [r1:64]
	vmov.i16	q11, #65477  @ v8hi
	vmla.i16	q4, q9, q14
	vmov.i16	q9, #17  @ v8hi
	vrshr.s16	q3, q3, #5
	vmul.i16	q15, q15, q9
	vrshr.s16	q2, q2, #5
	vrshr.s16	q14, q4, #5
	vmov	q10, q15  @ v8hi
	vsub.i16	q9, q1, q14
	vmla.i16	q15, q0, q11
	vadd.i16	q1, q1, q14
	vmla.i16	q10, q8, q12
	vsub.i16	q8, q3, q2
	vadd.i16	q3, q3, q2
	vmul.i16	q9, q9, q13
	vmul.i16	q13, q8, q13
	vrshr.s16	q15, q15, #5
	vsub.i16	q11, q1, q3
	vadd.i16	q3, q3, q1
	vrshr.s16	q10, q10, #5
	vshr.s16	q15, q15, #3
	vrshr.s16	q8, q9, #5
	vshr.s16	q3, q3, #3
	vshr.s16	q10, q10, #3
	vrshr.s16	q13, q13, #5
	vshr.s16	q8, q8, #3
	vshr.s16	q11, q11, #3
	vst1.16	{d20-d21}, [r3:64]
	add	r3, sp, #88
	vshr.s16	q13, q13, #3
	vst1.16	{d30-d31}, [r3:64]
	add	r3, sp, #120
	vst1.16	{d22-d23}, [r2:64]
	vst1.16	{d16-d17}, [r3:64]
	add	r3, sp, #152
	vst1.16	{d6-d7}, [r3:64]
	add	r3, sp, #136
	vst1.16	{d26-d27}, [r3:64]
	bl	clock
	vmov	s16, r0	@ int
	bl	clock
	vldr.32	s15, [sp, #4]	@ int
	mov	r5, r0
	movw	r0, #:lower16:.LC1
	vldr.32	s14, .L4
	movt	r0, #:upper16:.LC1
	vcvt.f32.s32	s16, s16
	vcvt.f32.s32	s15, s15
	vsub.f32	s16, s16, s15
	vmul.f32	s16, s16, s14
	vcvt.f64.f32	d16, s16
	vmov	r2, r3, d16
	bl	printf
	movw	r0, #:lower16:.LC2
	sub	r1, r5, r4
	movt	r0, #:upper16:.LC2
	bl	printf
	movw	r1, #16960
	movw	r0, #:lower16:.LC3
	movt	r1, 15
	movt	r0, #:upper16:.LC3
	bl	printf
	mov	r0, #0
	add	sp, sp, #172
	@ sp needed
	vldm	sp!, {d8-d15}
	ldrd	r4, [sp]
	add	sp, sp, #8
	ldr	pc, [sp], #4
.L5:
	.align	2
.L4:
	.word	897988541
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
	.ascii	"%f\012\000"
.LC2:
	.ascii	"%d\012\000"
.LC3:
	.ascii	"Frequency %ld\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
