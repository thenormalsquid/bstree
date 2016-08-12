#ifndef IS_BST_NODE_H
#define IS_BST_NODE_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _node Node;

Node * node_new        (int key);

void   node_destroy    (Node * n);

int    node_key        (Node * n);

void   node_insert     (Node * root,
                        Node * next);

Node * node_left       (Node * n);

Node * node_right      (Node * n);

void   node_collect    (void);

void   node_search     (void);

void   node_is_present (void);

void   node_height     (void);

void   node_delete     (void);

void   node_maximum    (void);

void   node_minimum    (void);

void   node_is_full    (void);

void   node_is_bst     (void);

void   node_size       (void);

#ifdef __cplusplus
}
#endif

#endif /* IS_BST_NODE_H */
