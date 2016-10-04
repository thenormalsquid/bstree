#!/usr/bin/env python

# pylint: disable=R0201

import unittest
import sys
sys.path.append('../lib')
from pnode import *

class TestPNode(unittest.TestCase):

    def setUp(self):
        # dummy
        self.testing = True

    def test_init(self):
        node = Node(15)
        assert node.left is None
        assert node.right is None

if __name__ == '__main__':
    unittest.main()
