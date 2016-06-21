class Node(object):

    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None
        self.values = []

    def collect(self):
        if self.left == None:
            return
        else:
            self.left.collect()

        self.values.append(self.value)
        print self.value

        if self.right == None:
            return
        else:
            self.right.collect()

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
