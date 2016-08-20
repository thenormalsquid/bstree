#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <node.h>
#include <collector.h>
#include "../src/node_private.h"

using std::string;

void
setup(void) {
}

void
teardown(void) {
}


class NodeTest : public CppUnit::TestCase {

public:
  NodeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_node_left(void) {
    describe_test(INDENT0, "From test_node_left in NodeTest.");
    Spec spec;
    Node * root = node_new(13);
    Node * n11 = node_new(11);

    spec.it("insert a single node to the left", DO_SPEC_HANDLE {
      node_insert(root, n11);
      return (node_left(root) == n11);
    });

    node_destroy(root);
  }

  void test_node_right(void) {
    describe_test(INDENT0, "From test_node_right in NodeTest.");
    Spec spec;
    Node * root = node_new(13);
    Node * n17 = node_new(17);

    spec.it("insert a single node to the right", DO_SPEC_HANDLE {
      node_insert(root, n17);
      return (node_right(root) == n17);
    });

    node_destroy(root);
  }

  void test_node_key(void) {
    describe_test(INDENT0, "From test_node_key in NodeTest.");
    Spec spec;
    int key = 17;

    Node * root = node_new(key);

    spec.it("insert a single node to the right", DO_SPEC_HANDLE {
      return (node_key(root) == key);
    });

    node_destroy(root);
  }

  void test_node_collect(void) {
    describe_test(INDENT0, "From test_node_collect in NodeTest.");
    Spec spec;
    Node * root = node_new(13);
    Node * n17 = node_new(17);

    Node * n2 = node_new(2);
    Node * n3 = node_new(3);
    Node * n5 = node_new(5);
    Node * n7 = node_new(7);

    Collector * expected = collector_new(100);
    expected->current_position = 0;
    collector_add(expected, 1);
    collector_add(expected, 1);
    collector_add(expected, 1);
    collector_add(expected, 1);
    collector_add(expected, 1);

    collector_printf(expected);

    Collector actual;
    actual.current_position = 0;

    spec.it("array with single element for single node", DO_SPEC_HANDLE {
      node_insert(root, n17);
      node_insert(root, n5);
      node_insert(root, n7);
      node_insert(root, n2);
      node_insert(root, n3);
      node_collect(root, (void*)&actual);
      return (1);
    });

    node_destroy(root);
    collector_destroy(expected);
  }

  void test_node_search(void) {
  }

  void test_node_is_present(void) {
  }

  void test_node_height(void) {
  }

  void test_node_destroy(void) {
  }

  void test_node_maximum(void) {
  }

  void test_node_minimum(void) {
  }

  void test_node_is_full(void) {
  }

  void test_node_is_bst(void) {
  }

  void test_node_size(void) {
    describe_test(INDENT0, "From test_node_size in NodeTest.");
    Spec spec;
    Node * root = node_new(13);

    spec.it("size for root node only", DO_SPEC_HANDLE {
      return (node_size(root) == 1);
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

    spec.it("size for root node with 9 children", DO_SPEC_HANDLE {
      return (node_size(root) == 10);
    });

    spec.it("size for leaf node only", DO_SPEC_HANDLE {
      return (node_size(n2) == 1);
    });

    spec.it("size for left subtree", DO_SPEC_HANDLE {
      return (node_size(n5) == 5);
    });

    spec.it("size for right subtree", DO_SPEC_HANDLE {
      return (node_size(n19) == 4);
    });

    node_destroy(root);
  }

  void test_node_insert(void) {
    describe_test(INDENT0, "From test_node_insert in NodeTest.");
    Spec spec;
    Node * root = node_new(13);

    Node * n7 = node_new(7);
    spec.it("insert a single node to the left", DO_SPEC_HANDLE {
      node_insert(root, n7);
      return (root->left == n7);
    });

    Node * n21 = node_new(21);
    spec.it("insert a single node to the right", DO_SPEC_HANDLE {
      node_insert(root, n21);
      return (root->right == n21);
    });

    Node * n17 = node_new(17);
    spec.it("insert a left node into right subtree", DO_SPEC_HANDLE {
      node_insert(root, n17);
      return (root->right->left == n17);
    });

    Node * n11 = node_new(11);
    spec.it("insert a right node into left subtree", DO_SPEC_HANDLE {
      node_insert(root, n11);
      return (root->left->right == n11);
    });

    // node destroy walks the tree, so can only be called on the
    // root node.  If we were using a parent pointer, or passing
    // the parent down the recursion, this could be handled by setting
    // the child pointer in the parent to NULL.
    // node_destroy(n11);
    node_destroy(root);
  }

  void test_node_new_and_destroy(void) {
    describe_test(INDENT0, "From test_node_new_and_destroy in NodeTest.");
    Node * n = node_new(13);

    Spec spec;
    spec.it("Testing node_new", DO_SPEC_HANDLE {
      return (node_key(n) == 13);
    });

    node_destroy(n);
  }

  void run_tests(void) {
    setup();
    test_node_new_and_destroy();
    test_node_insert();
    test_node_left();
    test_node_right();
    test_node_key();
    test_node_collect();
    //test_node_search();
    //test_node_is_present();
    //test_node_height();
    //test_node_destroy();
    //test_node_maximum();
    //test_node_minimum();
    //test_node_is_full();
    //test_node_is_bst();
    test_node_size();
    teardown();
  }
};

void
test_node() {

  NodeTest * nt = new NodeTest(std::string("initial test"));
  nt->run_tests();
  delete nt;
}

int
main(int argc, char ** argv) {

  test_node();
  return 0;
}
