#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <tree.h>
#include "../src/tree_private.h"


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
      //test_tree_size();
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
