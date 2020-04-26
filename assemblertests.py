#! /usr/bin/env python3

import os
import sys

import assembler
import unittest

class test_checkRegisters(unittest.TestCase):

    def test_valids_as_strs(self):
        for i in range(0, 16):
            with self.subTest(i=i):
                res = assembler.checkRegisters(f'r{i}')
                self.assertEqual(res, [f'{i:x}'])

    def test_valids_as_lists(self):
        for i in range(0, 16):
            with self.subTest(i=i):
                res = assembler.checkRegisters([f'r{i}'])
                self.assertEqual(res, [f'{i:x}'])

    def test_valids_as_tuples(self):
        for i in range(0, 16):
            with self.subTest(i=i):
                res = assembler.checkRegisters((f'r{i}',))
                self.assertEqual(res, [f'{i:x}'])

    def test_valid_groups(self):
        inputs = (['r0', 'r15'], ['r1', 'r9', 'r14'], ['r2', 'r5', 'r11', 'r15'])
        outputs = (['0', 'f'], ['1', '9', 'e'], ['2', '5', 'b', 'f'])

        for i in range(len(inputs)):
            with self.subTest(i=i):
                res = assembler.checkRegisters(inputs[i])
                self.assertEqual(res, outputs[i])

    def test_invalid_strings(self):
        inputs = ['0', '5', '16', 'r-1', 'r16', 'r100']

        for i in range(len(inputs)):
            with self.subTest(i=i):
                res = assembler.checkRegisters(inputs[i])
                self.assertIsNone(res)

    def test_error_strings(self):
        inputs = ['r0.1', 'rrr10', 'rf', '-r1', 10, 159]

        for i in range(len(inputs)):
            with self.subTest(i=i):
                try:
                    assembler.checkRegisters(input[i])
                    self.assertTrue(False)
                except (ValueError, TypeError):
                    self.assertTrue(True)


class test_instruction_parsing(unittest.TestCase):

    def test_valid_sub(self):
        inputs = (
            ('sub', 'r0', 'r5', 'r15'),
            ('sub', 'r9', 'r12', 'r7')
        )

        outputs = (
            ('0', '5', 'f', '0'),
            ('0', 'c', '7', '9')
        )

        for i in range(len(inputs)):
            with self.subTest(i=i):
                res = assembler.sub(i, inputs[i])
                self.assertSequenceEqual(res, outputs[i])

    def test_invalid_sub(self):
        try:
            assembler.sub(0, ['sub', 'r-1', 'r16', 'r3'])
            self.assertTrue(False)
        except OSError:
            self.assertTrue(True)

    def test_valid_movl(self):
        inputs = (
            ('movl', 'r7', '0'),
            ('movl', 'r13', '125'),
            ('movl', 'r11', '-109'),
            ('movl', 'r1', '127'),
            ('movl', 'r8', '-128'),
            ('movl', 'r3', '-1'),
            ('movl', 'r1', '255')
        )

        outputs = (
            ('8', '0', '0', '7'),
            ('8', '7', 'd', 'd'),
            ('8', '9', '3', 'b'),
            ('8', '7', 'f', '1'),
            ('8', '8', '0', '8'),
            ('8', 'f', 'f', '3'),
            ('8', 'f', 'f', '1')
        )

        for i in range(len(inputs)):
            with self.subTest(i=i):
                res = assembler.movl(i, inputs[i])
                self.assertSequenceEqual(res, outputs[i])

    def test_invalid_movl(self):
        inputs = (
            ('movl', 'r16', '100'),
            ('movl', 'r0', '328'),
            ('movl', 'r0', '-129'),
            ('movl', 'r-1', '10')
        )

        for i in range(len(inputs)):
            try:
                assembler.movl(i, inputs[i])
                self.assertTrue(False)
            except OSError:
                self.assertTrue(True)

    def test_valid_movh(self):
        inputs = (
            ('movh', 'r1', '0'),
            ('movh', 'r4', '-128'),
            ('movh', 'r15', '127'),
            ('movh', 'r10', '101'),
            ('movh', 'r12', '-101')
        )

        outputs = (
            ('9', '0', '0', '1'),
            ('9', '8', '0', '4'),
            ('9', '7', 'f', 'f'),
            ('9', '6', '5', 'a'),
            ('9', '9', 'b', 'c')
        )

        for i in range(len(inputs)):
            with self.subTest(i=i):
                res = assembler.movh(i, inputs[i])
                self.assertSequenceEqual(res, outputs[i])

    def test_invalid_movh(self):
        inputs = (
            ('movh', 'r16', '100'),
            ('movh', 'r0', '256'),
            ('movh', 'r0', '-129'),
            ('movh', 'r-1', '10')
        )

        for i in range(len(inputs)):
            try:
                assembler.movl(i, inputs[i])
                self.assertTrue(False)
            except OSError:
                self.assertTrue(True)

    def test_valid_rtra(self):
        inputs = (
            ('null', 'r0', 'r15'),
            ('null', 'r4', 'r10'),
            ('null', 'r12', 'r14')
        )

        outputs = (
            ('f', '0'),
            ('a', '4'),
            ('e', 'c')
        )

        for i in range(len(inputs)):
            with self.subTest(i=i):
                res = assembler.rtra(i, inputs[i], 'null', '0', '0')
                self.assertEqual(res[1], outputs[i][0])
                self.assertEqual(res[3], outputs[i][1])

    def test_jz(self):
        res = assembler.jz(0, ('jz', 'r10', 'r1'))
        self.assertSequenceEqual(res, ('e', '1', '0', 'a'))

    def test_jnz(self):
        res = assembler.jnz(0, ('jnz', 'r9', 'r15'))
        self.assertSequenceEqual(res, ('e', 'f', '1', '9'))

    def test_js(self):
        res = assembler.js(0, ('js', 'r4', 'r12'))
        self.assertSequenceEqual(res, ('e', 'c', '2', '4'))

    def test_jns(self):
        res = assembler.jns(0, ('jns', 'r13', 'r3'))
        self.assertSequenceEqual(res, ('e', '3', '3', 'd'))

    def test_ld(self):
        res = assembler.ld(0, ('ld', 'r0', 'r4'))
        self.assertSequenceEqual(res, ('f', '4', '0', '0'))

    def test_st(self):
        res = assembler.st(0, ('st', 'r9', 'r2'))
        self.assertSequenceEqual(res, ('f', '2', '1', '9'))

if __name__ == '__main__':
    unittest.main()
