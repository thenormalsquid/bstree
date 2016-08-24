package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;

class BSTree {
    public Node root;

    public Node maximum() {
        if (root == null) { return null; }
        return root.maximum();
    }

    public Node minimum() {
        if (root == null) { return null; }
        return root.minimum();
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

    public int size() {
        if (root == null) {
          return 0;
        } else {
          return 0;
          //return root.size();
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
