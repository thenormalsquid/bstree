from node import *

class Tree(object):

    def __init__(self, node):
        self.root = node

    def add(self, node):
        self.root.add(node)

    def find(self, value):
        return self.root
