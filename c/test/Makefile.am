AM_CXXFLAGS = -std=c++11 -Wall -Wextra  -Wno-unused-parameter
AM_CPPFLAGS = -I../include -I.

AM_LDFLAGS = $(shell cppunit-config --libs)
LDADD = ../src/libbst.a

%.o: %.cpp
	g++ $(AM_CXXFLAGS) $(AM_CPPFLAGS) -D$*_STANDALONE -c $< $(AM_LDFLAGS)

bin_PROGRAMS = node tree

node_SOURCES = test_node.cpp testutils.cpp
tree_SOURCES = test_tree.cpp testutils.cpp


