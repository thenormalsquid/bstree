package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;

class Node {
    public int key;
    public Node left = null;
    public Node right = null;
    public Node parent = null;

    private Node get_predecessor(Node node, Node parent, Node predecessor) {
      if (parent.right == this) { predecessor = parent; }

      if (node == this) {
        if (left != null) {
          return left.maximum();
        } else {
          return predecessor;
        }
      }

      if (node.key < this.key) {
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

      if (node.key < this.key) {
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
      if (minimum >= this.key) {
        result = false;
      }
      minimum = this.key;
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
      if (this.key == key) { return this; }

      if (key < this.key) {
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
      if (this.key == key) { return true; }

      if (key < this.key) {
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
        if (node.key < this.key) {
            if (left == null) {
              node.parent = this;
              left = node;
            } else {
              left.insert(node);
            }
        } else {
            if (right == null) {
              node.parent = this;
              right = node;
            } else {
              right.insert(node);
            }
        }
    }

    // TODO: rewrite this to use an in_order_traverse
    public void collect(ArrayList<Integer> collector) {
      if (this.left != null) { this.left.collect(collector); }
      collector.add(this.key);
      if (this.right != null) { this.right.collect(collector); }
    }

    public ArrayList<Integer> list_keys() {
      ArrayList<Integer> collector = new ArrayList<Integer>();
      collect(collector);
      return collector;
    }

    public Node(int k) {
        key = k;
    }

    public static void main(String [] args) {
        System.out.println("From Node main...");
    };
};
