#include <string>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <autotoolerpp.h>


using std::string;

class Node {
public:
  Node(void) : value(1) {}
  int value;
};



class NodeTest : public CppUnit::TestCase {

public:
  NodeTest( std::string name ) : CppUnit::TestCase( name ) {}


  void test_getsome() {

    Spec spec;
    spec.it("Testing Node", DO_SPEC {
      return (string("some") == get_some());
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
