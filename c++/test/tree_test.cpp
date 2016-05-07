#include <string>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <tree.h>
#include <node.h>


using std::string;


class TreeTest : public CppUnit::TestCase {

public:
  TreeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_instantiation() {
    Spec spec;
    spec.it("Testing Tree instantiaton", DO_SPEC {
      Tree tree;
      return (&tree != NULL);
    });
  }

  void test_add() {
    Spec spec;
    spec.it("Testing Tree.add", DO_SPEC {
      Tree tree;
      Node node(10);
      tree.add(&node);
      return (tree.root == &node);
    });
  }

  void runTest() {
    test_instantiation();
    test_add();
  }
};

void
test_node() {

  TreeTest * nt = new TreeTest(std::string("initial test"));
  nt->runTest();
  delete nt;
}


int
main(int argc, char ** argv) {

  test_node();
  return 0;
}
