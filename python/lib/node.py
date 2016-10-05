class Node(object):

    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None

    def collect(self, collector):
        if self.left is None:
            pass
        else:
            self.left.collect(collector)

        collector.append(self.key)

        if self.right is None:
            pass
        else:
            self.right.collect(collector)

    def insert(self, node):
        if node.key < self.key:
            if self.left is None:
                self.left = node
            else:
                self.left.insert(node)
        else:
            if self.right is None:
                self.right = node
            else:
                self.right.insert(node)

    def find(self, key):
        if self.key == key:
            return self

        if key < self.key:
            if self.left is not None:
                return self.left.find(key)
        else:
            if self.right is not None:
                return self.right.find(key)

    # TODO: add find_with_parent here, to support delete

    def is_present(self, key):
        if self.key == key:
            return True

        if key < self.key:
            if self.left is not None:
                return self.left.is_present(key)
        else:
            if self.right is not None:
                return self.right.is_present(key)

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

    def get_successor(self, node, parent, successor):
        if parent.left is not None:
            if parent.left.key == self.key:
                successor = parent

        if node.key == self.key:
            if node.right is not None:
                return node.right.minimum()
            else:
                return successor

        if node.key < self.key:
            if self.left is not None:
                return self.left.get_successor(node, self, successor)
        else:
            if self.right is not None:
                return self.right.get_successor(node, self, successor)


    def successor(self, node):
        return self.get_successor(node, self, node)

    def get_predecessor(self, node, parent, predecessor):
        if parent.right is not None:
            if parent.right.key == self.key:
                predecessor = parent

        if node.key == self.key:
            if node.left is not None:
                return node.left.maximum()
            else:
                return predecessor

        if node.key < self.key:
            if self.left is not None:
                return self.left.get_predecessor(node, self, predecessor)
        else:
            if self.right is not None:
                return self.right.get_predecessor(node, self, predecessor)

    def predecessor(self, node):
        return self.get_predecessor(node, self, node)

    # TODO: refactor this to work with a generic in_order_traverse
    def is_bst(self, minimum=-1000, result=True):
        # print "self.key: %s" % self.key
        if self.left is not None:
            result = self.left.is_bst(minimum, result)

        # print "minimum before checking: %s" % minimum
        if minimum >= self.key:
            result = False
            # print "result: %s" % result
            return result

        minimum = self.key
        # print "minimum after checking: %s" % minimum

        if self.right is not None:
            result = self.right.is_bst(minimum, result)

        return result

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
