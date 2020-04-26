    // from datafwd3.s

movl r1, 66
movl r2, 91
movl r3, 1

// test immediate dependency
sub r4, r2, r3
sub r0, r4, r0

// test gap size 1
sub r4, r2, r3
sub r0, r1, r0
sub r0, r4, r0

// test gap size 2
sub r4, r2, r3
sub r0, r1, r0
sub r0, r1, r0
sub r0, r4, r0

movl r0, 10




    // from m3.s

// memory location 1001 = {3, 233}
movl r1, 233
movh r1, 3
movl r2, 90         // letter to store: Z


st r2, r1

// print A-E
movl r0, 65
movl r0, 66
movl r0, 67
movl r0, 68
movl r0, 69
movl r0, 10


ld r0, r1           // print 'Z'

// print A-E
movl r0, 65
movl r0, 66
movl r0, 67
movl r0, 68
movl r0, 69
movl r0, 10


    // from m2.s


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


    // from loop.s

// loop while number is not negative
//  runs 128-ish times
movl r1, Lloop0
movh r1, Lloop0
movl r2, 127
movl r3, 1

Lloop0:
sub r2, r2, r3
jns r1, r2


// loop while number is negative
//   runs 129-ish times
movl r1, Lloop1
movh r1, Lloop1
movl r2, 255
movh r2, 128
movl r3, 1

Lloop1:
sub r2, r2 ,r3
js r1, r2


// loop while number is not zero
//   runs 128-ish times
movl r1, Lloop2
movh r1, Lloop2
movl r2, 127
movl r3, 1

Lloop2:
sub r2, r2, r3
jnz r1, r2


movl r0, 65
movl r0, 10






    // from jmp2.s


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
