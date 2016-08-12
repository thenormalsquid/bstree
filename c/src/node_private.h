#ifndef IS_BST_NODE_PRIVATE_H
#define IS_BST_NODE_PRIVATE_H


// move the definition to private_node.h so that it can be
// included in the test code.
// change this to PrivateNode
struct _node {
  // Node public; // publically defined in header file, exposes callbacks
  // for left and right to allow chaining...? Not sure this is possible
  // to do what I'm thinking of: n->left()->right();
  int key;
  Node * left;
  Node * right;
};


#endif /* IS_BST_NODE_PRIVATE_H */
