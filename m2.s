movl r1, 65
movl r2, 0
movh r2, 1

movl r3, 0
movl r4, L0

st r1, r2
ld r0, r2       // A
ld r3, r2
jnz r4, r3

movl r0, 66     // B - no print

L0:
movl r0, 67     // C

movl r3, 0
movl r0, 68     // D
movl r0, 68     // D
movl r0, 68     // D
movl r0, 68     // D
movl r0, 68     // D

ld r3, r2
sub r0, r3, r0  // A
ld r3, r2
ld r3, r2
ld r3, r2
ld r3, r2
movl r3, 69
sub r0, r3, r0  // E




movl r0, 10
