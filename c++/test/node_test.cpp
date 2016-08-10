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
      int value = 1;
      Node node(value);
      return (node.value == 1);
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
    spec.it("Testing right node initialize to NULL", DO_SPEC {
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

  void test_is_present() {
    Spec spec;
    spec.it("Testing Node.is_present with 8 nodes", DO_SPEC {
      Node root(25);
      Node node43(43);
      Node node8(8);
      Node node10(10);
      Node node15(15);
      Node node33(33);
      Node node97(97);
      Node node4(4);
      root.add(&node43);
      root.add(&node8);
      root.add(&node10);
      root.add(&node15);
      root.add(&node33);
      root.add(&node97);
      root.add(&node4);

      bool result = root.is_present(43);
      // TODO: refactor tree building so that other values
      // can be tested for presence.
      return (result == true);
    });
  }


  void test_maximum() {
    Spec spec;
    spec.it("Testing Node.maximum", DO_SPEC {
      Node root(3);
      Node node2(1);
      Node node3(2);
      Node node17(17);
      root.add(&node2);
      root.add(&node3);
      root.add(&node17);
      return (root.maximum() == &node17);
    });
  }

  void test_minimum() {
    Spec spec;
    spec.it("Testing Node.minimum", DO_SPEC {
      Node root(3);
      Node node2(1);
      Node node3(2);
      root.add(&node2);
      root.add(&node3);
      return (root.minimum() == &node2);
    });
  }

  void runTest() {
    test_instantiation();
    test_left_initialize();
    test_right_initialize();
    test_add();
    test_is_present();
    test_maximum();
    test_minimum();
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
