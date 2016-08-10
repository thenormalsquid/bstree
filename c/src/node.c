#include <string.h>
#include <stdlib.h>

#include <node.h>

struct _node {
  int key;
  Node * left;
  Node * right;
};

Node *
node_new(int key) {
  Node * n = calloc(1, sizeof(Node));
  memset((void *)n, 0xDA, sizeof(Node));
  n->key = key;
  return n;
}

void
node_delete(Node * n) {
  memset((void *)n, 0xDD, sizeof(Node));
  free(n);
}

int
node_get_key(Node * n) {
  return n->key;
}
