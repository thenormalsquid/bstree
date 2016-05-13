#include <string>

#include <tree.h>

void Tree::add(Node * node) {
  this->root->add(node);
}

void Tree::collect() {
  get_values(root);
}

void Tree::get_values(Node * node) {
  get_left(node);
  values.push_back(node->value);
  get_right(node);
}

void Tree::get_left(Node * node) {
}

void Tree::get_right(Node * node) {
}

std::string
get_tree(void) {

  return std::string("tree");
}
