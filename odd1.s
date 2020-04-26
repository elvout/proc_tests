// need to manually insert nops
//      maybe modify assembler to do this?

movl r1, L0odd1 // loc 0, 1
movh r1, L0odd1

jns r1, r1      // loc 2, 3
nop             // insert nop
L0odd1:
movl r0, 65     // loc 5, 6
movl r0, 10     // loc 7, 8
