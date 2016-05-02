# Simple binary search tree in Ruby

This tiny little project came about as a result of a conversation
with a coworker, a self-taught programmer with a background in
Russian literature. We both agreed we needed to step it up a bit,
and binary search trees seemed like an excellent place to start.


## Finding a node

In a really simple case, the node key and value can be the same.
For example, any atomic (<- is the right word?) object such as
an integer or character, which can be ordered can be used as a
key.

One way to implement find is to have all the operations for find
as part of the node class, then pass the key to the root node
from the tree data structure. This is what is implemented here,
and works similarly to the `add` method.

Another possibility is to implement the traversal in the tree
class.

## TODO

* Create a simple data structure to store, subclass `Struct`
* Add  `node.key` and use value for some associated data object

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Binary_search_tree), because
  there's no shame in simply getting started however which way, and
  Wikipedia is free for everyone.
* [CLR]() Gold standard.
* [Skienna](), a very useful reference with readable exposition and a
  unique slant.
