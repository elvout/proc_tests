// jz, jnz, js, jns

// jz taken
movl r1, L1jmp2
movh r1, L1jmp2
movl r2, 0

jz r1, r2

L0jmp2:
movl r0, 66     // B - should not print
movl r0, 66     // B - should not print
movl r0, 66     // B - should not print
movl r0, 66     // B - should not print
movl r0, 66     // B - should not print
movl r0, 66     // B - should not print
movl r0, 66     // B - should not print

L1jmp2:
movl r0, 65     // A


// jz not taken
movl r3, L0jmp2
movh r3, L0jmp2
movl r4, 1

jz r3, r4




// jnz taken
movl r5, L3jmp2
movh r5, L3jmp2
movl r6, 1

jnz r5, r6

L2jmp2:
movl r0, 68     // D - should not print
movl r0, 68     // D - should not print
movl r0, 68     // D - should not print
movl r0, 68     // D - should not print
movl r0, 68     // D - should not print
movl r0, 68     // D - should not print

L3jmp2:
movl r0, 67     // C


// jnz not taken
movl r7, L2jmp2
movh r7, L2jmp2
movl r8, 0

jnz r7, r8




// js taken
movl r9, L5jmp2
movh r9, L5jmp2
movl r10, -1

js r9, r10

L4jmp2:
movl r0, 70     // F - should not print
movl r0, 70     // F - should not print
movl r0, 70     // F - should not print
movl r0, 70     // F - should not print
movl r0, 70     // F - should not print
movl r0, 70     // F - should not print

L5jmp2:
movl r0, 69     // E


// js not taken
movl r11, L4jmp2
movh r11, L4jmp2
movl r12, 0

js r11, r12


// jns taken
movl r13, L7jmp2
movh r13, L7jmp2
movl r14, 0

jns r13, r14

L6jmp2:
movl r0, 72     // H - should not print
movl r0, 72     // H - should not print
movl r0, 72     // H - should not print
movl r0, 72     // H - should not print
movl r0, 72     // H - should not print
movl r0, 72     // H - should not print

L7jmp2:
movl r0, 71     // G

// jns not taken
movl r15, L6jmp2
movh r15, L6jmp2
movl r14, -1

jns r15, r14


movl r0, 90     // Z
movl r0, 10
