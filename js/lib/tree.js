var Tree = function () {
  this.root = null;
};

Tree.prototype.log = function (msg) {
  console.log(msg);
};

Tree.prototype.insert = function (n) {
  this.root === null ? this.root = n : this.root.insert(n);
}

Tree.prototype.is_empty = function () {
  return this.root === null;
};

Tree.prototype.collect = function(collector) {
  if (this.root === null) { return; }
  this.root.collect(collector);
};

Tree.prototype.list_keys = function() {
  if (this.root === null) return [];
  return this.root.list_keys();
}

Tree.prototype.search = function(key) {
  if (this.root === null) { return false; }
  return this.root.search(key);
}

Tree.prototype.transplant = function(u, v) {
  if (u === this.root) {
    this.root = v;
  } else if (u.parent.left === u) {
    u.parent.left = v;
  } else {
    u.parent.right = v;
  }

  if (v !== null) {
    v.parent = u.parent;
  }
}

Tree.prototype.delete_node = function(key) {
  z = this.search(key);
  // TODO: catch key not found

  if (z.left === null) {
    this.transplant(z, z.right);
  } else if (z.right === null) {
    this.transplant(z, z.left);
  } else {
    y = z.right.minimum();
    if (z.right.parent != y) {
      this.transplant(y, y.right);
      y.right = z.right;
      y.right.parent = y;
    }
    this.transplant(z, y);
    y.left = z.left;
    y.left.parent = y;
  }

  z.unlink();
  return z;
}

Tree.prototype.is_present = function(key) {
  if (this.root === null) { return false; }
  return this.root.is_present(key);
}

Tree.prototype.maximum = function() {
  if (this.root === null) { return null; }
  return this.root.maximum();
}

Tree.prototype.minimum = function() {
  if (this.root === null) { return null; }
  return this.root.minimum();
}

Tree.prototype.successor = function(node) {
  if (this.root === null) { return null; }
  return this.root.successor(node);
}

Tree.prototype.predecessor = function(node) {
  if (this.root === null) { return null; }
  return this.root.predecessor(node);
}

Tree.prototype.is_bst = function() {
  if (this.root === null) { return true; }
  return this.root.is_bst();
}

Tree.prototype.is_empty = function() {
  return (this.root === null);
}

Tree.prototype.height = function() {
  if (this.root === null) { return 0; }
  return this.root.height();
}

Tree.prototype.size = function() {
  if (this.root === null) { return 0; }
  return this.root.size();
}

exports.Tree = Tree;
