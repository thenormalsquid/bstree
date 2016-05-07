#ifndef IS_TREE_H
#define IS_TREE_H

#include <string>
#include "./node.h"

class Tree {
public:
  Tree(void) : value(1) {}

  void add(Node * node);

  Node * root;
  int value;
};


std::string get_tree(void);

#endif /* IS_TREE_H */
