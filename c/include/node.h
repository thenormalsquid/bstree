#ifndef IS_BST_NODE_H
#define IS_BST_NODE_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _node Node;

Node * node_new     (int key);

void   node_delete  (Node * n);

int    node_get_key (Node * n);

#ifdef __cplusplus
}
#endif

#endif /* IS_BST_NODE_H */
