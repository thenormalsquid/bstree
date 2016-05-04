#include <string>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <autotoolerpp.h>


using std::string;

class Tree {
public:
  Tree(void) : value(1) {}
  int value;
};



class TreeTest : public CppUnit::TestCase {

public:
  TreeTest( std::string name ) : CppUnit::TestCase( name ) {}


  void test_getsome() {

    Spec spec;
    spec.it("Testing Tree", DO_SPEC {
      return (string("some") == get_some());
    });
  }

  void runTest() {
    test_getsome();
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
