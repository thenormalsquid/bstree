import pdb

class Node(object):

    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

    def collect(self, collector):
        # pdb.set_trace()

        if self.left is None:
            pass
        else:
            self.left.collect(collector)

        collector.append(self.value)

        if self.right is None:
            pass
        else:
            self.right.collect(collector)

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
