# Binary search tree c++

I haven't written a binary tree since the mid-1990s. Really haven't had
much need: the projects I've worked on have been built with libraries
implementing equivalent functionality, or just haven't needed it.

But it's such a simple elegant thing, and c++11/14 is so much nicer than
it used to be, it's inspiring to go back and revisit this simple data
structure.

## TODO

* (DONE) Extend `Tree` to add nodes`
* (DONE) Implement `Tree.collect` for in-order traversal to e.g., list out
  value of nodes.
* Build tree with all pointer data (instead off on the stack).
* Return list of nodes in the tree as well as the keys/values.
* Implement post-order traversal to ensure all nodes are freed before
  tree is freed. This will force me to brush up on my c++ pointer juju.
  Apparently raw pointers (`new`, `delete`) are out.
