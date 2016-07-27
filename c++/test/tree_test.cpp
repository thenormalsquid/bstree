#include <string>
#include <vector>
#include <memory>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <tree.h>
#include <node.h>


using std::string;

class TreeTest : public CppUnit::TestCase {

/*
Node root(25);
Tree test_tree(&root);
Node node2(43);
Node node3(8);
Node node4(10);
Node node5(15);
Node node6(33);
Node node7(97);
Node node8(4);
test_tree.add(&node2);
test_tree.add(&node3);
test_tree.add(&node4);
test_tree.add(&node5);
test_tree.add(&node6);
test_tree.add(&node7);
test_tree.add(&node8);
*/

public:
  TreeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_instantiation() {
    Spec spec;
    spec.it("Testing Tree instantiaton", DO_SPEC {
      Node root(1);
      Tree tree(&root);
      return (tree.root->value == root.value);
    });
  }

  void test_find_right_node() {
    Spec spec;
    spec.it("Testing Tree.find for right node", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      tree.add(&node2);
      tree.add(&node3);

      Node * n = tree.find(43);
      return (n->value == node2.value);
    });
  }

  void test_find_left_node() {
    Spec spec;
    spec.it("Testing Tree.find for left node", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      tree.add(&node2);
      tree.add(&node3);

      Node * n = tree.find(8);
      return (n->value == node3.value);
    });
  }

  void test_find_root_node() {
    Spec spec;
    spec.it("Testing Tree.find for root node", DO_SPEC {
      Node node(25);
      Tree tree(&node);
      Node node2(43);
      Node node3(8);
      tree.add(&node2);
      tree.add(&node3);

      Node * n = tree.find(25);
      return (n->value == node.value);
    });
  }

  //TODO: add test for NULL node indicating key not found.

  void test_find() {
    Spec spec;
    spec.it("Testing Tree.find with 8 nodes", DO_SPEC {
      Node node(25);
      Tree tree(&node);
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

      Node * n = tree.find(43);
      return (n->value == node2.value);
    });
  }

  void test_is_present() {
    Spec spec;
    spec.it("Testing Tree.is_present with 8 nodes", DO_SPEC {
      Node node(25);
      Tree tree(&node);
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

      bool result = tree.is_present(43);
      return (result == true);
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

  void test_maximum() {
    Spec spec;
    spec.it("Testing Node.maximum", DO_SPEC {
      Node root(3);
      Tree tree(&root);
      Node node2(1);
      Node node3(2);
      Node node17(17);
      tree.add(&node2);
      tree.add(&node3);
      tree.add(&node17);
      return (tree.maximum() == &node17);
    });
  }

  void test_minimum() {
    Spec spec;
    spec.it("Testing Node.minimum", DO_SPEC {
      Node root(3);
      Tree tree(&root);
      Node node2(1);
      Node node3(2);
      tree.add(&node2);
      tree.add(&node3);
      return (tree.minimum() == &node2);
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
    test_maximum();
    test_minimum();
    test_find_root_node();
    test_find_right_node();
    test_find_left_node();
    test_find();
    test_is_present();
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
