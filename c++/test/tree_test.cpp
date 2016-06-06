#include <string>
#include <vector>
#include <memory>
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
      Node node(1);
      Tree tree(&node);
      return (tree.root->value == node.value);
    });
  }

  void test_find() {
    Spec spec;
    spec.it("Testing Tree.find", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      std::vector<int> a1{4, 8, 10, 15, 25, 33, 43, 97};
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      Node node8(4);
      tree.add(&node2);
      tree.add(&node3);
      tree.add(&node4);
      tree.add(&node5);
      tree.add(&node6);
      tree.add(&node7);
      tree.add(&node8);

      Node * n5 = tree.find(15);
      std::cout << "n5.value: " << n5->value << std::endl;
      std::cout << "After find()..." << std::endl;
      return (n5->value == node5.value);
    });
  }

  void test_collect() {
    Spec spec;
    spec.it("Testing Tree.collect", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      std::vector<int> a1{4, 8, 10, 15, 25, 33, 43, 97};
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      Node node8(4);
      tree.add(&node2);
      tree.add(&node3);
      tree.add(&node4);
      tree.add(&node5);
      tree.add(&node6);
      tree.add(&node7);
      tree.add(&node8);
      std::vector<int> a2 = tree.collect();
      return (a1 == a2);
    });
  }

  void test_add() {
    Spec spec;
    spec.it("Testing Tree.add", DO_SPEC {
      Node node(20);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      tree.add(&node2);
      tree.add(&node3);
      tree.add(&node4);
      tree.add(&node5);
      tree.add(&node6);
      tree.add(&node7);
      return (tree.root->right->left == &node6);
    });
  }

  // my own edification b/c I reach for new and delete
  void test_unique_ptr(void) {
    Spec spec;
    spec.it("Testing Tree.add", DO_SPEC {
      // std::unique_ptr<Node> node(new Node(20));
      Node node(20);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      Node node4(10);
      Node node5(15);
      Node node6(33);
      Node node7(97);
      tree.add(&node2);
      tree.add(&node3);
      tree.add(&node4);
      tree.add(&node5);
      tree.add(&node6);
      tree.add(&node7);
      return (tree.root->right->left == &node6);
    });
  }

  void runTest() {
    test_instantiation();
    test_add();
    test_find();
    test_collect();
    // test_unique_ptr();
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
