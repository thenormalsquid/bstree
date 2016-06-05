#include <iostream>
#include <string>
#include <tree.h>

void Tree::add(Node * node) {
  this->root->add(node);
}

std::vector<int> Tree::collect() {
  collect_values(root);
  return values;
}

Node * Tree::find(int value) {
  found = false;
  return find_node(value, root);
}

Node * Tree::find_node(int value, Node * node) {
  if (found) return node;
  std::cout << "node->value: " << node->value << std::endl;
  if (node->value == value) {
    std::cout << "FOUND..." << std::endl;
    found = true;
    return node;
  }
  find_left(value, node);
  find_right(value, node);

  std::cout << "here..." << std::endl;
  return (Node *) NULL;
}

void Tree::find_left(int value, Node * n) {
  if (found) return;
  if (n->left == NULL) return;
  find_node(value, n->left);
}

void Tree::find_right(int value, Node * n) {
  if (found) return;
  if (n->right == NULL) return;
  find_node(value, n->right);
}

void Tree::collect_values(Node * node) {
  get_left(node);
  values.push_back(node->value);
  get_right(node);
}

void Tree::get_left(Node * node) {
  if (node->left == NULL) {
    return;
  } else {
    collect_values(node->left);
  }
}

void Tree::get_right(Node * node) {
  if (node->right == NULL) {
    return;
  } else {
    collect_values(node->right);
  }
}
