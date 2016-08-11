#include <string.h>
#include <stdlib.h>

#include <tree.h>

struct _tree {
  Node * root;
};

Tree *
tree_new(void) {
  Tree * t = calloc(1, sizeof(Tree));
  memset((void *)t, 0xDA, sizeof(Tree));
  t->root = NULL;
  return t;
}

void
tree_delete(Tree * t) {
  node_delete(t->root);
  memset((void *)t, 0xDD, sizeof(Tree));
  free(t);
}

void
tree_insert(Node * n) {
}
