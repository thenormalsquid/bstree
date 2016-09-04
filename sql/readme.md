# SQL-based binary search tree

So far, all the other implementations of binary search tree been
procedural (or procedural within an object-oriented context). Using an
SQL relation for storing and operating on a binary search tree requires
conceptually different thinking.

But why attempt implementing a binary search tree in SQL? Seems
somewhat pointless.

The best reason was just mentioned: it requires conceptually different
thinking.

Another good reason is hierarchal data is occasionally stored in a
relational database, and the SQL recursion necessary for operating
on a binary search tree are similar to other recursive queries in SQL
for general tree operations.

## Implementation

Here's a list of some tasks for getting started:

* (DONE) implement a simple sql/bash system for defining a schema and
  provisioning a tree.

* Implement is_present first, that will be the easiest as it's a simple
  query on the table.
