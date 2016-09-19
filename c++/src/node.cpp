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
  if (this->left == nullptr) {
    this->left = node;
  } else {
    left->add(node);
  }
}

void Node::add_right(Node * node) {
  if (this->right == nullptr) {
    this->right = node;
  } else {
    right->add(node);
  }
}

bool Node::is_present(int value) {
  if (this->value == value) return true;

  if (this->left != nullptr && value < this->left->value) {
    return left->is_present(value);
  } else if (this->right != nullptr) {
    return right->is_present(value);
  }
  return false;
}

Node * Node::get_successor(Node * node, Node * parent, Node * successor) {
  if (parent->left != nullptr && parent->left == this) { successor = parent; }

  if (this == node) {
    if (this->right != nullptr) {
      return this->right->minimum();
    } else {
      return successor;
    }
  }

  if (node->value < this->value) {
    if (this->left != nullptr) {
      return this->left->get_successor(node, this, successor);
    }
  } else {
    if (this->right != nullptr) {
      return this->right->get_successor(node, this, successor);
    }
  }
}

Node * Node::successor(Node * node) {
  return get_successor(node, this, node);
}

Node * Node::get_predecessor(Node * node, Node * parent, Node * predecessor) {
  std::cout << "this value " << this->value << std::endl;
  std::cout << "node value " << node->value << std::endl;
  std::cout << "parent value " << parent->value << std::endl;
  std::cout << "predecessor before " << predecessor->value << std::endl;
  if (parent->right != nullptr && parent->right == this) { predecessor = parent; }
  std::cout << "predecessor after " << predecessor->value << std::endl;

  if (this == node) {
    if (this->left != nullptr) {
      //std::cout << "maximum " << this->value << std::endl;
      std::cout << "maximum " << std::endl;
      return this->left->maximum();
    } else {
      std::cout << "predecessor to return" << predecessor->value << std::endl;
      return predecessor;
    }
  }

  if (node->value < this->value) {
    if (node->left != nullptr) {
      return this->left->get_predecessor(node, this, predecessor);
    }
  } else {
    if (node->right != nullptr) {
      return this->right->get_predecessor(node, this, predecessor);
    }
  }
}

Node * Node::predecessor(Node * node) {
  std::cout << "root value " << this->value << std::endl;
  return get_predecessor(node, this, node);
}

void Node::post_order_traverse(std::function<void (void)> callback) {
  if (left != nullptr) { left->post_order_traverse(callback); }
  if (right != nullptr) { right->post_order_traverse(callback); }
  callback();
}

int Node::get_height(int height, int max) {
  int current = ++height;
  if (left != nullptr) { max = left->get_height(current, max); }
  if (right != nullptr) { max = right->get_height(current, max); }
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
  if (left == nullptr) return this;
  return this->left->minimum();
}

Node * Node::maximum(void) {
  if (right == nullptr) return this;
  return this->right->maximum();
}

std::string
get_node(void) {

  return std::string("node");
}
