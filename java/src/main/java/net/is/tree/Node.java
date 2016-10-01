package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;

class Node {
    public int value;
    public Node left = null;
    public Node right = null;

    private Node get_predecessor(Node node, Node parent, Node predecessor) {
      if (parent.right == this) { predecessor = parent; }

      if (node == this) {
        if (left != null) {
          return left.maximum();
        } else {
          return predecessor;
        }
      }

      if (node.value < this.value) {
        return left.get_predecessor(node, this, predecessor);
      } else {
        return right.get_predecessor(node, this, predecessor);
      }
    }

    public Node predecessor(Node node) {
      return get_predecessor(node, this, node);
    }

    private Node get_successor(Node node, Node parent, Node successor) {
      if (parent.left != null && parent.left == this) {
        successor = parent;
      }

      if (node == this) {
        if (node.right != null) {
          return node.right.minimum();
        } else {
          return successor;
        }
      }

      if (node.value < this.value) {
        return left.get_successor(node, this, successor);
      } else {
        return right.get_successor(node, this, successor);
      }
    }

    public Node successor(Node node) {
      return get_successor(node, this, node);
    }

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

    private boolean get_is_bst(int minimum, boolean result) {
      if (this.left != null) { result = this.left.get_is_bst(minimum, result); }
      if (minimum >= this.value) {
        result = false;
      }
      minimum = this.value;
      if (this.right != null) { result = this.right.get_is_bst(minimum, result); }
      return result;
    }

    public boolean is_bst() {
      return get_is_bst(-10000, true);
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
