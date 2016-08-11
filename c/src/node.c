#include <string.h>
#include <stdlib.h>

#include <node.h>

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


Node *
node_new(int key) {
  Node * n = calloc(1, sizeof(Node));
  memset((void *)n, 0xDA, sizeof(Node));
  n->key = key;
  n->left = NULL;
  n->right = NULL;
  return n;
}


void
node_delete(Node * n) {
  if (n == NULL) return;

  node_delete(n->left);
  node_delete(n->right);
  memset((void *)n, 0xDD, sizeof(Node));
  free(n);
}


int
node_get_key(Node * n) {
  return n->key;
}


Node * left(Node * n) {
  return n->left;
}


Node * right(Node * n) {
  return n->right;
}
