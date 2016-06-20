#!/usr/bin/env python

import unittest
import sys
sys.path.append('../lib')
from tree import *
from node import *

class TestTree(unittest.TestCase):

    def setUp(self):
        # dummy
        self.testing = True

    def test_init(self):
        node = Node(2)
        tree = Tree(node)
        assert tree.root == node

    def test_add(self):
        node = Node(8)
        tree = Tree(node)
        node_l1 = Node(4)
        tree.add(node_l1)
        assert tree.root.left == node_l1

    def test_collect(self):
        node = Node(8)
        tree = Tree(node)
        node_l1 = Node(4)
        tree.add(node_l1)
        # Bound method results
        # assert [], tree.collect
        # http://stackoverflow.com/questions/28879886/python-beginner-where-comes-bound-method-of-object-at-0x0000000005ea
        assert [] == tree.collect()

    def tearDown(self):
        # dummy
        self.testing = False

if __name__ == '__main__':
    unittest.main()
