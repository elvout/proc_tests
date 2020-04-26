movl r1, L0
movl r2, 10
movl r3, 1

// prints 'B' 10 times
L0:
sub r2, r2, r3  // loc 0006
movl r0, 66
jnz r1, r2

movl r0, 65 // loc 000C
movl r0, 10
