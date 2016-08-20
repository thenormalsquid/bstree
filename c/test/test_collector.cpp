#include <string>

#include <cppunit/TestCase.h>
#include "./testutils.h"

#include <collector.h>

using std::string;

void
setup(void) {
}

void
teardown(void) {
}


class CollectorTest : public CppUnit::TestCase {

public:
  CollectorTest( std::string name ) : CppUnit::TestCase( name ) {}

  void run_tests(void) {
    setup();
    teardown();
  }
};

void
test_collector() {

  CollectorTest * ct = new CollectorTest(std::string("initial test"));
  ct->run_tests();
  delete ct;
}

int
main(int argc, char ** argv) {

  test_collector();
  return 0;
}
