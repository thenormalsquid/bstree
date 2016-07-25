package net.is.tree;

class Node {
    public int value;
    public Node left = null;
    public Node right = null;

    // so...wordy...maybe change to ternary with
    // a couple of private calls with ternaries
    public void insert(Node node) {
        if (node.value < this.value) {
            if (left == null) {
              left = node;
            } else {
              left.insert(node);
            }
        } else {
            if (right == null) {
              right = node;
            } else {
              right.insert(node);
            }
        }
    }

    public Node(int v) {
        value = v;
    }

    public static void main(String [] args) {
        System.out.println("From Node main...");
    };
};
