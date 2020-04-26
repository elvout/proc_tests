// store in a loop

// loc 10000 {16, 39}
movl r1, 39
movh r1, 16

movl r2, 73
movl r3, 8
movl r4, 1

movl r5, L0m5
movh r5, L0m5

L0m5:
sub r3, r3, r4
sub r2, r2, r4
st r2, r1
jnz r5, r3

ld r0, r1

movl r0, 10


// loc 11111 {103, 43}
movl r1, 43
movh r1, 103

movl r2, 74
movl r3, 8
movl r4, 1

movl r5, L1m5
movh r5, L1m5

L1m5:
sub r3, r3, r4
sub r2, r2, r4
st r2, r1
jnz r5, r3

ld r0, r1
movl r0, 10
