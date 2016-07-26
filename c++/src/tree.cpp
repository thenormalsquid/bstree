#include <iostream>
#include <string>
#include <tree.h>

void Tree::add(Node * node) {
  this->root->add(node);
}

Node * Tree::find(int value) {
  found = false;
  return find_node(value, root);
}

Node * Tree::maximum(void) {
  return root->maximum();
}

Node * Tree::minimum(void) {
  return root->minimum();
}

Node * Tree::find_node(int value, Node * node) {
  if (node == NULL) return node;
  if (node->value == value) return node;

  if (node->left != NULL && value < node->value) {
    return find_node(value, node->left);
  } else if (node->right != NULL) {
    return find_node(value, node->right);
  }
}

std::vector<int> Tree::collect() {
  collect_values(root);
  return values;
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
