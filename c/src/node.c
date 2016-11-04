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


// Clean this up and whereever State is used,
// cast it to void * userdata
typedef void (*Callback)(Node * n, State * state);
typedef void (*Callback1)(Node * n, void * userdata);

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
      next->parent = root;
      root->left = next;
    } else {
      next->parent = root;
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
  in_order_traverse(n, value_collector, (void *) collector);
}

Node *
node_search(Node * n, int key) {
  if (n->key == key) return n;

  if (key < n->key) {
    if (n->left != NULL) return node_search(n->left, key);
  } else {
    if (n->right != NULL) return node_search(n->right, key);
  }
  return NULL;
}

int
node_is_present(Node * n, int key) {
  if (n->key == key) return 1;

  if (key < n->key) {
    if (n->left != NULL) return node_is_present(n->left, key);
  } else {
    if (n->right != NULL) return node_is_present(n->right, key);
  }
  return 0;
}

// TODO: use size_t instead
int
get_height(Node * n, int height, int max) {
  int current = ++height;
  if (n->left != NULL) { max = get_height(n->left, current, max); }
  if (n->right != NULL) { max = get_height(n->right, current, max); }
  current--;
  return current > max ? current : max;
}

int
node_height(Node * n) {
  return get_height(n, 0, 0);
}

Node *
get_successor(Node * this, Node * node, Node * parent, Node * successor) {
  if (parent->left == this) successor = parent;

  if (this == node) {
    if (this->right != NULL) {
      return node_minimum(this->right);
    } else {
      return successor;
    }
  }

  if (node->key < this->key) {
    if (this->left != NULL) {
      return get_successor(this->left, node, this, successor);
    }
  } else {
    if (this->right != NULL) {
      return get_successor(this->right, node, this, successor);
    }
  }
  return NULL;
}

Node *
node_successor(Node * this, Node * node) {
  return get_successor(this, node, this, node);
}

Node *
get_predecessor(Node * this, Node * node, Node * parent, Node * predecessor) {
  if (parent->right == this) { predecessor = parent; }

  if (this == node) {
    if (this->left != NULL) {
      return node_maximum(this->left);
    } else {
      return predecessor;
    }
  }

  if (node->key < this->key) {
    if (this->left != NULL) {
      return get_predecessor(this->left, node, this, predecessor);
    }
  } else {
    if (this->right != NULL) {
      return get_predecessor(this->right, node, this, predecessor);
    }
  }
}

Node *
node_predecessor(Node * this, Node * node) {
  return get_predecessor(this, node, this, node);
}

void
node_delete(void) {
}

Node *
node_maximum(Node * n) {
  if (n->right == NULL) { return n; }
  return node_maximum(n->right);
}

Node *
node_minimum(Node * n) {
  if (n->left == NULL) { return n; }
  return node_minimum(n->left);
}

void
node_is_full(void) {
}

void
unlinker(Node * n, State * state) {
  n->left = NULL;
  n->right = NULL;
  n->parent = NULL;
}

void
node_unlink(Node * n) {
  State state;
  post_order_traverse(n, unlinker, &state);
}

typedef struct _bst_data {
  int result;
  int minimum;
  int size;
} bst_data;

/*
 * This implementation walks the whole tree. The
 * `result = 0` on an out of order violation is
 * checked by the invoking function on return.
 * A better way to do this might be to return
 * immediately on an out-of-order violation,
 * if that's possible.
 */
void
check_minimum(Node * n, void * userdata) {
  bst_data * data = (bst_data *)userdata;
  if (data->minimum >= n->key) { data->result = 0; }
  data->minimum = n->key;
}

int
node_is_bst(Node * node) {
  int result = 1;

  bst_data * userdata = (bst_data*)malloc(sizeof(bst_data));
  userdata->result = 1;
  userdata-> minimum = -10000;

  in_order_traverse(node, check_minimum, (void *)userdata);

  result = userdata->result;
  free(userdata);
  return result;
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
