package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;

class BSTree {
    public Node root;

    public boolean is_bst() {
      if (root == null) { return true; }
      return root.is_bst();
    }

    public Node maximum() {
        if (root == null) { return null; }
        return root.maximum();
    }

    public Node minimum() {
        if (root == null) { return null; }
        return root.minimum();
    }

    public Node predecessor(Node node) {
      if (root == null) { return null; }
      return root.predecessor(node);
    }

    public Node successor(Node node) {
      if (root == null) { return null; }
      return root.successor(node);
    }

    public List<Integer> collect() {
        ArrayList<Integer> actual = new ArrayList<Integer>();
        if (this.root == null) { return actual; }
        this.root.collect(actual);
        return actual;
    }

    public Node search(int key) {
      if (root != null) {
        return root.search(key);
      }
      return null;
    }

    public boolean is_present(int key) {
      if (root == null) { return false; }
      return root.is_present(key);
    }

    public int height() {
      if (root == null) { return 0; }
      return root.height();
    }

    public int size() {
        if (root == null) {
          return 0;
        } else {
          return root.size();
        }
    }

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
