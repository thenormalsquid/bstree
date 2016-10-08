from node import *

class Tree(object):

    def __init__(self, node):
        self.root = node
        self.max = 0
        self.current = 0

    def insert(self, node):
        self.root.insert(node)

    def find(self, value):
        return self.root.find(value)

    def is_present(self, value):
        return self.root.is_present(value)

    def collect(self, collector):
        self.root.collect(collector)

    def to_a(self):
        collector = []
        self.collect(collector)
        return collector

    def size(self):
        return self.root.size()

    def maximum(self):
        return self.root.maximum()

    def minimum(self):
        return self.root.minimum()

    def is_bst(self):
        return self.root.is_bst()

    def height(self):
        return self.get_height(self.root)

    def successor(self, node):
        return self.root.successor(node)

    def predecessor(self, node):
        return self.root.predecessor(node)

    # Refactored and renamed from CLR. The CLR code is very
    # difficult to follow as it has a lot of conditional statements
    # and single letter temporary nodes (x, y, z).
    def clr_delete(self, node):
        # for sanity checking as delete method is refactored
        # return T.clr_delete_original(node)

        z = self.root.find(node.key)

        if z.left and z.right:
            node_to_delete = self.root.successor(z)
        else:
            node_to_delete = z

        if node_to_delete.left:
            x = node_to_delete.left
        else:
            x = node_to_delete.right

        if x is not None:
            x.p = node_to_delete.p

        if node_to_delete.p is None:
            self.root = x
        else:
            if node_to_delete == node_to_delete.p.left:
                node_to_delete.p.left = x
            else:
                node_to_delete.p.right = x

        if node_to_delete != z:
            z.key = node_to_delete.key

        return node_to_delete


    # algorithm originally taken from CLR p. 253
    # parent pointers are part of CLR's definition of
    # node in BST.
    def clr_delete_original(T, node):
        z = T.root.find(node.key)

        if z.left is None or z.right is None:
            y = z
        else:
            y = T.root.successor(z)

        if y.left:
            x = y.left
        else:
            x = y.right

        if x is not None:
            x.p = y.p

        if y.p is None:
            T.root = x
        else:
            if y == y.p.left:
                y.p.left = x
            else:
                y.p.right = x

        if y != z:
            z.key = y.key

        return y


    # TODO: move the logic into the Node class
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
