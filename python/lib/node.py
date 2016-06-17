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
                self.add(node.left)
        else:
            self.add(node.right)

        return self

    def find(self):
        return self
