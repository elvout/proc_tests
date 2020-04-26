// consecutive ld, with misaligned


// loc 1000 {3, 232}
// loc 1200 {4, 176}
// loc 1444 {5, 164}
// loc 2468 {9, 164}

// loc 1111 {4, 87}
// loc 3579 {13, 251}
// loc 4299 {16, 203}

movl r1, 232
movh r1, 3

movl r2, 176
movh r2, 4

movl r3, 164
movh r3, 5

movl r4, 164
movh r4, 9

movl r5, 65     // A
movl r6, 66     // B
movl r7, 67     // C
movl r8, 68     // D

movl r10, 87
movh r10, 4
movl r11, 251
movh r11, 13
movl r12, 203
movh r12, 16

movl r13, 69    // E
movl r14, 70    // F
movl r15, 71    // G

movl r9, -1


st r5, r1
st r6, r2
st r7, r3
st r8, r4

ld r0, r1
ld r0, r2
ld r0, r3
ld r0, r4
movl r0, 10

st r13, r10
st r14, r11
st r15, r12

ld r0, r10
ld r0, r11
ld r0, r12
movl r0, 10


st r0, r1
st r0, r10
st r0, r2
st r0, r11
st r0, r3
st r0, r12
st r0, r4

st r5, r1
st r13, r10
st r6, r2
st r14, r11
st r7, r3
st r15, r12
st r8, r4

ld r0, r1
ld r0, r10
ld r0, r2
ld r0, r11
ld r0, r3
ld r0, r12
ld r0, r4

movl r0, 10
