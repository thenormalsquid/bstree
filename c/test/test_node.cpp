#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <node.h>


using std::string;

class NodeTest : public CppUnit::TestCase {

public:
  NodeTest( std::string name ) : CppUnit::TestCase( name ) {}

  void test_node_insert() {
  }

  void test_node_new_and_delete() {
    Node * n = node_new(13);

    Spec spec;
    spec.it("Testing node_new", DO_SPEC_HANDLE {
      return (node_get_key(n) == 13);
    });

    node_delete(n);
  }

  void run_tests(void) {
    test_node_new_and_delete();
    test_node_insert();
  }
};

void
test_node() {

  NodeTest * nt = new NodeTest(std::string("initial test"));
  nt->run_tests();
  delete nt;
}


int
main(int argc, char ** argv) {

  test_node();
  return 0;
}
