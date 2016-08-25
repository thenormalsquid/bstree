package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;

class Node {
    public int value;
    public Node left = null;
    public Node right = null;

    // TODO: rewrite this to use a lambda if possible
    private int get_height(int height, int max) {
      int current = ++height;

      if (this.left != null) { max = this.left.get_height(current, max); }
      if (this.right != null) { max = this.right.get_height(current, max); }
      current--;
      max = current > max ? current : max;
      return max;
    }

    public int height() {
      int height = 0;
      int max = 0;
      return get_height(height, max);
    }

    // TODO: turn this into a lambda and pass to a post-order traversal
    private int get_size(int size) {
      if (this.left != null) { size = this.left.get_size(size); }
      if (this.right != null) { size = this.right.get_size(size); }
      return ++size;
    }

    public int size() {
      int size = 0;
      return get_size(size);
    }

    public Node maximum() {
      if (this.right == null) {
        return this;
      } else {
        return this.right.maximum();
      }
    }

    public Node minimum() {
      if (this.left == null) {
        return this;
      } else {
        return this.left.minimum();
      }
    }

    public Node search(int key) {
      if (this.value == key) { return this; }

      if (key < this.value) {
        if (this.left != null) {
          return this.left.search(key);
        }
      } else {
        if (this.right != null) {
          return this.right.search(key);
        }
      }
      return null;
    }

    public boolean is_present(int key) {
      if (this.value == key) { return true; }

      if (key < this.value) {
        if (this.left != null) {
          return this.left.is_present(key);
        }
      } else {
        if (this.right != null) {
          return this.right.is_present(key);
        }
      }
      return false;
    }

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

    public void collect(ArrayList<Integer> collector) {
      if (this.left != null) { this.left.collect(collector); }
      collector.add(this.value);
      if (this.right != null) { this.right.collect(collector); }
    }

    public Node(int v) {
        value = v;
    }

    public static void main(String [] args) {
        System.out.println("From Node main...");
    };
};
