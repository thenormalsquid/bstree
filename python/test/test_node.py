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

    def test_collect(self):
        node = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node.add(node_l1)
        node.add(node_l2)
        node.add(node_l3)
        node.add(node_l4)
        collector = []
        node.collect(collector)
        assert collector == [4, 8, 15, 25, 33]

    def test_add(self):
        node = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        node.add(node_l1)
        node.add(node_l2)
        node.add(node_l3)
        node.add(node_l4)
        node.add(node_l5)
        assert node.left == node_l1
        assert node.right == node_l2
        assert node.right.left == node_l3
        assert node.left.left == node_l4
        assert node.left.right == node_l5

    def test_find(self):
        node = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        node.add(node_l1)
        node.add(node_l2)
        node.add(node_l3)
        node.add(node_l4)
        node.add(node_l5)
        assert node.find(33) == node_l2

    def test_is_present(self):
        node = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        node.add(node_l1)
        node.add(node_l2)
        node.add(node_l3)
        node.add(node_l4)
        node.add(node_l5)
        assert node.is_present(33) is True
        assert node.is_present(34) is None

    def test_maximum(self):
        root = Node(15)
        node_l1 = Node(8)
        node_l2 = Node(33)
        node_l3 = Node(25)
        node_l4 = Node(4)
        node_l5 = Node(9)
        root.add(node_l1)
        root.add(node_l2)
        root.add(node_l3)
        root.add(node_l4)
        root.add(node_l5)
        assert root.maximum() == node_l2
        assert root.minimum() == node_l4

    # def test_is_bst(self):
    # def test_delete(self):

    def test_height_and_size(self):
        root = Node(8)
        # assert root.height() == 1
        # This is a hideous construction, fix it by moving the
        # details into the Node class.
        get_size = root.size()
        print get_size(0)
        assert get_size(0) == 1

        node_l1 = Node(4)
        root.add(node_l1)
        # assert root.height() == 2
        get_size = root.size()
        print get_size(0)
        assert get_size(0) == 2

        node_r1 = Node(12)
        root.add(node_r1)
        # assert root.height() == 2
        get_size = root.size()
        print get_size(0)
        assert get_size(0) == 3

        node_l2 = Node(2)
        root.add(node_l2)
        # assert root.height() == 3
        get_size = root.size()
        print get_size(0)
        assert get_size(0) == 4

        node_l3 = Node(1)
        root.add(node_l3)
        # assert root.height() == 4
        get_size = root.size()
        print get_size(0)
        assert get_size(0) == 5

        node_r3 = Node(3)
        root.add(node_r3)
        # assert root.height() == 4
        get_size = root.size()
        print get_size(0)
        assert get_size(0) == 6

    def tearDown(self):
        # dummy
        self.testing = False

if __name__ == '__main__':
    unittest.main()
