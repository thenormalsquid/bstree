#include <string>
#include <node.h>

void Node::add(Node & node) {
  this->left = &node;
}

std::string
get_node(void) {

  return std::string("node");
}
