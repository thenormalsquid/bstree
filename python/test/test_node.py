#!/usr/bin/env python

# pylint: disable=R0201

import unittest
import sys
sys.path.append('../lib')
from node import *

class TestNode(unittest.TestCase):

    def setUp(self):
        # dummy
        self.testing = True

    def test_init(self):
        node = Node(15)
        assert node.left is None
        assert node.right is None

    def test_add(self):
        node = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node.add(node_l1)
        node.add(node_l2)
        node.add(node_l3)
        assert node.left == node_l1
        assert node.right == node_l2
        assert node.right.left == node_l3

    def test_find(self):
        node = Node(15)
        assert node.find() == node

    def tearDown(self):
        # dummy
        self.testing = False

if __name__ == '__main__':
    unittest.main()
