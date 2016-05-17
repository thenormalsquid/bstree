#ifndef IS_TREE_H
#define IS_TREE_H

#include <string>
#include <vector>
#include "./node.h"

class Tree {
public:
  Tree(Node * _root) : root(_root) {}

  void add(Node * node);
  std::vector<int> collect(void);
  Node * find(int);

  Node * root;
  std::vector<int> values;

private:
  Node * find_node(int, Node * node);
  void collect_values(Node * node);
  void get_left(Node * node);
  void get_right(Node * node);
};

#endif /* IS_TREE_H */
