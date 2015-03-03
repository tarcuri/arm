.data
SOCK_FD:
  .word

SOCKADDR_IN:
  .byte   0x0
  .byte   0x0
  .byte   0x0
  .byte   0x0
  .word   0x0
  .word   0x0
  .word   0x0

PORT:
  .word   0x1389

BUFFER:
  .word

.text

.globl main
.extern socket
.extern malloc
.extern bind
.extern read
.extern write
.extern memset

main:
  mov   %r0, $2         @ AF_INET
  mov   %r1, $2         @ SOCK_DGRAM
  mov   %r2, $0
  bl    socket
  ldr   %r1, =SOCK_FD
  str   %r0, [%r1]      @ store socket descriptor
  ldr   %r1, =SOCKADDR_IN
  mov   %r2, $2         @ AF_INET
  str   %r2, [%r1]
  ldr   %r2, =PORT      @ PORT
  str   %r2, [%r1, $2]
  mov   %r2, $0         @ INADDR_ANY
  str   %r2, [%r1, $4]
  mov   %r2, $16
  bl    bind
  mov   %r0, $1024
  bl    malloc
  ldr   %r1, =BUFFER
  str   %r0, [%r1]
LOOP:
  ldr   %r0, =SOCK_FD
  ldr   %r1, =BUFFER
  mov   %r2, $1024
  bl    read
  mov   %r2, %r0
  mov   %r0, $1
  ldr   %r1, =BUFFER
  bl    write
  ldr   %r0, =BUFFER
  mov   %r1, $0
  mov   %r2, $1024
  bl    memset
  bl    LOOP
