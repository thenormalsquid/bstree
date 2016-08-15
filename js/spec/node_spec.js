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
      var root = node.new(13);
      var n5 = node.new(5);
      root.insert(n5);
      assert.equal(root.left, n5);
    });

    xit('inserts a right nodes', function() {
      var root = node.new(13);
      var n19 = node.new(19);
      root.insert(n19);
      assert.equal(root.right, n19);
    });

    xit('insert first 10 primes', function() {
      var root = node.new(13);
      var n7 = node.new(7);
      var n5 = node.new(5);
      var n3 = node.new(3);
      var n2 = node.new(2);
      var n11 = node.new(11);
      var n17 = node.new(17);
      var n19 = node.new(19);
      var n23 = node.new(23);
      var n29 = node.new(29);
      root.insert(n5);
      root.insert(n19);
      //root.insert(n19).insert(17).insert(n23).insert(n11).insert(n7).insert(n3).insert(n2).insert(n29);
      assert.equal(root, tree);
    });
  });

  describe('is_leaf', function() {
    xit('leaf node has no children', function() {
      var root = node.new(13);
      assert.equal(t.is_leaf, true);
    });

    xit('insert child node onto leaf', function() {
      var root = node.new(13);
      var n11 = node.new(11);
      root.insert(n11);
      assert.equal(t.is_leaf, false);
    });
  });

  describe('size', function() {
    xit('size 0 for empty tree', function() {
      var root = node.new(13);
      assert.equal(t.size, 1);
    });

    xit('size 2 for node with 1 child', function() {
      var root = node.new(13);
      var n5 = node.new(n5);
      root.insert(root);
      assert.equal(root.size, 2);
    });

    xit('size 10 for first 10 primes', function() {
      var t = tree.new();
      var root = node.new(13);
      t.insert(root);
      var n7 = node.new(7);
      var n5 = node.new(5);
      var n3 = node.new(3);
      var n2 = node.new(2);
      var n11 = node.new(11);
      var n17 = node.new(17);
      var n19 = node.new(19);
      var n23 = node.new(23);
      var n29 = node.new(29);
      t.insert(n5);
      t.insert(n19);
      //t.insert(n19).insert(17).insert(n23).insert(n11).insert(n7).insert(n3).insert(n2).insert(n29);
      assert.equal(t.size, 10);
    });
  });
});
