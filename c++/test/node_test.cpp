#include <string>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <node.h>


using std::string;

class NodeTest : public CppUnit::TestCase {

public:
  NodeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_instantiation() {
    describe_test(INDENT0, "From test_instantiation in NodeTest.");
    Spec spec;
    // spec.it("Testing Node instantiation", DO_SPEC_HANDLE {
    spec.it("Testing Node instantiation", [&]()->bool {
      int value = 1;
      Node node(value);
      return (node.value == value);
    });
  }

  void test_left_initialize() {
    describe_test(INDENT0, "From test_instantiation in NodeTest.");
    Spec spec;
    spec.it("Testing left node initialize to NULL", DO_SPEC {
      Node node(1);
      return (node.left == NULL);
    });
  }

  void test_right_initialize() {
    describe_test(INDENT0, "From test_instantiation in NodeTest.");
    Spec spec;
    spec.it("Testing right node initialize to NULL", DO_SPEC {
      Node node(1);
      return (node.right == NULL);
    });
  }

  void test_add() {
    describe_test(INDENT0, "From test_add in NodeTest.");
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
    describe_test(INDENT0, "From test_is_present in NodeTest.");
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

  void test_size() {
    describe_test(INDENT0, "From test_size in NodeTest.");
    Spec spec;
    Node root(11);

    spec.it("node size of root node only", [&]() {
      return (root.size() == 1);
    });

    Node n17(17);
    Node n3(3);
    root.add(&n3);
    root.add(&n17);
    spec.it("node with left and right child", [&]() {
        return (root.size() == 3);
    });

    Node n2(2);
    Node n5(5);
    Node n7(7);
    Node n13(13);
    Node n19(19);
    Node n23(23);
    Node n29(29);
    root.add(&n2);
    root.add(&n5);
    root.add(&n7);
    root.add(&n13);
    root.add(&n19);
    root.add(&n23);
    root.add(&n29);

    spec.it("size of tree with first 10 primes is 10", [&]() {
        return (root.size() == 10);
    });

    spec.it("size of subtree at max node is 1", [&]() {
        return (n29.size() == 1);
    });

    spec.it("size of subtree at minimum node is 1", [&]() {
        return (n2.size() == 1);
    });

    spec.it("size of subtree at node with key 5 node is 2", [&]() {
        return (n5.size() == 2);
    });
  }

  void test_maximum() {
    describe_test(INDENT0, "From test_maximum in NodeTest.");
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
    describe_test(INDENT0, "From test_minimum in NodeTest.");
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
    test_size();
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
