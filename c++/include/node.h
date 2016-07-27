#ifndef IS_NODE_H
#define IS_NODE_H

class Node {

  public:
    Node(int _value) : value(_value), left(NULL), right(NULL) {}

    void add(Node * node);
    void add_left(Node * node);
    void add_right(Node * node);

    bool is_present(int);

    Node * maximum(void);
    Node * minimum(void);

    int value;
    Node * left;
    Node * right;
};


std::string get_node(void);

#endif /* IS_NODE_H */
