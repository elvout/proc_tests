movl r1, 66
movl r2, 72
movl r3, 1

// test immediate dependency
sub r4, r2, r3
sub r0, r4, r0

movl r0, 65
movl r0, 65
movl r0, 65
movl r0, 65
movl r0, 10

// test gap size 1
sub r4, r2, r3
sub r0, r1, r0
sub r0, r4, r0

movl r0, 65
movl r0, 65
movl r0, 65
movl r0, 65
movl r0, 10

// test gap size 2
sub r4, r2, r3
sub r0, r1, r0
sub r0, r1, r0
sub r0, r4, r0

movl r0, 65
movl r0, 65
movl r0, 65
movl r0, 65
movl r0, 10

// test gap size 3
sub r4, r2, r3
sub r0, r1, r0
sub r0, r1, r0
sub r0, r1, r0
sub r0, r4, r0

movl r0, 65
movl r0, 65
movl r0, 65
movl r0, 65
movl r0, 10

// test gap size 4
sub r4, r2, r3
sub r0, r1, r0
sub r0, r1, r0
sub r0, r1, r0
sub r0, r1, r0
sub r0, r4, r0

movl r0, 10
