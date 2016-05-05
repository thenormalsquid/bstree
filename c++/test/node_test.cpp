#include <string>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <node.h>


using std::string;

class NodeTest : public CppUnit::TestCase {

public:
  NodeTest( std::string name ) : CppUnit::TestCase( name ) {}


  void test_getsome() {

    Spec spec;
    spec.it("Testing Node", DO_SPEC {
      return (string("node") == get_node());
    });
  }

  void runTest() {
    test_getsome();
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
