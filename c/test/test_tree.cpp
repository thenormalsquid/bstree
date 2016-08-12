#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <tree.h>


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
    }

    void test_tree_new_and_delete(void) {
      Tree * t = tree_new();

      Spec spec;
      spec.it("Testing tree", DO_SPEC_HANDLE {
        return (t != NULL);
      });

      tree_delete(t);
    }

    void run_tests(void) {
      test_tree_new_and_delete();
      //test_tree_insert();
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
      test_tree_insert();
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
