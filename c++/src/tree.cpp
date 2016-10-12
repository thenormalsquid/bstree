#include <iostream>
#include <string>
#include <tree.h>

void Tree::insert(Node * node) {
  if (root == nullptr) {
    root = node;
    return;
  }
  this->root->insert(node);
}

Node * Tree::find(int key) {
  if (root == nullptr) return nullptr;
  return find_node(key, root);
}

Node * Tree::maximum(void) {
  if (root == nullptr) return nullptr;
  return root->maximum();
}

Node * Tree::minimum(void) {
  if (root == nullptr) return nullptr;
  return root->minimum();
}

int Tree::size(void) {
  if (root == nullptr) return 0;
  return root->size();
}

int Tree::height(void) {
  if (root == nullptr) return 0;
  return root->height();
}

Node * Tree::successor(Node * node) {
  if (root == nullptr) return nullptr;
  return root->successor(node);
}

Node * Tree::predecessor(Node * node) {
  if (root == nullptr) return nullptr;
  return root->predecessor(node);
}

bool Tree::is_bst() {
  if (this->root == nullptr) { return true; }
  return this->root->is_bst();
}

bool Tree::is_present(int key) {
  return this->root->is_present(key);
}

// TODO: move the guts of this method to Node class
Node * Tree::find_node(int key, Node * node) {
  if (node == nullptr) return node;
  if (node->key == key) return node;

  if (node->left != nullptr && key < node->key) {
    return find_node(key, node->left);
  } else if (node->right != nullptr) {
    return find_node(key, node->right);
  }
  return nullptr;
}

std::vector<int> Tree::collect() {
  collect_keys(root);
  return keys;
}

// TODO: move to Node class
void Tree::collect_keys(Node * node) {
  get_left(node);
  keys.push_back(node->key);
  get_right(node);
}

void Tree::get_left(Node * node) {
  if (node->left == nullptr) {
    return;
  } else {
    collect_keys(node->left);
  }
}

void Tree::get_right(Node * node) {
  if (node->right == nullptr) {
    return;
  } else {
    collect_keys(node->right);
  }
}
