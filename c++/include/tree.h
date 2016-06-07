#ifndef IS_TREE_H
#define IS_TREE_H

#include <string>
#include <vector>
#include <memory>
#include "./node.h"

class Tree {
public:
  Tree(Node * _root) : root(_root) {}
  // Tree(std::unique_ptr<Node> _root) : root(_root) {}

  void add(Node * node);
  std::vector<int> collect(void);
  Node * find(int);

  Node * root;
  std::vector<int> values;

private:
  Node * find_node(int value, Node * node);
  Node * find_left(int value, Node * node);
  Node * find_right(int value, Node * node);

  void collect_values(Node * node);
  void get_left(Node * node);
  void get_right(Node * node);

  bool found;
};

#endif /* IS_TREE_H */