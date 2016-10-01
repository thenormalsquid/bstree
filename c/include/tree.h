#ifndef IS_BST_TREE_H
#define IS_BST_TREE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <node.h>

typedef struct _tree Tree;

Tree * tree_new         (void);

void   tree_delete      (Tree * t);
 
void   tree_insert      (Tree * t,
                         Node * n);

int    tree_is_empty    (Tree * t);

void   tree_collect     (Tree * t,
                         void * c);

Node * tree_search      (Tree * t,
                         int key);

int    tree_is_present  (Tree * t,
                         int key);

int    tree_height      (Tree * t);

void   tree_destroy     (void);

Node * tree_successor   (Tree * t,
                         Node * n);

Node * tree_predecessor (Tree * t,
                         Node * n);

Node * tree_maximum     (Tree * t);

Node * tree_minimum     (Tree * t);

void   tree_is_full     (void);

int    tree_is_bst      (Tree * t);

int    tree_size        (Tree * t);

#ifdef __cplusplus
}
#endif

#endif /* IS_BST_TREE_H */
