var node = require('../lib/node.js').Node;
var assert = require('assert');

describe('Node', function() {
  describe('instantiation', function() {
    it('creates a Node', function() {
      var root = node.new(13);
      //console.log(root);
      assert.equal(13, root.key);
    });
  });

  describe('insertion', function() {
    xit('inserts a left node', function() {
    });

    xit('inserts a right node', function() {
    });
  });
});
