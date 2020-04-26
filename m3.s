// simple misaligned st and ld

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
