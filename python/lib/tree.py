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

    # algorithm originally taken from CLR p. 253
    # parent pointers are part of CLR's definition of
    # node in BST.
    def clr_delete(T, node):
        print T
        print node
        print node.key
        z, p = T.root.find_with_parent(node.key)
        print z
        print p

        if z.left is None or z.right is None:
            y = z
        else:
            y = T.root.successor(z)
            print "from root successor: %d" % y.key

        if y.left is not None:
            x = y.left
        else:
            print "x = y.right"
            x = y.right

        if x is not None:
            x.p = y.p # p is link to parent node

        if y.p is None:
            print "y.p is None"
            print x
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
