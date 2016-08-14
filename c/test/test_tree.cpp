#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <tree.h>
#include "../src/tree_private.h"
#include "../src/node_private.h"


using std::string;

class TreeTest : public CppUnit::TestCase {

public:
  TreeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_tree_collect(void) {
  }

  void test_tree_search(void) {
  }

  void test_tree_is_present(void) {
  }

  void test_tree_height(void) {
  }

  void test_tree_destroy(void) {
  }

  void test_tree_maximum(void) {
  }

  void test_tree_minimum(void) {
  }

  void test_tree_is_full(void) {
  }

  void test_tree_is_bst(void) {
  }

  void test_tree_size(void) {
    describe_test(INDENT0, "From test_node_size in NodeTest.");
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
    //test_tree_collect();
    //test_tree_search();
    //test_tree_is_present();
    //test_tree_height();
    //test_tree_destroy();
    //test_tree_maximum();
    //test_tree_minimum();
    //test_tree_is_full();
    //test_tree_is_bst();
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
