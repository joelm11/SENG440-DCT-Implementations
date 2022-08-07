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
	.align	2
	.global	debug2
	.syntax unified
	.arm
	.fpu neon-vfpv4
	.type	debug2, %function
debug2:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	strd	r4, [sp, #-24]!
	movw	r4, #:lower16:.LC1
	strd	r6, [sp, #8]
	movt	r4, #:upper16:.LC1
	str	r8, [sp, #16]
	mov	r0, r4
	vmov.32	r8, d0[0]
	vmov.32	r7, d0[1]
	vmov.32	r6, d1[0]
	vmov.32	r5, d1[1]
	str	lr, [sp, #20]
	asr	r1, r8, #16
	bl	printf
	uxth	r1, r8
	mov	r0, r4
	bl	printf
	asr	r1, r7, #16
	mov	r0, r4
	bl	printf
	uxth	r1, r7
	mov	r0, r4
	bl	printf
	asr	r1, r6, #16
	mov	r0, r4
	bl	printf
	uxth	r1, r6
	mov	r0, r4
	bl	printf
	asr	r1, r5, #16
	mov	r0, r4
	bl	printf
	movw	r0, #:lower16:.LC2
	uxth	r1, r5
	ldrd	r4, [sp]
	movt	r0, #:upper16:.LC2
	ldrd	r6, [sp, #8]
	ldr	r8, [sp, #16]
	ldr	lr, [sp, #20]
	add	sp, sp, #24
	b	printf
	.size	debug2, .-debug2
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon-vfpv4
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 208
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r1, #:lower16:.LANCHOR0
	str	lr, [sp, #-4]!
	mov	r2, #128
	vpush.64	{d8, d9, d10, d11, d12, d13, d14, d15}
	sub	sp, sp, #212
	movt	r1, #:upper16:.LANCHOR0
	add	r0, sp, #80
	bl	memcpy
	add	r3, sp, #112
	add	r2, sp, #80
	vld4.16	{d0, d2, d4, d6}, [r3:64]
	vld4.16	{d16, d18, d20, d22}, [r2:64]
	add	r2, sp, #144
	vld4.16	{d1, d3, d5, d7}, [r2:64]
	vld4.16	{d17, d19, d21, d23}, [r3:64]
	vmov	q13, q0  @ v8hi
	vmov	q12, q1  @ v8hi
	vmov	q4, q2  @ v8hi
	vmov	q5, q3  @ v8hi
	vmov	q7, q8  @ v8hi
	vmov	q6, q9  @ v8hi
	vmov	q15, q10  @ v8hi
	vmov	q14, q11  @ v8hi
	vuzp.16	q7, q13
	vuzp.16	q6, q12
	vuzp.16	q15, q4
	vuzp.16	q14, q5
	.syntax divided
@ 117 "dctv2.c" 1
	@ Begin Stage 1
@ 0 "" 2
	.arm
	.syntax unified
	vadd.i16	q11, q15, q12
	vadd.i16	q1, q4, q6
	vsub.i16	q12, q15, q12
	vadd.i16	q10, q5, q7
	vadd.i16	q15, q14, q13
	vsub.i16	q9, q7, q5
	vsub.i16	q6, q6, q4
	vsub.i16	q14, q14, q13
	.syntax divided
@ 126 "dctv2.c" 1
	@ End Stage 1
@ 0 "" 2
	.arm
	.syntax unified
	vadd.i16	q13, q15, q10
	vadd.i16	q8, q11, q1
	vsub.i16	q10, q10, q15
	vsub.i16	q1, q1, q11
	vadd.i16	q0, q8, q13
	vsub.i16	q13, q13, q8
	.syntax divided
@ 136 "dctv2.c" 1
	@ Begin R6
@ 0 "" 2
	.arm
	.syntax unified
	vmov.i16	q8, #65477  @ v8hi
	vadd.i16	q10, q10, q1
	vmov.i16	q5, #17  @ v8hi
	vmul.i16	q1, q8, q1
	vmla.i16	q1, q10, q5
	vrshr.s16	q1, q1, #5
	.syntax divided
@ 148 "dctv2.c" 1
	@ End R6
@ 0 "" 2
	.arm
	.syntax unified
	vmov.i16	q4, #27  @ v8hi
	vadd.i16	q11, q14, q9
	vldr	d5, .L8
	vmov.i16	q10, #65527  @ v8hi
	vadd.i16	q8, q12, q6
	add	r3, sp, #64
	vmov.i16	q7, #31  @ v8hi
	vmov.i16	q3, #65498  @ v8hi
	movw	r0, #:lower16:.LC3
	movt	r0, #:upper16:.LC3
	vmul.i16	q11, q11, q4
	vmul.i16	q8, q8, q7
	vmov	q15, q11  @ v8hi
	vmla.i16	q15, q10, q9
	vmov	q9, q15  @ v8hi
	vmov.i16	q15, #65492  @ v8hi
	vmla.i16	q11, q15, q14
	vmov	q14, q8  @ v8hi
	vshr.s16	q9, q9, #5
	vmla.i16	q14, q3, q12
	vmov.i16	q12, #65511  @ v8hi
	vshr.s16	q11, q11, #5
	vmla.i16	q8, q12, q6
	vshr.s16	q14, q14, #5
	vshr.s16	q8, q8, #5
	vsub.i16	q6, q9, q14
	vadd.i16	q14, q14, q9
	vmul.i16	q6, q6, d5[0]
	vsub.i16	q9, q11, q8
	vadd.i16	q8, q8, q11
	vmul.i16	q9, q9, d5[0]
	vadd.i16	q12, q8, q14
	vsub.i16	q3, q8, q14
	vshr.s16	q6, q6, #5
	vmov	q11, q12  @ v8hi
	vmov	q12, q1  @ v8hi
	vtrn.16	q13, q6
	vtrn.16	q12, q3
	vtrn.16	q0, q11
	vmov	q8, q12  @ v8hi
	vshr.s16	q12, q9, #5
	vmov	q14, q0  @ v8hi
	vmov	q0, q11  @ v4si
	vst1.64	{d6-d7}, [sp:64]
	vld1.64	{d6-d7}, [sp:64]
	vmov	q9, q12  @ v8hi
	vtrn.32	q14, q13
	vtrn.32	q0, q6
	vtrn.16	q1, q9
	vmov	q2, q14  @ v4si
	vmov	q11, q0  @ v4si
	vmov	q12, q1  @ v4si
	vtrn.32	q12, q8
	vmov	q14, q8  @ v4si
	vmov	q8, q9  @ v4si
	vzip.32	q2, q12
	vtrn.32	q8, q3
	vzip.32	q13, q14
	vmov	q0, q3  @ v4si
	vmov	q1, q2  @ v4si
	vldr	d7, .L8
	vzip.32	q11, q8
	vzip.32	q6, q0
	vmov	q9, q8  @ v4si
	vsub.i16	q2, q11, q14
	vadd.i16	q11, q14, q11
	vmov	q8, q6  @ v4si
	vsub.i16	q6, q1, q0
	vadd.i16	q0, q0, q1
	vsub.i16	q14, q13, q9
	vsub.i16	q1, q8, q12
	vadd.i16	q12, q12, q8
	vadd.i16	q8, q9, q13
	vadd.i16	q9, q6, q1
	vsub.i16	q13, q0, q12
	vadd.i16	q0, q0, q12
	vsub.i16	q12, q11, q8
	vadd.i16	q11, q11, q8
	vmul.i16	q9, q9, q4
	vadd.i16	q4, q2, q14
	vadd.i16	q8, q12, q13
	vst1.64	{d22-d23}, [r3:64]
	add	r3, sp, #48
	vmul.i16	q7, q4, q7
	vst1.64	{d0-d1}, [r3:64]
	add	r3, sp, #32
	vmul.i16	q5, q8, q5
	vmov	q8, q9  @ v8hi
	vmla.i16	q9, q1, q15
	vmla.i16	q8, q6, q10
	vsub.i16	q10, q0, q11
	vmov	q15, q7  @ v8hi
	vst1.64	{d20-d21}, [r3:64]
	vmov.i16	q10, #65511  @ v8hi
	add	r3, sp, #16
	vshr.s16	q4, q9, #5
	vmov.i16	q9, #65477  @ v8hi
	vshr.s16	q8, q8, #5
	vmla.i16	q15, q2, q10
	vmov.i16	q10, #65498  @ v8hi
	vmov	q2, q5  @ v8hi
	vmla.i16	q5, q12, q9
	vmla.i16	q7, q14, q10
	vmov.i16	q10, #24  @ v8hi
	vshr.s16	q15, q15, #5
	vmla.i16	q2, q13, q10
	vshr.s16	q5, q5, #5
	vshr.s16	q12, q7, #5
	vsub.i16	q7, q4, q15
	vadd.i16	q4, q4, q15
	vsub.i16	q6, q8, q12
	vadd.i16	q12, q8, q12
	vshr.s16	q2, q2, #5
	vmul.i16	q7, q7, d7[0]
	vmul.i16	q6, q6, d7[0]
	vadd.i16	q9, q12, q4
	vsub.i16	q4, q4, q12
	vst1.64	{d4-d5}, [r3:64]
	vst1.64	{d18-d19}, [sp:64]
	vshr.s16	q7, q7, #5
	bl	puts
	add	r3, sp, #48
	vshr.s16	q6, q6, #5
	vld1.64	{d0-d1}, [r3:64]
	add	r3, sp, #64
	vld1.64	{d22-d23}, [r3:64]
	vadd.i16	q0, q0, q11
	vshr.s16	q0, q0, #3
	bl	debug
	add	r3, sp, #32
	vld1.64	{d20-d21}, [r3:64]
	vmov	q0, q10  @ v8hi
	bl	debug
	add	r3, sp, #16
	vld1.64	{d4-d5}, [r3:64]
	vmov	q0, q2  @ v8hi
	bl	debug
	vmov	q0, q5  @ v8hi
	bl	debug
	vmov	q0, q4  @ v8hi
	bl	debug
	vmov	q0, q7  @ v8hi
	bl	debug
	vmov	q0, q6  @ v8hi
	bl	debug
	vld1.64	{d18-d19}, [sp:64]
	vmov	q0, q9  @ v8hi
	bl	debug
	mov	r0, #0
	add	sp, sp, #212
	@ sp needed
	vldm	sp!, {d8-d15}
	ldr	pc, [sp], #4
.L9:
	.align	3
.L8:
	.short	45
	.short	0
	.short	0
	.short	0
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
	.ascii	"Completed Vertical DCT:\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
