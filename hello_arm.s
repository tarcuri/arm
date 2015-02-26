.data
string:
	.ascii	"Hello, ARM!\n"
len = . - string

.text

.globl	_start
_start:
	mov	%r0, $1		@ fd -> stdout
	ldr	%r1, =string	@ pointer to string
	ldr	%r2, =len	@ message length
	mov	%r7, $4		@ syscall 4: write
	swi	$0

	@ call exit
	mov	%r0, $0		@ status = 0
	mov	%r7, $1		@ syscall 1: exit
	swi	$0
