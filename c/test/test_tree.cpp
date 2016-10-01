#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <tree.h>
#include <collector.h>
#include "../src/tree_private.h"
#include "../src/node_private.h"


using std::string;

class TreeTest : public CppUnit::TestCase {

public:
  TreeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_tree_collect(void) {
    describe_test(INDENT0, "From test_tree_collect in TreeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);
    Collector * expected = collector_new(100);
    Collector * actual = collector_new(100);

    spec.it("array with single element for single node", DO_SPEC_HANDLE {
      collector_add(expected, 13);
      tree_collect(t, (void *) actual);
      return (collector_equals(expected, actual));
    });

    tree_delete(t);
    collector_destroy(expected);
    collector_destroy(actual);
  }

  void test_tree_search(void) {
    describe_test(INDENT0, "From test_tree_search in NodeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);

    spec.it("root element finds itself", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, 13);
      return actual == root;
    });
    spec.it("root element is present", DO_SPEC_HANDLE {
      return tree_is_present(t, 13) == 1;
    });

    Node * n17 = node_new(17);
    tree_insert(t, n17);
    spec.it("finds a right leaf", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, 17);
      return actual == n17;
    });
    spec.it("right leaf is present", DO_SPEC_HANDLE {
      return tree_is_present(t, 17) == 1;
    });

    Node * n3 = node_new(3);
    tree_insert(t, n3);
    spec.it("finds a left leaf", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, 3);
      return actual == n3;
    });
    spec.it("left leaf is present", DO_SPEC_HANDLE {
      return tree_is_present(t, 3) == 1;
    });


    Node * n2 = node_new(2);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    tree_insert(t, n23);
    tree_insert(t, n19);
    tree_insert(t, n5);
    tree_insert(t, n7);
    tree_insert(t, n11);
    tree_insert(t, n2);

    spec.it("finds node at end", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, 23);
      return actual == n23;
    });
    spec.it("finds node at end", DO_SPEC_HANDLE {
      return tree_is_present(t, 23) == 1;
    });


    spec.it("doesn't find value which isn't in tree", DO_SPEC_HANDLE {
      Node * actual = tree_search(t, -100);
      return actual == NULL;
    });
    spec.it("will not find node which isn't in tree", DO_SPEC_HANDLE {
      return tree_is_present(t, 123) == 0;
    });


    tree_delete(t);
  }

  void test_tree_is_present(void) {
  }

  void test_tree_height(void) {
    describe_test(INDENT0, "From test_tree_height in TreeTest");
    Spec spec;
    Tree * tree = tree_new();

    spec.it("empty tree has height 0", [&]() {
        return tree_height(tree) == 0;
    });

    Node * root = node_new(13);
    tree_insert(tree, root);
    spec.it("tree with only root node has height 0", [&]() {
        return tree_height(tree) == 0;
    });

    tree_delete(tree);
  }

  void test_tree_destroy(void) {
  }

  void test_tree_maximum(void) {
    describe_test(INDENT0, "From test_tree_max_and_min in TreeTest");
    Spec spec;
    Tree * tree = tree_new();
    Node * root = node_new(13);
    tree_insert(tree, root);


    spec.it("maximum for root node only", DO_SPEC_HANDLE {
      return (tree_maximum(tree) == root);
    });

    spec.it("minimum for root node only", DO_SPEC_HANDLE {
      return (tree_minimum(tree) == root);
    });

    Node * n2 = node_new(2);
    Node * n3 = node_new(3);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n17 = node_new(17);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    Node * n29 = node_new(29);

    tree_insert(tree, n5);
    tree_insert(tree, n7);
    tree_insert(tree, n11);
    tree_insert(tree, n3);
    tree_insert(tree, n2);

    tree_insert(tree, n19);
    tree_insert(tree, n17);
    tree_insert(tree, n29);
    tree_insert(tree, n23);

    spec.it("maximum for tree with first 10 primes", DO_SPEC_HANDLE {
      return (tree_maximum(tree) == n29);
    });

    spec.it("minimum for tree with first 10 primes", DO_SPEC_HANDLE {
      return (tree_minimum(tree) == n2);
    });

    // TODO: consider testing a few other nodes, just for fun.

    tree_delete(tree);
  }

  void test_tree_successor(void) {
    describe_test(INDENT0, "From test_tree_successor in TreeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);

    spec.it("root of tree with single node is own successor", DO_SPEC_HANDLE {
        return tree_successor(t, root) == root;
    });
  }

  void test_tree_predecessor(void) {
    describe_test(INDENT0, "From test_tree_predecessor in TreeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);

    spec.it("root of tree with single node is own predecessor", DO_SPEC_HANDLE {
        return tree_predecessor(t, root) == root;
    });
  }

  void test_tree_is_full(void) {
  }

  void test_tree_is_bst(void) {
    describe_test(INDENT0, "From test_tree_is_bst in TreeTest.");
    Spec spec;
    Tree * t = tree_new();
    Node * root = node_new(17);
    tree_insert(t, root);

    spec.it("tree with single node is bst", DO_SPEC_HANDLE {
        return tree_is_bst(t) == 1;
    });
  }

  void test_tree_size(void) {
    describe_test(INDENT0, "From test_tree_size in TreeTest.");
    Spec spec;
    Tree * t = tree_new();

    spec.it("size for root node only", DO_SPEC_HANDLE {
      return (tree_size(t) == 0);
    });

    Node * root = node_new(13);
    tree_insert(t, root);

    spec.it("size for tree with root node only", DO_SPEC_HANDLE {
      return (tree_size(t) == 1);
    });

    Node * n2 = node_new(2);
    Node * n3 = node_new(3);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);
    Node * n11 = node_new(11);
    Node * n17 = node_new(17);
    Node * n19 = node_new(19);
    Node * n23 = node_new(23);
    Node * n29 = node_new(29);

    node_insert(root, n5);
    node_insert(root, n7);
    node_insert(root, n11);
    node_insert(root, n3);
    node_insert(root, n2);

    node_insert(root, n19);
    node_insert(root, n17);
    node_insert(root, n29);
    node_insert(root, n23);

    spec.it("size for tree with 9 children", DO_SPEC_HANDLE {
      return (tree_size(t) == 10);
    });

    tree_delete(t);
  }

  void test_tree_insert(void) {
    describe_test(INDENT0, "From test_tree_insert in TreeTest.");
    Tree * t = tree_new();
    Node * root = node_new(13);
    tree_insert(t, root);

    Spec spec;
    spec.it("sets the root node in an empty tree", DO_SPEC_HANDLE {
      return (t->root = root);
    });

    Node * n7 = node_new(7);
    spec.it("insert a single node to the left", DO_SPEC_HANDLE {
      tree_insert(t, n7);
      return (t->root->left == n7);
    });

    Node * n21 = node_new(21);
    spec.it("insert a single node to the right", DO_SPEC_HANDLE {
      tree_insert(t, n21);
      return (t->root->right == n21);
    });

    Node * n17 = node_new(17);
    spec.it("insert a left node into right subtree", DO_SPEC_HANDLE {
      tree_insert(t, n17);
      return (t->root->right->left == n17);
    });

    Node * n11 = node_new(11);
    spec.it("insert a right node into left subtree", DO_SPEC_HANDLE {
      tree_insert(t, n11);
      return (t->root->left->right == n11);
    });

    tree_delete(t);
  }

  void test_tree_is_empty(void) {
    describe_test(INDENT0, "From test_tree_is_empty in TreeTest.");
    Tree * t = tree_new();

    Spec spec;
    spec.it("tree is empty without root node", DO_SPEC_HANDLE {
      return (tree_is_empty(t) == TRUE);
    });

    tree_delete(t);
  }

  void test_tree_new_and_delete(void) {
    describe_test(INDENT0, "From test_tree_new_and_delete in TreeTest.");
    Tree * t = tree_new();

    Spec spec;
    spec.it("instantiates a tree object", DO_SPEC_HANDLE {
      return (t != NULL);
    });

    tree_delete(t);
  }

  void run_tests(void) {
    test_tree_new_and_delete();
    test_tree_insert();
    test_tree_is_empty();
    test_tree_collect();
    test_tree_search();
    //test_tree_is_present();
    test_tree_height();
    //test_tree_destroy();
    test_tree_maximum();
    test_tree_successor();
    test_tree_predecessor();
    //test_tree_is_full();
    test_tree_is_bst();
    test_tree_size();
  }
};


void
test_tree() {

  TreeTest * tt = new TreeTest(std::string("initial test"));
  tt->run_tests();
  delete tt;
}


int
main(int argc, char ** argv) {

  test_tree();
  return 0;
}
