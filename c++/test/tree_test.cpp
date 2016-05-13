#include <string>
#include <vector>
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
  }

  void test_collect() {
    Spec spec;
    spec.it("Testing Tree.collect", DO_SPEC {
      Node node(1);
      Tree tree(&node);
      std::vector<int> a1{1};
      std::vector<int> a2{1};
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
      tree.add(&node6);
      return (a1 == a2);
    });
  }

  void test_add() {
    Spec spec;
    spec.it("Testing Tree.add", DO_SPEC {
      Node node(20);
      Tree tree(&node);
      //tree.add(&node);
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
      tree.add(&node6);
      return (tree.root->right->left == &node6);
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
