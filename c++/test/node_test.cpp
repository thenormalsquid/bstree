#include <string>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <node.h>


using std::string;

class NodeTest : public CppUnit::TestCase {

public:
  NodeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_instantiation() {
    Spec spec;
    spec.it("Testing Node instantiation", DO_SPEC {
      Node node(1);
      return (&node != NULL);
    });
  }

  void test_left_initialize() {
    Spec spec;
    spec.it("Testing left node initialize to NULL", DO_SPEC {
      Node node(1);
      return (node.left == NULL);
    });
  }

  void test_right_initialize() {
    Spec spec;
    spec.it("Testing left node initialize to NULL", DO_SPEC {
      Node node(1);
      return (node.right == NULL);
    });
  }

  void test_add() {
    Spec spec;
    spec.it("Testing Node.add", DO_SPEC {
      Node node(3);
      Node node2(1);
      Node node3(2);
      node.add(&node2);
      node.add(&node3);
      return (node.left->right->value == 2);
    });
  }

  void test_getsome() {
    Spec spec;
    spec.it("Testing Node", DO_SPEC {
      return (string("node") == get_node());
    });
  }

  void runTest() {
    test_getsome();
    test_instantiation();
    test_left_initialize();
    test_right_initialize();
    test_add();
  }
};

void
test_node() {

  NodeTest * nt = new NodeTest(std::string("initial test"));
  nt->runTest();
  delete nt;
}


int
main(int argc, char ** argv) {

  test_node();
  return 0;
}
