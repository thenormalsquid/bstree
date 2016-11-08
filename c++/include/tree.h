#ifndef IS_TREE_H
#define IS_TREE_H

#include <string>
#include <vector>
#include <memory>
#include "./node.h"

class Tree {
public:
  Tree() : root(nullptr) {}
  Tree(Node * _root) : root(_root) {}
  // Tree(std::unique_ptr<Node> _root) : root(_root) {}

  void transplant(Node * u, Node * v);
  void insert(Node * node);
  void collect(std::vector<int> & keys);
  std::vector<int> list_keys(void);
  Node * find(int);
  Node * successor(Node * n);
  Node * predecessor(Node * n);
  Node * maximum(void);
  Node * minimum(void);

  bool is_bst(void);
  bool is_empty(void);
  int size(void);
  int height(void);

  bool is_present(int key);

  Node * root;
  //std::vector<int> keys;

private:
  Node * find_node(int key, Node * node);

  /*
  void collect_keys(Node * node);
  void get_left(Node * node);
  void get_right(Node * node);
  */

  bool found;
};

#endif /* IS_TREE_H */
