	.arch armv4t
	.eabi_attribute 27, 3
	.fpu neon
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"dctv2.c"
	.global	O1_consts
	.data
	.align	1
	.type	O1_consts, %object
	.size	O1_consts, 6
O1_consts:
	.short	-25
	.short	-9
	.short	24
	.global	O2_consts
	.align	1
	.type	O2_consts, %object
	.size	O2_consts, 6
O2_consts:
	.short	-38
	.short	-44
	.short	-59
	.global	C
	.align	1
	.type	C, %object
	.size	C, 6
C:
	.short	31
	.short	27
	.short	17
	.text
	.align	2
	.global	trotator
	.type	trotator, %function
trotator:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	str	r2, [fp, #-24]
	str	r3, [fp, #-28]
	ldr	r3, [fp, #4]
	ldr	r2, .L3
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r1, r3, asr #16
	ldr	r3, [fp, #-16]
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r2, r3, asr #16
	ldr	r3, [fp, #-20]
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	add	r3, r2, r3
	mul	r3, r1, r3
	strh	r3, [fp, #-6]	@ movhi
	ldr	r3, [fp, #4]
	ldr	r2, .L3+4
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	ldrh	r3, [r3, #0]
	mul	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldrh	r3, [fp, #-6]
	add	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-10]	@ movhi
	ldr	r3, [fp, #4]
	ldr	r2, .L3+8
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	ldrh	r3, [r3, #0]
	mul	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldrh	r3, [fp, #-6]
	add	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-8]	@ movhi
	ldrsh	r3, [fp, #-10]
	mov	r3, r3, asr #5
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, [fp, #-24]
	strh	r2, [r3, #0]	@ movhi
	ldrsh	r3, [fp, #-8]
	mov	r3, r3, asr #5
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, [fp, #-28]
	strh	r2, [r3, #0]	@ movhi
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L4:
	.align	2
.L3:
	.word	C
	.word	O1_consts
	.word	O2_consts
	.size	trotator, .-trotator
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\011\000"
	.text
	.align	2
	.global	debug
	.type	debug, %function
debug:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 152
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #152
	vmov	d16, r0, r1  @ v8hi
	vmov	d17, r2, r3
	vstr	d16, [fp, #-156]
	vstr	d17, [fp, #-148]
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-132]
	vstr	d17, [fp, #-124]
	vldr	d16, [fp, #-132]
	vldr	d17, [fp, #-124]
	vmov.s16	r3, d16[0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-134]	@ movhi
	ldrsh	r3, [fp, #-134]
	ldr	r0, .L7
	mov	r1, r3
	bl	printf
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-116]
	vstr	d17, [fp, #-108]
	vldr	d16, [fp, #-116]
	vldr	d17, [fp, #-108]
	vmov.s16	r3, d16[1]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-134]	@ movhi
	ldrsh	r3, [fp, #-134]
	ldr	r0, .L7
	mov	r1, r3
	bl	printf
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-100]
	vstr	d17, [fp, #-92]
	vldr	d16, [fp, #-100]
	vldr	d17, [fp, #-92]
	vmov.s16	r3, d16[2]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-134]	@ movhi
	ldrsh	r3, [fp, #-134]
	ldr	r0, .L7
	mov	r1, r3
	bl	printf
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-84]
	vstr	d17, [fp, #-76]
	vldr	d16, [fp, #-84]
	vldr	d17, [fp, #-76]
	vmov.s16	r3, d16[3]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-134]	@ movhi
	ldrsh	r3, [fp, #-134]
	ldr	r0, .L7
	mov	r1, r3
	bl	printf
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-68]
	vstr	d17, [fp, #-60]
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vmov.s16	r3, d17[0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-134]	@ movhi
	ldrsh	r3, [fp, #-134]
	ldr	r0, .L7
	mov	r1, r3
	bl	printf
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-52]
	vstr	d17, [fp, #-44]
	vldr	d16, [fp, #-52]
	vldr	d17, [fp, #-44]
	vmov.s16	r3, d17[1]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-134]	@ movhi
	ldrsh	r3, [fp, #-134]
	ldr	r0, .L7
	mov	r1, r3
	bl	printf
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-36]
	vstr	d17, [fp, #-28]
	vldr	d16, [fp, #-36]
	vldr	d17, [fp, #-28]
	vmov.s16	r3, d17[2]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-134]	@ movhi
	ldrsh	r3, [fp, #-134]
	ldr	r0, .L7
	mov	r1, r3
	bl	printf
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-20]
	vstr	d17, [fp, #-12]
	vldr	d16, [fp, #-20]
	vldr	d17, [fp, #-12]
	vmov.s16	r3, d17[3]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-134]	@ movhi
	ldrsh	r3, [fp, #-134]
	ldr	r0, .L7
	mov	r1, r3
	bl	printf
	mov	r0, #10
	bl	putchar
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LC0
	.size	debug, .-debug
	.section	.rodata
	.align	2
.LC1:
	.ascii	"Passed value: %d\012\000"
	.text
	.align	2
	.global	test
	.type	test, %function
test:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	ldr	r0, .L11
	mov	r1, r3
	bl	printf
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L12:
	.align	2
.L11:
	.word	.LC1
	.size	test, .-test
	.section	.rodata
	.align	1
	.type	x1.19086, %object
	.size	x1.19086, 128
x1.19086:
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
	.align	2
.LC2:
	.ascii	"Initial inputs:\000"
	.align	2
.LC3:
	.ascii	"S1:\000"
	.align	2
.LC4:
	.ascii	"S2:\000"
	.align	2
.LC5:
	.ascii	"S3:\000"
	.align	2
.LC6:
	.ascii	"S4:\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 2848
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #2848
	ldr	r3, .L15
	str	r3, [fp, #-1476]
	ldr	r1, [fp, #-1476]
	str	r1, [fp, #-2844]
	ldr	r2, [fp, #-2844]
	vld4.16	{d16, d18, d20, d22}, [r2]!
	str	r2, [fp, #-2844]
	ldr	r3, [fp, #-2844]
	vld4.16	{d17, d19, d21, d23}, [r3]!
	mov	r3, #0
	sub	r3, r3, #2768
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d23}
	sub	lr, fp, #2512
	sub	lr, lr, #4
	sub	ip, fp, #2768
	sub	ip, ip, #4
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	ldr	r3, .L15+4
	str	r3, [fp, #-1472]
	ldr	r2, [fp, #-1472]
	str	r2, [fp, #-2848]
	ldr	r3, [fp, #-2848]
	vld4.16	{d16, d18, d20, d22}, [r3]!
	str	r3, [fp, #-2848]
	ldr	r1, [fp, #-2848]
	vld4.16	{d17, d19, d21, d23}, [r1]!
	mov	r3, #0
	sub	r3, r3, #2832
	sub	r2, fp, #4
	add	r3, r2, r3
	vstmia	r3, {d16-d23}
	sub	lr, fp, #2576
	sub	lr, lr, #4
	sub	ip, fp, #2832
	sub	ip, ip, #4
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	mov	r3, #0
	sub	r3, r3, #2512
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2576
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1440
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1456
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vstmia	r3, {d18-d19}
	sub	r2, fp, #2768
	sub	r2, r2, #4
	mvn	r3, #1440
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1456
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vmov	q10, q9  @ v8hi
	vmov	q11, q8  @ v8hi
	vuzp.16	q10, q11
	vmov	q9, q11  @ v8hi
	vmov	q8, q10  @ v8hi
	vstmia	r2, {d16-d17}
	vstr	d18, [r2, #16]
	vstr	d19, [r2, #24]
	sub	lr, fp, #2608
	sub	lr, lr, #4
	sub	ip, fp, #2768
	sub	ip, ip, #4
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	mov	r3, #-1308622848
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	mov	r3, #-1342177280
	mov	r3, r3, asr #19
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1408
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1424
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vstmia	r3, {d18-d19}
	sub	r2, fp, #2768
	sub	r2, r2, #4
	mvn	r3, #1408
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1424
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vmov	q10, q9  @ v8hi
	vmov	q11, q8  @ v8hi
	vuzp.16	q10, q11
	vmov	q9, q11  @ v8hi
	vmov	q8, q10  @ v8hi
	vstmia	r2, {d16-d17}
	vstr	d18, [r2, #16]
	vstr	d19, [r2, #24]
	sub	lr, fp, #2640
	sub	lr, lr, #4
	sub	ip, fp, #2768
	sub	ip, ip, #4
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	mov	r3, #0
	sub	r3, r3, #2480
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2544
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1376
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1392
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vstmia	r3, {d18-d19}
	sub	r2, fp, #2768
	sub	r2, r2, #4
	mvn	r3, #1376
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1392
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vmov	q10, q9  @ v8hi
	vmov	q11, q8  @ v8hi
	vuzp.16	q10, q11
	vmov	q9, q11  @ v8hi
	vmov	q8, q10  @ v8hi
	vstmia	r2, {d16-d17}
	vstr	d18, [r2, #16]
	vstr	d19, [r2, #24]
	sub	lr, fp, #2672
	sub	lr, lr, #4
	sub	ip, fp, #2768
	sub	ip, ip, #4
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	mov	r3, #-1291845632
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	mov	r3, #-1325400064
	mov	r3, r3, asr #19
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1344
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1360
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vstmia	r3, {d18-d19}
	sub	r2, fp, #2768
	sub	r2, r2, #4
	mvn	r3, #1344
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1360
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vmov	q10, q9  @ v8hi
	vmov	q11, q8  @ v8hi
	vuzp.16	q10, q11
	vmov	q9, q11  @ v8hi
	vmov	q8, q10  @ v8hi
	vstmia	r2, {d16-d17}
	vstr	d18, [r2, #16]
	vstr	d19, [r2, #24]
	sub	lr, fp, #2704
	sub	lr, lr, #4
	sub	ip, fp, #2768
	sub	ip, ip, #4
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	mov	r3, #0
	sub	r3, r3, #2448
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2608
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mov	r3, #-1275068416
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1358954496
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2416
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2640
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mov	r3, #-1258291200
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1375731712
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2384
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2672
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mov	r3, #-1241513984
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1392508928
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2352
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2704
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mov	r3, #-1224736768
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1409286144
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	ldr	r0, .L15+8
	bl	puts
	mov	r3, #0
	sub	r3, r3, #2448
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #0
	sub	r3, r3, #2416
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #0
	sub	r3, r3, #2384
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #0
	sub	r3, r3, #2352
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1275068416
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1258291200
	mov	r3, r3, asr #19
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1241513984
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1224736768
	mov	r3, r3, asr #19
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mvn	r3, #1312
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2448
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1328
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1224736768
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1312
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1328
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vadd.i16	q8, q9, q8
	mov	r3, #0
	sub	r3, r3, #2320
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1280
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2448
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1296
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1224736768
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1280
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1296
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vsub.i16	q8, q9, q8
	mov	r3, #-1207959552
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1248
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2416
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1264
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1241513984
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1248
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1264
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vadd.i16	q8, q9, q8
	mov	r3, #0
	sub	r3, r3, #2288
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1216
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2416
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1232
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1241513984
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1216
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1232
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vsub.i16	q8, q9, q8
	mov	r3, #-1191182336
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1184
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2384
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1200
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1258291200
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1184
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1200
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vadd.i16	q8, q9, q8
	mov	r3, #0
	sub	r3, r3, #2256
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1152
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2384
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1168
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1258291200
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1152
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1168
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vsub.i16	q8, q9, q8
	mov	r3, #-1174405120
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1120
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2352
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1136
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1275068416
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1120
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1136
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vadd.i16	q8, q9, q8
	mov	r3, #0
	sub	r3, r3, #2224
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1088
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2352
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1104
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #-1275068416
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1088
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1104
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vsub.i16	q8, q9, q8
	mov	r3, #-1157627904
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	ldr	r0, .L15+12
	bl	puts
	mov	r3, #0
	sub	r3, r3, #2320
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #0
	sub	r3, r3, #2288
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #0
	sub	r3, r3, #2256
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #0
	sub	r3, r3, #2224
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1157627904
	mov	r3, r3, asr #19
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1174405120
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1191182336
	mov	r3, r3, asr #19
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1207959552
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mvn	r3, #1056
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2320
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1072
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2224
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1056
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1072
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vadd.i16	q8, q9, q8
	mov	r3, #0
	sub	r3, r3, #2192
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #1024
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2288
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1040
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r2, r1, r3
	mov	r3, #0
	sub	r3, r3, #2256
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstmia	r2, {d16-d17}
	mvn	r3, #1024
	sub	r3, r3, #7
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d18-d19}
	mvn	r3, #1040
	sub	r3, r3, #7
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vadd.i16	q8, q9, q8
	mov	r3, #-1140850688
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2288
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-1004]
	vstr	d17, [fp, #-996]
	mov	r3, #0
	sub	r3, r3, #2256
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-1020]
	vstr	d17, [fp, #-1012]
	vldr	d18, [fp, #-1004]
	vldr	d19, [fp, #-996]
	vldr	d16, [fp, #-1020]
	vldr	d17, [fp, #-1012]
	vsub.i16	q8, q9, q8
	mov	r3, #0
	sub	r3, r3, #2160
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2320
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-972]
	vstr	d17, [fp, #-964]
	mov	r3, #0
	sub	r3, r3, #2224
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-988]
	vstr	d17, [fp, #-980]
	vldr	d18, [fp, #-972]
	vldr	d19, [fp, #-964]
	vldr	d16, [fp, #-988]
	vldr	d17, [fp, #-980]
	vsub.i16	q8, q9, q8
	mov	r3, #-1124073472
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	ldr	r0, .L15+16
	bl	puts
	mov	r3, #0
	sub	r3, r3, #2192
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1140850688
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #0
	sub	r3, r3, #2160
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	b	.L16
.L17:
	.align	2
.L15:
	.word	x1.19086
	.word	x1.19086+32
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
.L16:
	mov	r3, #-1124073472
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #0
	sub	r3, r3, #2192
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-940]
	vstr	d17, [fp, #-932]
	mov	r3, #-1140850688
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-956]
	vstr	d17, [fp, #-948]
	vldr	d18, [fp, #-940]
	vldr	d19, [fp, #-932]
	vldr	d16, [fp, #-956]
	vldr	d17, [fp, #-948]
	vadd.i16	q8, q9, q8
	mov	r3, #0
	sub	r3, r3, #2128
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2192
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-908]
	vstr	d17, [fp, #-900]
	mov	r3, #-1140850688
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-924]
	vstr	d17, [fp, #-916]
	vldr	d18, [fp, #-908]
	vldr	d19, [fp, #-900]
	vldr	d16, [fp, #-924]
	vldr	d17, [fp, #-916]
	vsub.i16	q8, q9, q8
	mov	r3, #-1107296256
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #884
	sub	r3, r3, #1
	mov	r2, #17
	sub	r1, fp, #4
	strh	r2, [r1, r3]	@ movhi
	mvn	r3, #884
	sub	r3, r3, #1
	sub	r2, fp, #4
	ldrh	r3, [r2, r3]	@ movhi
	vdup.16	q8, r3
	mov	r3, #0
	sub	r3, r3, #2096
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #884
	mov	r2, #24
	sub	r1, fp, #4
	strh	r2, [r1, r3]	@ movhi
	mov	r3, #0
	sub	r3, r3, #884
	sub	r2, fp, #4
	ldrh	r3, [r2, r3]	@ movhi
	vdup.16	q8, r3
	mov	r3, #-1090519040
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #880
	sub	r3, r3, #1
	mvn	r2, #58
	sub	r1, fp, #4
	strh	r2, [r1, r3]	@ movhi
	mvn	r3, #880
	sub	r3, r3, #1
	sub	r2, fp, #4
	ldrh	r3, [r2, r3]	@ movhi
	vdup.16	q8, r3
	mov	r3, #0
	sub	r3, r3, #2064
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2160
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-868]
	vstr	d17, [fp, #-860]
	mov	r3, #-1124073472
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-884]
	vstr	d17, [fp, #-876]
	vldr	d18, [fp, #-868]
	vldr	d19, [fp, #-860]
	vldr	d16, [fp, #-884]
	vldr	d17, [fp, #-876]
	vadd.i16	q8, q9, q8
	mov	r3, #-2147483648
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2096
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-836]
	vstr	d17, [fp, #-828]
	mov	r3, #-2147483648
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-852]
	vstr	d17, [fp, #-844]
	vldr	d18, [fp, #-836]
	vldr	d19, [fp, #-828]
	vldr	d16, [fp, #-852]
	vldr	d17, [fp, #-844]
	vmul.i16	q8, q9, q8
	mov	r3, #-2130706432
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1090519040
	mov	r3, r3, asr #19
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-804]
	vstr	d17, [fp, #-796]
	mov	r3, #-1124073472
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-820]
	vstr	d17, [fp, #-812]
	vldr	d18, [fp, #-804]
	vldr	d19, [fp, #-796]
	vldr	d16, [fp, #-820]
	vldr	d17, [fp, #-812]
	vmul.i16	q8, q9, q8
	mov	r3, #-2113929216
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #2064
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-772]
	vstr	d17, [fp, #-764]
	mov	r3, #0
	sub	r3, r3, #2160
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-788]
	vstr	d17, [fp, #-780]
	vldr	d18, [fp, #-772]
	vldr	d19, [fp, #-764]
	vldr	d16, [fp, #-788]
	vldr	d17, [fp, #-780]
	vmul.i16	q8, q9, q8
	mov	r3, #-2097152000
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-2113929216
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-740]
	vstr	d17, [fp, #-732]
	mov	r3, #-2130706432
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-756]
	vstr	d17, [fp, #-748]
	vldr	d18, [fp, #-740]
	vldr	d19, [fp, #-732]
	vldr	d16, [fp, #-756]
	vldr	d17, [fp, #-748]
	vadd.i16	q8, q9, q8
	mov	r3, #-2080374784
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-2097152000
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-708]
	vstr	d17, [fp, #-700]
	mov	r3, #-2130706432
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-724]
	vstr	d17, [fp, #-716]
	vldr	d18, [fp, #-708]
	vldr	d19, [fp, #-700]
	vldr	d16, [fp, #-724]
	vldr	d17, [fp, #-716]
	vadd.i16	q8, q9, q8
	mov	r3, #-2063597568
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-2080374784
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-692]
	vstr	d17, [fp, #-684]
	vldr	d16, [fp, #-692]
	vldr	d17, [fp, #-684]
	vshr.s16	q8, q8, #5
	mov	r3, #-2046820352
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-2063597568
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-676]
	vstr	d17, [fp, #-668]
	vldr	d16, [fp, #-676]
	vldr	d17, [fp, #-668]
	vshr.s16	q8, q8, #5
	mov	r3, #-2030043136
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	ldr	r0, .L15+20
	bl	puts
	mov	r3, #0
	sub	r3, r3, #2128
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1107296256
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-2046820352
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-2030043136
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mvn	r3, #652
	sub	r3, r3, #1
	mov	r2, #27
	sub	r1, fp, #4
	strh	r2, [r1, r3]	@ movhi
	mvn	r3, #652
	sub	r3, r3, #1
	sub	r2, fp, #4
	ldrh	r3, [r2, r3]	@ movhi
	vdup.16	q8, r3
	mov	r3, #-2013265920
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #0
	sub	r3, r3, #652
	mvn	r2, #8
	sub	r1, fp, #4
	strh	r2, [r1, r3]	@ movhi
	mov	r3, #0
	sub	r3, r3, #652
	sub	r2, fp, #4
	ldrh	r3, [r2, r3]	@ movhi
	vdup.16	q8, r3
	mov	r3, #-1996488704
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #648
	sub	r3, r3, #1
	mvn	r2, #43
	sub	r1, fp, #4
	strh	r2, [r1, r3]	@ movhi
	mvn	r3, #648
	sub	r3, r3, #1
	sub	r2, fp, #4
	ldrh	r3, [r2, r3]	@ movhi
	vdup.16	q8, r3
	mov	r3, #-1979711488
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1157627904
	mov	r3, r3, asr #19
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-636]
	vstr	d17, [fp, #-628]
	mov	r3, #-1207959552
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-652]
	vstr	d17, [fp, #-644]
	vldr	d18, [fp, #-636]
	vldr	d19, [fp, #-628]
	vldr	d16, [fp, #-652]
	vldr	d17, [fp, #-644]
	vadd.i16	q8, q9, q8
	mov	r3, #-1962934272
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-2013265920
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-604]
	vstr	d17, [fp, #-596]
	mov	r3, #-1962934272
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-620]
	vstr	d17, [fp, #-612]
	vldr	d18, [fp, #-604]
	vldr	d19, [fp, #-596]
	vldr	d16, [fp, #-620]
	vldr	d17, [fp, #-612]
	vmul.i16	q8, q9, q8
	mov	r3, #-1946157056
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1996488704
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-572]
	vstr	d17, [fp, #-564]
	mov	r3, #-1207959552
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-588]
	vstr	d17, [fp, #-580]
	vldr	d18, [fp, #-572]
	vldr	d19, [fp, #-564]
	vldr	d16, [fp, #-588]
	vldr	d17, [fp, #-580]
	vmul.i16	q8, q9, q8
	mov	r3, #-1929379840
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1979711488
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-540]
	vstr	d17, [fp, #-532]
	mov	r3, #-1157627904
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-556]
	vstr	d17, [fp, #-548]
	vldr	d18, [fp, #-540]
	vldr	d19, [fp, #-532]
	vldr	d16, [fp, #-556]
	vldr	d17, [fp, #-548]
	vmul.i16	q8, q9, q8
	mov	r3, #-1912602624
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1929379840
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-508]
	vstr	d17, [fp, #-500]
	mov	r3, #-1946157056
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-524]
	vstr	d17, [fp, #-516]
	vldr	d18, [fp, #-508]
	vldr	d19, [fp, #-500]
	vldr	d16, [fp, #-524]
	vldr	d17, [fp, #-516]
	vadd.i16	q8, q9, q8
	mov	r3, #-1895825408
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1912602624
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-476]
	vstr	d17, [fp, #-468]
	mov	r3, #-1946157056
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-492]
	vstr	d17, [fp, #-484]
	vldr	d18, [fp, #-476]
	vldr	d19, [fp, #-468]
	vldr	d16, [fp, #-492]
	vldr	d17, [fp, #-484]
	vadd.i16	q8, q9, q8
	mov	r3, #-1879048192
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1895825408
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-460]
	vstr	d17, [fp, #-452]
	vldr	d16, [fp, #-460]
	vldr	d17, [fp, #-452]
	vshr.s16	q8, q8, #5
	mov	r3, #-1862270976
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1879048192
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-444]
	vstr	d17, [fp, #-436]
	vldr	d16, [fp, #-444]
	vldr	d17, [fp, #-436]
	vshr.s16	q8, q8, #5
	mov	r3, #-1845493760
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #420
	sub	r3, r3, #1
	mov	r2, #31
	sub	r1, fp, #4
	strh	r2, [r1, r3]	@ movhi
	mvn	r3, #420
	sub	r3, r3, #1
	sub	r2, fp, #4
	ldrh	r3, [r2, r3]	@ movhi
	vdup.16	q8, r3
	mov	r3, #-1828716544
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1761607680
	mov	r3, r3, asr #22
	mvn	r2, #24
	sub	r1, fp, #4
	strh	r2, [r1, r3]	@ movhi
	mov	r3, #-1761607680
	mov	r3, r3, asr #22
	sub	r2, fp, #4
	ldrh	r3, [r2, r3]	@ movhi
	vdup.16	q8, r3
	mov	r3, #-1811939328
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mvn	r3, #416
	sub	r3, r3, #1
	mvn	r2, #37
	sub	r1, fp, #4
	strh	r2, [r1, r3]	@ movhi
	mvn	r3, #416
	sub	r3, r3, #1
	sub	r2, fp, #4
	ldrh	r3, [r2, r3]	@ movhi
	vdup.16	q8, r3
	mov	r3, #-1795162112
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1174405120
	mov	r3, r3, asr #19
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-404]
	vstr	d17, [fp, #-396]
	mov	r3, #-1191182336
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-420]
	vstr	d17, [fp, #-412]
	vldr	d18, [fp, #-404]
	vldr	d19, [fp, #-396]
	vldr	d16, [fp, #-420]
	vldr	d17, [fp, #-412]
	vadd.i16	q8, q9, q8
	mov	r3, #-1778384896
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1828716544
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-372]
	vstr	d17, [fp, #-364]
	mov	r3, #-1778384896
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-388]
	vstr	d17, [fp, #-380]
	vldr	d18, [fp, #-372]
	vldr	d19, [fp, #-364]
	vldr	d16, [fp, #-388]
	vldr	d17, [fp, #-380]
	vmul.i16	q8, q9, q8
	mov	r3, #-1761607680
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1811939328
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-340]
	vstr	d17, [fp, #-332]
	mov	r3, #-1191182336
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-356]
	vstr	d17, [fp, #-348]
	vldr	d18, [fp, #-340]
	vldr	d19, [fp, #-332]
	vldr	d16, [fp, #-356]
	vldr	d17, [fp, #-348]
	vmul.i16	q8, q9, q8
	mov	r3, #-1744830464
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1795162112
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-308]
	vstr	d17, [fp, #-300]
	mov	r3, #-1174405120
	mov	r3, r3, asr #19
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-324]
	vstr	d17, [fp, #-316]
	vldr	d18, [fp, #-308]
	vldr	d19, [fp, #-300]
	vldr	d16, [fp, #-324]
	vldr	d17, [fp, #-316]
	vmul.i16	q8, q9, q8
	mov	r3, #-1728053248
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1744830464
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-276]
	vstr	d17, [fp, #-268]
	mov	r3, #-1761607680
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-292]
	vstr	d17, [fp, #-284]
	vldr	d18, [fp, #-276]
	vldr	d19, [fp, #-268]
	vldr	d16, [fp, #-292]
	vldr	d17, [fp, #-284]
	vadd.i16	q8, q9, q8
	mov	r3, #-1711276032
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1728053248
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-244]
	vstr	d17, [fp, #-236]
	mov	r3, #-1761607680
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-260]
	vstr	d17, [fp, #-252]
	vldr	d18, [fp, #-244]
	vldr	d19, [fp, #-236]
	vldr	d16, [fp, #-260]
	vldr	d17, [fp, #-252]
	vadd.i16	q8, q9, q8
	mov	r3, #-1694498816
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1711276032
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-228]
	vstr	d17, [fp, #-220]
	vldr	d16, [fp, #-228]
	vldr	d17, [fp, #-220]
	vshr.s16	q8, q8, #5
	mov	r3, #-1677721600
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1694498816
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-212]
	vstr	d17, [fp, #-204]
	vldr	d16, [fp, #-212]
	vldr	d17, [fp, #-204]
	vshr.s16	q8, q8, #5
	mov	r3, #-1660944384
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	ldr	r0, .L15+16
	bl	puts
	mov	r3, #-1862270976
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1677721600
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1660944384
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1845493760
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1862270976
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-180]
	vstr	d17, [fp, #-172]
	mov	r3, #-1660944384
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-196]
	vstr	d17, [fp, #-188]
	vldr	d18, [fp, #-180]
	vldr	d19, [fp, #-172]
	vldr	d16, [fp, #-196]
	vldr	d17, [fp, #-188]
	vadd.i16	q8, q9, q8
	mov	r3, #-1644167168
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1862270976
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-148]
	vstr	d17, [fp, #-140]
	mov	r3, #-1660944384
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-164]
	vstr	d17, [fp, #-156]
	vldr	d18, [fp, #-148]
	vldr	d19, [fp, #-140]
	vldr	d16, [fp, #-164]
	vldr	d17, [fp, #-156]
	vsub.i16	q8, q9, q8
	mov	r3, #-1627389952
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1845493760
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-116]
	vstr	d17, [fp, #-108]
	mov	r3, #-1677721600
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-132]
	vstr	d17, [fp, #-124]
	vldr	d18, [fp, #-116]
	vldr	d19, [fp, #-108]
	vldr	d16, [fp, #-132]
	vldr	d17, [fp, #-124]
	vadd.i16	q8, q9, q8
	mov	r3, #-1610612736
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1845493760
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-84]
	vstr	d17, [fp, #-76]
	mov	r3, #-1677721600
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-100]
	vstr	d17, [fp, #-92]
	vldr	d18, [fp, #-84]
	vldr	d19, [fp, #-76]
	vldr	d16, [fp, #-100]
	vldr	d17, [fp, #-92]
	vsub.i16	q8, q9, q8
	mov	r3, #-1593835520
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	ldr	r0, .L15+20
	bl	puts
	mov	r3, #-1644167168
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1593835520
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1627389952
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1610612736
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1610612736
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-52]
	vstr	d17, [fp, #-44]
	mov	r3, #-1644167168
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-68]
	vstr	d17, [fp, #-60]
	vldr	d18, [fp, #-52]
	vldr	d19, [fp, #-44]
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vadd.i16	q8, q9, q8
	mov	r3, #-1577058304
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	mov	r3, #-1610612736
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-20]
	vstr	d17, [fp, #-12]
	mov	r3, #-1644167168
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vldmia	r3, {d16-d17}
	vstr	d16, [fp, #-36]
	vstr	d17, [fp, #-28]
	vldr	d18, [fp, #-20]
	vldr	d19, [fp, #-12]
	vldr	d16, [fp, #-36]
	vldr	d17, [fp, #-28]
	vsub.i16	q8, q9, q8
	mov	r3, #-1560281088
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	vstmia	r3, {d16-d17}
	ldr	r0, .L18
	bl	puts
	mov	r3, #-1560281088
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1593835520
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1627389952
	mov	r3, r3, asr #20
	sub	r2, fp, #4
	add	r3, r2, r3
	ldmia	r3, {r0-r3}
	bl	debug
	mov	r3, #-1577058304
	mov	r3, r3, asr #20
	sub	r1, fp, #4
	add	r3, r1, r3
	ldmia	r3, {r0-r3}
	bl	debug
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L19:
	.align	2
.L18:
	.word	.LC6
	.size	main, .-main
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
