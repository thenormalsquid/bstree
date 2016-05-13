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

  void test_find() {
  }

  void test_collect() {
  }

  void test_add() {
    Spec spec;
    spec.it("Testing Tree.add", DO_SPEC {
      Tree tree;
      Node node(10);
      tree.add(&node);
      Node node2(43);
      Node node3(10);
      Node node4(10);
      Node node5(10);
      Node node6(10);
      Node node7(10);
      tree.add(&node2);
      tree.add(&node3);
      tree.add(&node4);
      tree.add(&node5);
      tree.add(&node6);
      tree.add(&node6);
      return (tree.root->right == &node2);
    });
  }

  void runTest() {
    test_instantiation();
    test_add();
    test_find();
    test_collect();
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
