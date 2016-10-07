#!/usr/bin/env python

import unittest
import sys
sys.path.append("../lib")
from tree import *
from node import *

class TestTreeDelete(unittest.TestCase):

    def setUp(self):
        self.testing = True

    def test_delete_root(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        result = tree.clr_delete(root)
        assert result == root

    def test_delete_right_leaf(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        result = tree.clr_delete(n5)
        assert result == n5

    def test_delete_left_leaf(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        result = tree.clr_delete(n23)
        assert result == n23

    def test_delete_minimum(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        n3 = Node(3)
        n2 = Node(2)
        tree.insert(n3)
        tree.insert(n2)
        n7 = Node(7)
        n11 = Node(11)
        n13 = Node(13)
        tree.insert(n7)
        tree.insert(n11)
        tree.insert(n13)
        n19 = Node(19)
        n29 = Node(29)
        tree.insert(n19)
        tree.insert(n29)

    def test_delete_maximum(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        n3 = Node(3)
        n2 = Node(2)
        tree.insert(n3)
        tree.insert(n2)
        n7 = Node(7)
        n11 = Node(11)
        n13 = Node(13)
        tree.insert(n7)
        tree.insert(n11)
        tree.insert(n13)
        n19 = Node(19)
        n29 = Node(29)
        tree.insert(n19)
        tree.insert(n29)

    def tearDown(self):
        self.testing = False


if __name__ == '__main__':
    unittest.main()
