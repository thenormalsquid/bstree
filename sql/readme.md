# SQL-based binary search tree

So far, all the other implementations of binary search tree been
procedural (or procedural within an object-oriented context). Using an
SQL relation for storing and operating on a binary search tree requires
conceptually different thinking.

Here's a list of some tasks for getting started:

* (DONE) implement a simple sql/bash system for defining a schema and
  provisioning a tree.

* Implement is_present first, that will be the easiest as it's a simple
  query on the table.
