#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <node.h>
#include "../src/node_private.h"


using std::string;

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

      // node_destroy(n11);
      node_destroy(root);
    }

    void test_node_right(void) {
    }

    void test_node_collect(void) {
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
    }

    void test_node_insert(void) {
      describe_test(INDENT0, "From test_node_insert in NodeTest.");
      Spec spec;
      Node * root = node_new(13);

      Node * n11 = node_new(11);
      spec.it("insert a single node to the left", DO_SPEC_HANDLE {
        node_insert(root, n11);
        return (root->left == n11);
      });

      Node * n21 = node_new(21);
      spec.it("insert a single node to the right", DO_SPEC_HANDLE {
        node_insert(root, n21);
        return (root->right == n21);
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
      test_node_new_and_destroy();
      test_node_insert();
      test_node_left();
      //test_node_right();
      //test_node_key();
      //test_node_collect();
      //test_node_search();
      //test_node_is_present();
      //test_node_height();
      //test_node_destroy();
      //test_node_maximum();
      //test_node_minimum();
      //test_node_is_full();
      //test_node_is_bst();
      //test_node_size();
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
