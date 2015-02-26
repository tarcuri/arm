.data
number:
	.asciz	"%d\n"

.text
.globl main
.extern printf
.extern atoi
main:
	nop
	str	%r0, [sp]
	cmp	%r0, $2
	blt	quit		@ argc must equal 1
	bgt	quit
	ldr	%r0, [r1, #4]
	bl	atoi
	bl	fibonacci
	mov	%r1, %r0
	ldr	%r0, =number
	bl	printf
quit:
	mov	%r7, $1
	swi	$0		@ return n'th fibonnaci number
	
fibonacci:
	push	{lr}
	cmp	%r0, $0
	beq	end
	cmp	%r0, $1
	beq	end
	mov	%r1, %r0	@ store n
	sub	%r0, %r1, $1	@ call fib(n-1)
	push	{r1}
	bl	fibonacci
	pop	{r1}
	mov	%r2, %r0	@ store fib(n-1)
	sub	%r0, %r1, $2	@ call fib(n-2)
	push	{r1,r2}
	bl	fibonacci
	pop	{r1,r2}
	mov	%r3, %r0	@ store fib(n-2)
	add	%r0, %r2, %r3	@ result = fib(n-1) + fib(n-2)
end:
	@mov	%r1, %r0
	@ldr	%r0, =number
	@bl	printf
	pop	{pc}
