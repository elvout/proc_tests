// misaligns the pc and tests ld/st stalling

movl r1, L0odd2
jns r1, r1
nop

L0odd2:
// loc 10000 {16, 39}
// loc 11000 {42, 248}

movl r2, 39
movh r2, 16

movl r3, 248
movh r3, 42

movl r4, 65
movl r5, 66

st r4, r2
st r5, r3

ld r0, r2
ld r0, r3

movl r0, 10
