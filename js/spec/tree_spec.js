var tree = require('../lib/tree.js').Tree;
var node = require('../lib/node.js').Node;
var assert = require('assert');

describe('Tree', function() {
  describe('instantiation', function() {
    it('creates a Tree', function() {
      var t = tree.new();
      //console.log(t);
      assert.equal(t.root, null);
    });
  });

  describe('insertion', function() {
    xit('insert a node', function() {
      //assert.equal("Tree!", tree.log());
    });
  });
});
