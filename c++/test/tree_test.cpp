#include <string>
#include <cppunit/TestCase.h>

#include "./testutils.h"
#include <tree.h>


using std::string;


class TreeTest : public CppUnit::TestCase {

public:
  TreeTest( std::string name ) : CppUnit::TestCase( name ) {}


  void test_getsome() {

    Spec spec;
    spec.it("Testing Tree", DO_SPEC {
      return (string("tree") == get_tree());
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
