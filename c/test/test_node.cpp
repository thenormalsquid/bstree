#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <node.h>


using std::string;

class InitialTest : public CppUnit::TestCase {

public:
  InitialTest( std::string name ) : CppUnit::TestCase( name ) {}


  void test_node_new() {
    int foo = 1;

    Spec spec;
    spec.it("Testing node_new", DO_SPEC {
      foo = 2;
      Node * n = node_new(13);
      return (node_get_key(n) == 13);
    });
  }

  void runTest() {
    test_node_new();
  }
};

void
test_initial() {

  InitialTest * it = new InitialTest(std::string("initial test"));
  it->runTest();
  delete it;
}


int
main(int argc, char ** argv) {

  test_initial();
  return 0;
}
