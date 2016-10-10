#!/usr/bin/env python

import unittest
import sys
sys.path.append("../lib")
from tree import *
from node import *

class TestTreeDelete(unittest.TestCase):

    def setUp(self):
        self.testing = True

    def test_delete_root_with_two_children(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        result = tree.clr_delete(root)
        assert tree.root.key == 23
        assert tree.root == root
        assert tree.is_bst() is True
        assert tree.to_a() == [5, 23]
        assert tree.size() == 2

    def test_delete_right_leaf(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        result = tree.clr_delete(n5)
        assert result == n5
        assert tree.size() == 2
        assert tree.is_bst() is True
        assert tree.to_a() == [17, 23]

    def test_delete_left_leaf(self):
        root = Node(17)
        tree = Tree(root)
        n5 = Node(5)
        n23 = Node(23)
        tree.insert(n5)
        tree.insert(n23)
        result = tree.clr_delete(n23)
        assert result == n23
        assert tree.size() == 2
        assert tree.is_bst() is True
        assert tree.to_a() == [5, 17]


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
        result = tree.clr_delete(n2)
        assert result == n2
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.to_a() == [3, 5, 7, 11, 13, 17, 19, 23, 29]

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
        result = tree.clr_delete(n29)
        assert result == n29
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.to_a() == [2, 3, 5, 7, 11, 13, 17, 19, 23]

    def test_delete_left_singly_linked(self):
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
        result = tree.clr_delete(n7)
        assert result == n7
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.to_a() == [2, 3, 5, 11, 13, 17, 19, 23, 29]

    def test_delete_right_internal(self):
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
        result = tree.clr_delete(n23)
        assert result == n29
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.to_a() == [2, 3, 5, 7, 11, 13, 17, 19, 29]


    def test_delete_left_internal(self):
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
        result = tree.clr_delete(n5)
        assert result == n7
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.to_a() == [2, 3, 7, 11, 13, 17, 19, 23, 29]

    def test_delete_entire_tree(self):
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
        result = tree.clr_delete(n5)
        # We acquire a reference to n5's successor because n5 has
        # both left and right children.
        assert result == n7
        # TODO: check the key for the result (n7), and
        # the right, left and parent links.
        # TODO: There is one more case which needs to be tested here
        # for delete, which is when the successor has a right child.
        # In this case, a node with value 8 inserted after n7.
        assert n5.key == 7
        assert tree.size() == 9
        assert tree.is_bst() is True
        assert tree.to_a() == [2, 3, 7, 11, 13, 17, 19, 23, 29]
        tree.to_json()
        # We have a problem here using delete with a node argument:
        # nodes with two children swap values with the successor, which
        # means that deleting successive nodes - by node instead of by
        # key - will result in errors.
        result = tree.clr_delete(n7)
        assert tree.to_a() == [2, 3, 11, 13, 17, 19, 23, 29]
        print "result.key: %d" % result.key
        assert result == n11
        assert tree.size() == 8
        assert tree.is_bst() is True
        assert tree.to_a() == [2, 3, 11, 13, 17, 19, 23, 29]

    def tearDown(self):
        self.testing = False


if __name__ == '__main__':
    unittest.main()
