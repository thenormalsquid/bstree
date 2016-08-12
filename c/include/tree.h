#ifndef IS_BST_TREE_H
#define IS_BST_TREE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <node.h>

typedef struct _tree Tree;

Tree * tree_new    (void);

void   tree_delete (Tree * t);

void   tree_insert (Node * n);

void   tree_collect(void);

void   tree_search(void);

void   tree_is_present(void);

void   tree_height(void);

void   tree_destroy(void);

void   tree_maximum(void);

void   tree_minimum(void);

void   tree_is_full(void);

void   tree_is_bst(void);

void   tree_size(void);

#ifdef __cplusplus
}
#endif

#endif /* IS_BST_TREE_H */
