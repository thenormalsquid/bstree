#!/usr/bin/env python

import unittest
import sys
sys.path.append('../lib')
from tree import *

class TestTree(unittest.TestCase):

    def setUp(self):
        # dummy
        self.testing = True

    def test_foo(self):
        ps = Tree()
        assert('bar' == ps.foo())

    def tearDown(self):
        # dummy
        self.testing = False

if __name__ == '__main__':
    unittest.main()
