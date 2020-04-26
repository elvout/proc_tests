// loop while number is not negative
//  runs 128-ish times
movl r1, Lloop0
movl r2, 127
movl r3, 1

Lloop0:
sub r2, r2, r3
jns r1, r2


// loop while number is negative
//   runs 129-ish times
movl r1, Lloop1
movl r2, 255
movh r2, 128
movl r3, 1

Lloop1:
sub r2, r2 ,r3
js r1, r2


// loop while number is not zero
//   runs 128-ish times
movl r1, Lloop2
movl r2, 127
movl r3, 1

Lloop2:
sub r2, r2, r3
jnz r1, r2


movl r0, 65
movl r0, 10
