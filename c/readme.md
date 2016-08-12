# Binary search tree in c

Implementing a binary search tree in c is not an unduly
difficult project. Implementing one which is properly
engineered with test code, a useful API, which doesn't
leak memory is quite another thing.

This is an attempt at that other thing.


## Implementation plan

* Stub out header and source files for node and tree, and
ensure everything compiles, and is reachable by the test harness.

* Node then Tree insertion, first tests, then implementation. Probably
need to find a way to check the result of insertion before, perhaps
with a private_node.h defining the node struct such that the test
can access left and right children.


## Deleting nodes

There is a difference between deleting a single node, and recursively
deleting an entire tree of nodes. Given this difference, the question
becomes where should each be implemented? Should a node be responsible
for deleting any subtree nodes, or only itself and defer deleting
a tree or subtree to the tree container (or a function specifically
written to delete subtrees)?
