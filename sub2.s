// performs (x - 1) several times to print A

movl r1, 1
movl r2, 1

movl r3, 70
sub r3, r3, r1
sub r3, r3, r2
sub r3, r3, r1
sub r3, r3, r2
sub r3, r3, r1

sub r0, r3, r0
movl r0, 10
