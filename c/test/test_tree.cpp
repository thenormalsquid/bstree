#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <tree.h>


using std::string;

class TreeTest : public CppUnit::TestCase {

public:
  TreeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_tree_insert() {
  }

  void test_tree_new_and_delete() {
    Tree * t = tree_new();

    Spec spec;
    spec.it("Testing tree", DO_SPEC_HANDLE {
      return (t != NULL);
    });

    tree_delete(t);
  }

  void runTest() {
    test_tree_new_and_delete();
    test_tree_insert();
  }
};


void
test_tree() {

  TreeTest * tt = new TreeTest(std::string("initial test"));
  tt->runTest();
  delete tt;
}


int
main(int argc, char ** argv) {

  test_tree();
  return 0;
}
