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

  if (this->left != NULL && value < this->left->value) {
    return left->is_present(value);
  } else if (this->right != NULL) {
    return right->is_present(value);
  }
  return false;
}

void Node::post_order_traverse(std::function<void (void)> callback) {
  if (left != NULL) { left->post_order_traverse(callback); }
  if (right != NULL) { right->post_order_traverse(callback); }
  callback();
}

int Node::get_height(int height, int max) {
  int current = ++height;
  if (left != NULL) { max = left->get_height(current, max); }
  if (right != NULL) { max = right->get_height(current, max); }
  current--;
  return current > max ? current : max;
}

int Node::height(void) {
  return get_height(0, 0);
}

int Node::size(void) {
  int size = 0;
  post_order_traverse([&]{ size++; });
  return size;
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
