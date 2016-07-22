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

    def test_height(self):
        node = Node(8)
        tree = Tree(node)
        # print tree.height()
        assert tree.height() == 1
        node_l1 = Node(4)
        tree.add(node_l1)
        # print tree.height()
        assert tree.height() == 2
        node_r1 = Node(12)
        tree.add(node_r1)
        # print tree.height()
        assert tree.height() == 2
        node_l2 = Node(2)
        tree.add(node_l2)
        # print tree.height()
        assert tree.height() == 3
        node_l3 = Node(1)
        tree.add(node_l3)
        # print tree.height()
        assert tree.height() == 4
        node_r3 = Node(3)
        tree.add(node_r3)
        # print tree.height()
        assert tree.height() == 4



    def tearDown(self):
        # dummy
        self.testing = False

if __name__ == '__main__':
    unittest.main()
