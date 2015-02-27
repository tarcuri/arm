.data
alloc_msg:
  .string "Allocated %d bytes @ 0x%x\n> "
value_msg:
  .string "Valued stored: %d\n"

mem_ptr:
  .word

.text
.globl main

.extern malloc
.extern printf

main:
  mov   %r0, $1024
  bl    malloc
  ldr   %r1, =mem_ptr
  str   %r0, [%r1]
  ldr   %r0, =alloc_msg
  mov   %r1, $1024
  ldr   %r2, =mem_ptr
  bl    printf
  ldr   %r2, =mem_ptr
  mov   %r0, $16
  str   %r0, [%r2]
  ldr   %r0, =value_msg
  ldr   %r3, =mem_ptr
  ldr   %r1, [%r3]
  bl    printf

exit:
  mov   %r0, $0
  mov   %r7, $1
  swi   $0
