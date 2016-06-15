#!/usr/bin/env python

import unittest
import sys
sys.path.append('../lib')
from node import *

class TestNode(unittest.TestCase):

    def setUp(self):
        # dummy
        self.testing = True

    def test_add(self):
        node = Node(15)
        assert node.add(Node(8)) == node # .left

    def test_find(self):
        node = Node(15)
        assert node.find() == node

    def tearDown(self):
        # dummy
        self.testing = False

if __name__ == '__main__':
    unittest.main()
