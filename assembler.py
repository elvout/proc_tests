#! /usr/bin/env python3

import os
import sys
import re

def error(lineno, msg):
    raise OSError(f'error on line {lineno}: {msg}')


def checkRegisters(regs):
    if type(regs) is str:
        regs = (regs,)

    nums = []
    for reg in regs:
        try:
            x = int(reg[1:])
            if not reg.startswith('r') or x < 0 or x > 15:
                return None
            nums.append(f'{x:x}')
        except (ValueError, TypeError):
            return None

    return nums


def checkInteger(i):
    if i < -128 or i > 255:
        raise ValueError()

    return ((i >> 4) & 0xf, i & 0xf)


def sub(lineno, tokens):
    if len(tokens) != 4:
        error(lineno, 'sub instruction misformatted')

    nums = checkRegisters(tokens[1:])
    if not nums:
        error(lineno, 'sub registers misformatted')

    return ('0', nums[1], nums[2], nums[0])


def movl(lineno, tokens):
    if len(tokens) != 3:
        error(lineno, 'movl instruction misformatted')

    nums = checkRegisters(tokens[1:2])
    if not nums:
        error(lineno, 'movl registers misformatted')

    try:
        i = int(tokens[2])
        i0, i1 = checkInteger(i)
    except ValueError:
        error(lineno, 'movl number misformatted/too large')

    return ('8', f'{i0:x}', f'{i1:x}', *nums)


def movh(lineno, tokens):
    if len(tokens) != 3:
        error(lineno, 'movh instruction misformatted')

    nums = checkRegisters(tokens[1:2])
    if not nums:
        error(lineno, 'movh registers misformatted')

    try:
        i = int(tokens[2])
        i0, i1 = checkInteger(i)
    except ValueError:
        error(lineno, 'movh number misformatted/too large')

    return ('9', f'{i0:x}', f'{i1:x}', *nums)


def rtra(lineno, tokens, iname, b0, b2):
    if len(tokens) != 3:
        error(lineno, f'{iname} instruction misformatted')

    regs = checkRegisters(tokens[1:])
    if not regs:
        error(lineno, f'{iname} registers misformatted')

    return (b0, regs[1], b2, regs[0])


def jz(lineno, tokens):
    return rtra(lineno, tokens, 'jz', 'e', '0')

def jnz(lineno, tokens):
    return rtra(lineno, tokens, 'jnz', 'e', '1')

def js(lineno, tokens):
    return rtra(lineno, tokens, 'js', 'e', '2')

def jns(lineno, tokens):
    return rtra(lineno, tokens, 'jns', 'e', '3')

def ld(lineno, tokens):
    return rtra(lineno, tokens, 'ld', 'f', '0')

def st(lineno, tokens):
    return rtra(lineno, tokens, 'st', 'f', '1')


def nop(lineno, tokens):
    return ('f', 'f')


def main(filename):
    if not os.path.exists(filename):
        print(f"'{filename}' file does not exist")
        sys.exit(1)

    basename = filename[0:filename.find('.')]
    oname = basename + '.hex'

    ifile = open(filename, 'r')

    rawlines = [line.strip() for line in ifile.readlines()]
    asmlines = []
    orig_lineno = []
    labels = {}

    curline = 0
    pc = 0
    for line in rawlines:
        curline += 1

        # remove comments
        line = re.sub(r'//.*$', '', line).strip()

        if not line:
            continue

        if re.fullmatch("^L.+:.*$", line):
            label = line[0:line.find(':')]
            labels[label] = pc
        else:
            asmlines.append(line)
            orig_lineno.append(curline)

            if line.startswith('nop'): pc += 1
            else: pc += 2

    output = []
    idx = 0
    for line in asmlines:
        tokens = re.split(r'[,\s]+', line)

        for i in range(len(tokens)):
            if tokens[i] in labels:
                if tokens[0] == 'movl':
                    tokens[i] = labels[tokens[i]] & 0xff
                if tokens[0] == 'movh':
                    tokens[i] = (labels[tokens[i]] >> 8) & 0xff

        if not line:
            continue

        if tokens[0] in globals():
            try:
                nibbles = globals()[tokens[0]](orig_lineno[idx], tokens)
            except OSError as e:
                print(e)
                sys.exit(1)

            for i in range(0, len(nibbles), 2):
                output.append(nibbles[i] + nibbles[i + 1])

            # output.append(''.join(nibbles))
        else:
            print(f'error on line {orig_lineno[idx]}: {tokens[0]} instruction not found')
            print(f'tokens: {tokens}')
            sys.exit(1)

        idx += 1

    ifile.close()

    if len(output) % 2 == 1:
        output.append('ff')

    with open(oname, 'w') as ofile:
        ofile.write('@0\n')

        for i in range(0, len(output), 2):
            ofile.write(output[i] + output[i + 1] + '\n')

        ofile.write('ffff\n')

if __name__ == '__main__':
    if len(sys.argv) == 1:
        print('usage: assembler.py $1.s $2.s ...')
        sys.exit(1)

    for i in range(1, len(sys.argv)):
        file = sys.argv[i]
        if file.endswith('.s') and os.path.exists(file):
            main(file)
        else:
            print(f'skipping {file}')
