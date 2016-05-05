AM_CXXFLAGS = -std=c++11 -Wall -Wextra  -Wno-unused-parameter
AM_CPPFLAGS = -I../include -I. $(shell cppunit-config --cflags)

AM_LDFLAGS = $(shell cppunit-config --libs)
LDADD = ../src/libautotoolerpp.a ../src/libtree.a
# LDADD = ../src/libautotoolerpp.a ../src/libtree.a
LDADD = ../src/libtree.a

%.o: %.cpp
	g++ $(AM_CXXFLAGS) $(AM_CPPFLAGS) -D$*_STANDALONE -c $< $(AM_LDFLAGS)

#bin_PROGRAMS = initial node_test tree_test
bin_PROGRAMS = node_test tree_test

#initial_SOURCES = test_initial.cpp testutils.cpp
node_test_SOURCES = node_test.cpp testutils.cpp
tree_test_SOURCES = tree_test.cpp testutils.cpp
