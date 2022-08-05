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
	@ args = 0, pretend = 0, frame = 240
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	vpush.64	{d8, d9, d10, d11, d12, d13, d14, d15}
	sub	sp, sp, #244
	.syntax divided
@ 71 "dctv2.c" 1
	@test
@ 0 "" 2
	.arm
	.syntax unified
	movw	r1, #:lower16:.LANCHOR0
	add	r0, sp, #112
	movt	r1, #:upper16:.LANCHOR0
	mov	r2, #128
	bl	memcpy
	add	r3, sp, #144
	add	r2, sp, #112
	vldr	d6, .L8
	movw	r0, #:lower16:.LC3
	vld4.16	{d24, d26, d28, d30}, [r3:64]
	movt	r0, #:upper16:.LC3
	vld4.16	{d16, d18, d20, d22}, [r2:64]
	add	r2, sp, #176
	vld4.16	{d25, d27, d29, d31}, [r2:64]
	vld4.16	{d17, d19, d21, d23}, [r3:64]
	add	r3, sp, #96
	vmov	q7, q12  @ v8hi
	vmov	q1, q15  @ v8hi
	vmov	q4, q13  @ v8hi
	vmov	q0, q14  @ v8hi
	vmov	q5, q8  @ v8hi
	vmov	q2, q11  @ v8hi
	vmov	q6, q9  @ v8hi
	vmov	q8, q10  @ v8hi
	vmov.i16	q14, #31  @ v8hi
	vuzp.16	q5, q7
	vuzp.16	q2, q1
	vuzp.16	q6, q4
	vuzp.16	q8, q0
	vsub.i16	q11, q5, q1
	vsub.i16	q9, q2, q7
	vadd.i16	q2, q2, q7
	vadd.i16	q5, q1, q5
	vmov.i16	q1, #65527  @ v8hi
	vsub.i16	q7, q6, q0
	vsub.i16	q12, q8, q4
	vadd.i16	q13, q9, q11
	vadd.i16	q4, q8, q4
	vmov.i16	q8, #27  @ v8hi
	vadd.i16	q0, q0, q6
	vsub.i16	q15, q5, q2
	vmov.i16	q6, #65511  @ v8hi
	vadd.i16	q10, q12, q7
	vadd.i16	q5, q2, q5
	vmul.i16	q13, q13, q8
	vmul.i16	q10, q10, q14
	vsub.i16	q14, q0, q4
	vadd.i16	q0, q4, q0
	vmov.i16	q4, #65492  @ v8hi
	vadd.i16	q8, q15, q14
	vmov	q2, q13  @ v8hi
	vmla.i16	q13, q9, q4
	vmov	q9, q10  @ v8hi
	vmla.i16	q2, q11, q1
	vmla.i16	q9, q7, q6
	vadd.i16	q7, q0, q5
	vsub.i16	q5, q5, q0
	vshr.s16	q2, q2, #5
	vmov	q11, q9  @ v8hi
	vmov.i16	q9, #65498  @ v8hi
	vmla.i16	q10, q12, q9
	vmov.i16	q12, #17  @ v8hi
	vshr.s16	q9, q13, #5
	vshr.s16	q13, q11, #5
	vmov.i16	q11, #65477  @ v8hi
	vmul.i16	q8, q8, q12
	vmov.i16	q12, #24  @ v8hi
	vsub.i16	q6, q9, q13
	vadd.i16	q13, q13, q9
	vshr.s16	q10, q10, #5
	vst1.64	{d24-d25}, [r3:64]
	add	r3, sp, #80
	vmul.i16	q6, q6, d6[0]
	vmov	q9, q8  @ v8hi
	vmla.i16	q8, q14, q11
	vsub.i16	q4, q2, q10
	vadd.i16	q10, q10, q2
	vst1.64	{d22-d23}, [r3:64]
	add	r3, sp, #48
	vmla.i16	q9, q15, q12
	vadd.i16	q11, q13, q10
	vsub.i16	q10, q13, q10
	vshr.s16	q6, q6, #5
	vrshr.s16	q8, q8, #5
	vmul.i16	q4, q4, d6[0]
	vst1.64	{d20-d21}, [sp:64]
	vrshr.s16	q9, q9, #5
	vstr	d22, [sp, #32]
	vstr	d23, [sp, #40]
	vshr.s16	q4, q4, #5
	vst1.64	{d18-d19}, [r3:64]
	add	r3, sp, #16
	vst1.64	{d16-d17}, [r3:64]
	bl	puts
	vmov	q0, q7  @ v8hi
	bl	debug
	vmov	q0, q5  @ v8hi
	bl	debug
	add	r3, sp, #48
	vld1.64	{d18-d19}, [r3:64]
	vmov	q0, q9  @ v8hi
	bl	debug
	add	r3, sp, #16
	vld1.64	{d16-d17}, [r3:64]
	add	r3, sp, #48
	vmov	q0, q8  @ v8hi
	vst1.64	{d16-d17}, [r3:64]
	bl	debug
	vld1.64	{d0-d1}, [sp:64]
	bl	debug
	vmov	q0, q6  @ v8hi
	vstr	d12, [sp, #16]
	vstr	d13, [sp, #24]
	bl	debug
	vmov	q0, q4  @ v8hi
	bl	debug
	vldr	d12, [sp, #32]
	vldr	d13, [sp, #40]
	vmov	q0, q6  @ v8hi
	bl	debug
	add	r3, sp, #48
	vmov	q0, q4  @ v8hi
	vmov	q14, q6  @ v8hi
	vld1.64	{d18-d19}, [sp:64]
	vmov.i16	q12, #17  @ v8hi
	movw	r0, #:lower16:.LC4
	vld1.64	{d16-d17}, [r3:64]
	add	r3, sp, #64
	vtrn.16	q7, q14
	movt	r0, #:upper16:.LC4
	vldr	d12, [sp, #16]
	vldr	d13, [sp, #24]
	vtrn.16	q5, q0
	vldr	d6, .L8
	vmov	q15, q7  @ v8hi
	vmov	q2, q5  @ v8hi
	vmov	q13, q8  @ v8hi
	vtrn.16	q8, q9
	vtrn.32	q15, q2
	vtrn.16	q13, q6
	vmov	q7, q15  @ v4si
	vmov	q5, q2  @ v4si
	vmov	q2, q14  @ v4si
	vtrn.32	q13, q8
	vmov	q1, q6  @ v4si
	vmov	q11, q5  @ v4si
	vtrn.32	q2, q0
	vmov	q15, q13  @ v4si
	vmov	q13, q7  @ v4si
	vtrn.32	q1, q9
	vzip.32	q11, q8
	vmov	q14, q2  @ v4si
	vzip.32	q13, q15
	vzip.32	q14, q1
	vmov	q4, q15  @ v4si
	vmov	q15, q0  @ v4si
	vmov	q6, q1  @ v4si
	vzip.32	q15, q9
	vsub.i16	q7, q11, q6
	vadd.i16	q5, q6, q11
	vmov.i16	q11, #27  @ v8hi
	vmov.i16	q6, #65511  @ v8hi
	vsub.i16	q2, q15, q4
	vsub.i16	q1, q13, q9
	vadd.i16	q10, q9, q13
	vadd.i16	q0, q4, q15
	vsub.i16	q15, q14, q8
	vadd.i16	q8, q8, q14
	vmov.i16	q14, #31  @ v8hi
	vadd.i16	q9, q1, q2
	vadd.i16	q4, q15, q7
	vadd.i16	q13, q8, q5
	vmul.i16	q9, q9, q11
	vmov.i16	q11, #65527  @ v8hi
	vmul.i16	q4, q4, q14
	vsub.i16	q14, q8, q5
	vst1.64	{d26-d27}, [r3:64]
	add	r3, sp, #48
	vmov	q8, q9  @ v8hi
	vmla.i16	q8, q1, q11
	vsub.i16	q1, q10, q0
	vadd.i16	q0, q10, q0
	vmov.i16	q10, #65492  @ v8hi
	vadd.i16	q5, q14, q1
	vst1.64	{d0-d1}, [r3:64]
	add	r3, sp, #96
	vsub.i16	q11, q0, q13
	vmla.i16	q9, q2, q10
	vmov	q2, q4  @ v8hi
	vmov.i16	q10, #65498  @ v8hi
	vmul.i16	q5, q5, q12
	vshr.s16	q8, q8, #5
	vld1.64	{d24-d25}, [r3:64]
	add	r3, sp, #80
	vmla.i16	q2, q15, q6
	vst1.64	{d22-d23}, [sp:64]
	vld1.64	{d22-d23}, [r3:64]
	add	r3, sp, #32
	vmla.i16	q4, q7, q10
	vshr.s16	q15, q9, #5
	vmov	q9, q5  @ v8hi
	vshr.s16	q2, q2, #5
	vmla.i16	q9, q1, q12
	vshr.s16	q4, q4, #5
	vmla.i16	q5, q14, q11
	vsub.i16	q7, q15, q2
	vadd.i16	q15, q15, q2
	vsub.i16	q6, q8, q4
	vadd.i16	q4, q8, q4
	vmul.i16	q7, q7, d6[0]
	vshr.s16	q12, q9, #5
	vadd.i16	q10, q4, q15
	vsub.i16	q4, q15, q4
	vmul.i16	q6, q6, d6[0]
	vshr.s16	q5, q5, #5
	vst1.64	{d20-d21}, [r3:64]
	add	r3, sp, #16
	vshr.s16	q7, q7, #5
	vst1.64	{d24-d25}, [r3:64]
	vshr.s16	q6, q6, #5
	bl	puts
	add	r3, sp, #48
	vld1.64	{d0-d1}, [r3:64]
	add	r3, sp, #64
	vld1.64	{d26-d27}, [r3:64]
	vadd.i16	q0, q0, q13
	vshr.s16	q0, q0, #3
	bl	debug
	vld1.64	{d0-d1}, [sp:64]
	bl	debug
	add	r3, sp, #16
	vld1.64	{d24-d25}, [r3:64]
	vmov	q0, q12  @ v8hi
	bl	debug
	vmov	q0, q5  @ v8hi
	bl	debug
	vmov	q0, q4  @ v8hi
	bl	debug
	b	.L9
.L10:
	.align	3
.L8:
	.short	45
	.short	0
	.short	0
	.short	0
.L9:
	vmov	q0, q7  @ v8hi
	bl	debug
	vmov	q0, q6  @ v8hi
	bl	debug
	add	r3, sp, #32
	vld1.64	{d20-d21}, [r3:64]
	vmov	q0, q10  @ v8hi
	bl	debug
	mov	r0, #0
	add	sp, sp, #244
	@ sp needed
	vldm	sp!, {d8-d15}
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
	.ascii	"Completed Horizontal DCT:\000"
	.space	2
.LC4:
	.ascii	"Completed Vertical DCT:\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
