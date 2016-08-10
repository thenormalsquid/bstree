from node import *

class Tree(object):

    def __init__(self, node):
        self.root = node
        self.max = 0
        self.current = 0

    def add(self, node):
        self.root.add(node)

    def find(self, value):
        return self.root.find(value)

    def is_present(self, value):
        return self.root.is_present(value)

    def collect(self, collector):
        self.root.collect(collector)

    def size(self):
        return self.root.size()

    def height(self):
        return self.get_height(self.root)

    def get_height(self, node):
        if node is None:
            return self.current

        self.current += 1
        self.get_height(node.left)
        self.get_height(node.right)
        self.current -= 1

        if self.max < self.current:
            self.max = self.current
        return self.max
