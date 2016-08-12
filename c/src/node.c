#include <string.h>
#include <stdlib.h>

#include <node.h>
#include "node_private.h"


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
node_destroy(Node * n) {
  if (n == NULL) return;

  node_destroy(n->left);
  node_destroy(n->right);
  memset((void *)n, 0xDD, sizeof(Node));
  free(n);
}


int
node_key(Node * n) {
  return n->key;
}


Node *
node_left(Node * n) {
  return n->left;
}


Node *
node_right(Node * n) {
  return n->right;
}

void
node_insert(Node * root, Node * next) {
  if (next->key < root->key) {
    if (root->left == NULL) {
      root->left = next;
    } else {
      node_insert(root->left, next);
    }
  } else {
    if (root->right == NULL) {
      root->right = next;
    } else {
      node_insert(root->right, next);
    }
  }
}

void
node_collect(void) {
}

void
node_search(void) {
}

void
node_is_present(void) {
}

void
node_height(void) {
}

void
node_delete(void) {
}

void
node_maximum(void) {
}

void
node_minimum(void) {
}

void
node_is_full(void) {
}

void
node_is_bst(void) {
}

void
node_size(void) {
}
