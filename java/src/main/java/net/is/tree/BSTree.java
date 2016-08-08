package net.is.tree;

class BSTree {
    public Node root;

    public void insert(Node n) {
        if (root == null) {
            root = n;
        } else {
            root.insert(n);
        }
    }

    public BSTree(Node r) {
        root = r;
    }

    public BSTree() {
        root = null;
    }

    public static void main(String [] args) {
        System.out.println("From BSTree main...");
    };
};
