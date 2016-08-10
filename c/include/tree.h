#ifndef IS_BST_TREE_H
#define IS_BST_TREE_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _tree Tree;

Tree * tree_new    (void);

void   tree_delete (Tree * t);

#ifdef __cplusplus
}
#endif

#endif /* IS_BST_TREE_H */
