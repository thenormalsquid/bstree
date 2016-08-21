var tree = require('../lib/tree.js').Tree;
var node = require('../lib/node.js').Node;
var assert = require('assert');

describe('Tree', function() {
  describe('instantiation', function() {
    it('creates a Tree', function() {
      var t = new tree();
      assert.equal(t.root, null);
    });
  });

  describe('insertion', function() {
    it('insert root node into empty tree', function() {
      var t = new tree();
      var root = new node(13);
      t.insert(root);
      assert.equal(t.root, root);
    });

    it('insert left and right nodes', function() {
      var t = new tree();
      var root = new node(13);
      t.insert(root);
      var n5 = new node(5);
      var n19 = new node(19);
      t.insert(n5);
      t.insert(n19);
      assert.equal(t.root.left, n5);
      assert.equal(t.root.right, n19);
    });
  });

  describe('collect', function() {
    it('collect empty array from empty tree', function() {
      var t = new tree();
      var expected = [];
      var actual = [];
      t.collect(actual);
      assert.deepEqual(expected, actual);
    });

    it('collects key for root node in single node tree', function() {
      var t = new tree();
      var root = new node(13);
      t.insert(root);
      var expected = [13];
      var actual = [];
      t.collect(actual);
      assert.deepEqual(expected, actual);
    });

    it('collects values from a simple 3 node tree', function() {
      var t = new tree();
      var root = new node(13);
      var n5 = new node(5);
      var n17 = new node(17);
      t.insert(root);
      t.insert(n5);
      t.insert(n17);
      var expected = [5, 13, 17];
      var actual = [];
      t.collect(actual);
      assert.deepEqual(expected, actual);
    });
  });

  describe('is_empty', function() {
    it('insert root node into empty tree', function() {
      var t = new tree();
      assert.equal(t.is_empty(), true);
    });

    it('insert root node into empty tree', function() {
      var t = new tree();
      var root = new node(13);
      t.insert(root);
      assert.equal(t.is_empty(), false);
    });
  });

  describe('size', function() {
    xit('size 0 for empty tree', function() {
      var t = tree.new();
      assert.equal(t.size, 0);
    });

    xit('size 1 for tree with only root node', function() {
      var t = tree.new();
      var root = node.new(13);
      t.insert(root);
      assert.equal(t.size, 1);
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
