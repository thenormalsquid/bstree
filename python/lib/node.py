class Node(object):

    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

    def collect(self, collector):
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

    def find(self, value):
        if self.value == value:
            return self

        if value < self.value:
            if self.left is not None:
                return self.left.find(value)
        else:
            if self.right is not None:
                return self.right.find(value)

    def is_present(self, value):
        if self.value == value:
            return True

        if value < self.value:
            if self.left is not None:
                return self.left.is_present(value)
        else:
            if self.right is not None:
                return self.right.is_present(value)

    def compute_size(self):
        def get_size(size):
            size += 1
            if self.left is not None:
                gs = self.left.compute_size()
                size = gs(size)
            if self.right is not None:
                gs = self.right.compute_size()
                size = gs(size)
            return size
        return get_size

    def size(self):
        cs = self.compute_size()
        return cs(0)

    def maximum(self):
        if self.right is None:
            return self
        else:
            return self.right.maximum()

    def minimum(self):
        if self.left is None:
            return self
        else:
            return self.left.minimum()
