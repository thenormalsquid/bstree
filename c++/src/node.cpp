#include <string>
#include <iostream>
#include <cstdlib>
#include <node.h>

void Node::add(Node * node) {
  if (node->value < this->value) {
    add_left(node);
  } else {
    add_right(node);
  }
}

void Node::add_left(Node * node) {
  if (this->left == NULL) {
    this->left = node;
  } else {
    left->add(node);
  }
}

void Node::add_right(Node * node) {
  if (this->right == NULL) {
    this->right = node;
  } else {
    right->add(node);
  }
}

bool Node::is_present(int value) {
  if (this->value == value) return true;

  if (this->left != NULL && this->left->value < value) {
    return left->is_present(value);
  } else if (this->right != NULL) {
    return right->is_present(value);
  }
}

Node * Node::minimum(void) {
  if (left == NULL) return this;
  return this->left->minimum();
}

Node * Node::maximum(void) {
  if (right == NULL) return this;
  return this->right->maximum();
}

std::string
get_node(void) {

  return std::string("node");
}
