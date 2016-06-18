class Node(object):

    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

    def add(self, node):
        if node.value < self.value:
            if self.left is None:
                self.left = node
            else:
                self.left.add(node)
        else:
            if self.right is None:
                self.right = node
            else:
                self.right.add(node)

    def find(self):
        return self
