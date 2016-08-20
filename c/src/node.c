#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include <node.h>
#include <collector.h>
#include "node_private.h"

/*
 * State is a private struct used for mimicking "closures"
 * in plain old vanilla c.
 */
typedef struct _state {
  int size;
  int current_position;
  int * values;
  Node * n;
  //int height;
} State;


typedef void (*Callback)(Node * n, State * state);
typedef void (*Callback1)(Node * n, State * state);

void
post_order_traverse(Node * n, Callback callback, State * state) {
  // consider if (n == NULL) return;

  if (n->left  != NULL) { post_order_traverse(n->left, callback, state); }
  if (n->right != NULL) { post_order_traverse(n->right, callback, state); }
  if (callback != NULL) { callback(n, state); }
}

void
in_order_traverse(Node * n, Callback1 callback, void * userdata) {
  if (n->left  != NULL) { in_order_traverse(n->left, callback, userdata); }
  if (callback != NULL) { callback(n, userdata); }
  if (n->right != NULL) { in_order_traverse(n->right, callback, userdata); }
}


Node *
node_new(int key) {
  Node * n = calloc(1, sizeof(Node));
  memset((void *)n, 0xDA, sizeof(Node));
  n->key = key;
  n->left = NULL;
  n->right = NULL;
  return n;
}


/*
 * TODO: Reimplement using post_order_traverse.
 */
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
value_collector(Node * n, void * userdata) {
  Collector * c = (Collector *) userdata;
  c->values[c->current_position] = n->key;
  c->current_position++;
}

/* The way to do this is send a struct with the memory handling
 * directly into collect, deal with the memory management from the
 * calling function.
 */
void
node_collect(Node * n, void * userdata) {
  Collector * collector = (Collector *) userdata;
  in_order_traverse(n, value_collector, (void*)collector);

  /*
  State state;
  state.current_position = 0;
  state.values = (int*)calloc(100, sizeof(int));
  in_order_traverse(n, value_collector, &state);
  for (int i = 0; i < state.current_position; i++) {
    printf("%d ", state.values[i]);
  }
  printf("\n");

  free(state.values);
  */
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
size_tracker(Node * n, State * state) {
  state->size++;
}

int
node_size(Node * n) {
  State state;
  state.size = 0;
  post_order_traverse(n, size_tracker, &state);
  return state.size;
}
