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

exports.Tree = Tree;
