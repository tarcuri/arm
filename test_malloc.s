.data
alloc_msg:
  .string "Allocated %d bytes @ 0x%x\n"
input_msg:
  .string "Enter up to 1024 characters for printing\n"
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
  ldr   %r2, [%r1]
  ldr   %r0, =alloc_msg
  mov   %r1, $1024
  bl    printf
  ldr   %r0, =input_msg
  bl    printf
  mov   %r0, $0
  ldr   %r1, =mem_ptr
  mov   %r2, $1024
  bl    read
  ldr   %r0, =mem_ptr
  bl    printf

exit:
  mov   %r0, $0
  mov   %r7, $1
  swi   $0
