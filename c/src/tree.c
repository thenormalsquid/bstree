#include <string.h>
#include <stdlib.h>

#include <tree.h>
#include "tree_private.h"

//struct _tree {
//  Node * root;
//};

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
tree_insert(Tree * t, Node * n) {
  if (t->root == NULL) {
    t->root = n;
  } else {
    node_insert(t->root, n);
  }
}

int
tree_is_empty(Tree * t) {
  return t->root == NULL ? TRUE : FALSE;
}

void
tree_collect(Tree * t, void * collector) {
  if (t->root == NULL) { return; }
  node_collect(t->root, collector);
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

int
tree_size(Tree * t) {
  if (t->root == NULL) return 0;
  return node_size(t->root);
}
