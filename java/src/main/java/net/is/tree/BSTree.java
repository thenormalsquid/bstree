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

    public void transplant(Node u, Node v) {
        if (u == root) {
            root = v;
        } else if (u.parent.left == u) {
            u.parent.left = v;
        } else {
            u.parent.right = v;
        }

        if (v != null) { v.parent = u.parent; }
    }

    public Node delete_node(int key) {
      Node z = search(key);
      // TODO: handle null for node not found

      if (z.left == null) {
        transplant(z, z.right);
      } else if (z.right == null) {
        transplant(z, z.left);
      } else {
        Node y = z.right.minimum();
        if (y.parent != z) {
            transplant(y, y.right);
            y.right = z.right;
            y.right.parent = y;
        }
        transplant(z, y);
        y.left = z.left;
        y.left.parent = y;
      }

      z.unlink();
      return z;
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

    public ArrayList<Integer> list_keys() {
      ArrayList<Integer> collector = new ArrayList<Integer>();
      if (root == null) { return collector; }
      return root.list_keys();
    }

    // TODO: collect method should take a collector object
    // and not return anything. This gives us parallel implementation
    // with Node class.
    public void collect(ArrayList<Integer> collector) {
        if (this.root == null) { return; }
        this.root.collect(collector);
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
