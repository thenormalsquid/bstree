#ifndef IS_NODE_H
#define IS_NODE_H

#include<functional>

class Node {

  private:
    int get_height(int current, int max);
    bool get_is_bst(int minimum, bool result);
    Node * get_successor(Node * node, Node * parent, Node * successor);
    Node * get_predecessor(Node * node, Node * parent, Node * successor);

  public:
    Node(int _value) : value(_value), left(nullptr), right(nullptr) {}

    // void post_order_traverse(std::function<void (const Node&)> callback);
    void post_order_traverse(std::function<void (void)> callback);

    void insert(Node * node);
    void insert_left(Node * node);
    void insert_right(Node * node);

    bool is_present(int);

    Node * successor(Node * n);
    Node * predecessor(Node * n);
    Node * maximum(void);
    Node * minimum(void);
    bool is_bst(void);
    int size(void);
    int height(void);

    int value;
    Node * left;
    Node * right;
};

#endif /* IS_NODE_H */
