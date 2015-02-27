.data
line:
  .word

.text
.globl main
.extern malloc
.extern read
.extern write
.extern memset

main:
  mov   %r0, $1024
  bl    malloc        @ now r0 has address of malloc'd memory
  ldr   %r1, =line
  str   %r0, [%r1]
loop:
  ldr   %r6, =line
  mov   %r0, $0
  ldr   %r1, [%r6]
  mov   %r2, $1024
  bl    read          @ read user input
  mov   %r0, $1
  bl    write
  mov   %r0, %r1
  mov   %r1, $0
  mov   %r2, $1024
  bl    memset
  bl    loop
