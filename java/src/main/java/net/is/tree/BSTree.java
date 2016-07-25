package net.is.tree;

class BSTree {
    public Node root;

    public void insert(Node n) {
        root.insert(n);
    }

    public BSTree(Node r) {
        root = r;
    }

    public static void main(String [] args) {
        System.out.println("From BSTree main...");
    };
};
