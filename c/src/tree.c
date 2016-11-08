#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <tree.h>
#include "tree_private.h"
#include "node_private.h" // needed for delete implementation, bummer

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

void
tree_unlink(Tree * t) {
  if (t->root == NULL) return;
  node_unlink(t->root);
  t->root = NULL;
}

void
tree_transplant(Tree * t, Node * u, Node * v) {
  if (u == t->root) {
    t->root = v;
  } else if (u->parent->left == u) {
    u->parent->left = v;
  } else {
    u->parent->right = v;
  }

  if (v != NULL) {
    v->parent = u->parent;
  }
}

int
tree_is_empty(Tree * t) {
  return t->root == NULL ? TRUE : FALSE;
}

void
tree_list_keys(Tree * t, void * userdata) {
  tree_collect(t, userdata);
}

void
tree_collect(Tree * t, void * collector) {
  if (t->root == NULL) { return; }
  node_collect(t->root, collector);
}

Node *
tree_search(Tree * t, int key) {
  if (t->root == NULL) return NULL;
  return node_search(t->root, key);
}

int
tree_is_present(Tree * t, int key) {
  if (t->root == NULL) return 0;
  return node_is_present(t->root, key);
}

int
tree_is_bst(Tree * t) {
  if (t->root == NULL) return 1;
  return node_is_bst(t->root);
}

int
tree_height(Tree * t) {
  if (t->root == NULL) return 0;
  return node_height(t->root);
}

void
tree_destroy(void) {
}

Node *
tree_successor(Tree * tree, Node * node) {
  if (tree->root == NULL) return NULL;
  return node_successor(tree->root, node);
}

Node *
tree_predecessor(Tree * tree, Node * node) {
  if (tree->root == NULL) return NULL;
  return node_predecessor(tree->root, node);
}

Node *
tree_maximum(Tree * t) {
  if (t->root == NULL) return NULL;
  return node_maximum(t->root);
}

Node *
tree_minimum(Tree * t) {
  if (t->root == NULL) return NULL;
  return node_minimum(t->root);
}

void
tree_is_full(void) {
}

int
tree_size(Tree * t) {
  if (t->root == NULL) return 0;
  return node_size(t->root);
}
