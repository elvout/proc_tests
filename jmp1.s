movl r1, L0
movl r2, 3
movl r3, 1

// for (int i = 3; i != 0; i--) print('B')
    // kinda not really but it prints 'B' 3 times
L0:
sub r2, r2, r3
movl r0, 66
jnz r1, r2

movl r0, 65
movl r0, 10
