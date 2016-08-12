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
  node_destroy(t->root);
  memset((void *)t, 0xDD, sizeof(Tree));
  free(t);
}

void
tree_insert(Node * n) {
}

void
tree_collect(void) {
}

void
tree_search(void) {
}

void
tree_is_present(void) {
}

void
tree_height(void) {
}

void
tree_destroy(void) {
}

void
ree_maximum(void) {
}

void
tree_minimum(void) {
}

void
tree_is_full(void) {
}

void
tree_is_bst(void) {
}

void
tree_size(void) {
}
