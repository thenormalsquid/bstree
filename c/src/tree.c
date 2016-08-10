// #ifdef __cplusplus
// extern "C" {
// #endif

#include <string.h>
#include <stdlib.h>

#include <tree.h>
#include <node.h>

struct _tree {
  Node * root;
};

Tree *
tree_new(void) {
  Tree * t = calloc(1, sizeof(Tree));
  memset((void *)t, 0xDA, sizeof(Tree));
  return t;
}

void
tree_delete(Tree * t) {
  memset((void *)t, 0xDD, sizeof(Tree));
  free(t);
}

// #ifdef __cplusplus
// }
// #endif
