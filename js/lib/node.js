var Node = function (k) {
  this.key = k;
  this.left = null;
  this.right = null;
};

Node.prototype.log = function (msg) {
  console.log(msg);
};

Node.prototype.init = function(k) {
};

Node.prototype.insert = function(n) {
  if (n.key < this.key) {
    if (this.left === null) {
      this.left = n;
    } else {
      this.left.insert(n);
    }
  } else {
    if (this.right === null) {
      this.right = n;
    } else {
      this.right.insert(n);
    }
  }
};

// exports.Node = new Node();
exports.Node = Node;
