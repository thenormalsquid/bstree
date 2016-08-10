#ifndef IS_BST_H
#define IS_BST_H

typedef struct _tree Tree;

Tree * tree_new    (int key);

void   tree_delete (Tree * t);


#endif /* IS_BST_H */
