# Binary search trees

This little repo is part of an ongoing project to compare
how data structures are implemented in various languages.

## Specification

The `Tree` data structure API:

* `add` provisions the tree.
* `find` returns a reference to a particular node in the tree.
* `collect` prints values in order to some container or stream.
* `is_present` determines whether a key exists in the tree.
* `destroy` (c/c++) cleans up memory.

## Implementations

As of 2016-05-08, parts of the API have been implemented in Ruby and C++.

## Fun things to do

Here is a list of various exercises and questions pulled from books and
web pages.

* Laakman asks (Ex. 4.7, p. 86) how to find the first common ancestor for
two nodes in a binary tree, which is not necessarily a binary search
tree. (Binary search tree is probably much easier than an arbitrary
binary tree.)
