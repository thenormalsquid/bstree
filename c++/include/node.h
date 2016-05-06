#ifndef IS_NODE_H
#define IS_NODE_H

class Node {

  public:
    Node(int _value) : value(_value) {}

    void add(Node & node);

    int value;
    Node * left;
};


std::string get_node(void);

#endif /* IS_NODE_H */
