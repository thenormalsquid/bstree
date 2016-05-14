#include <string>
#include <tree.h>

void Tree::add(Node * node) {
  this->root->add(node);
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
