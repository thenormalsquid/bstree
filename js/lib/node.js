var Node = function (k) {
  this.key = k;
  this.left = null;
  this.right = null;
};

Node.prototype.log = function (msg) {
  console.log(msg);
};

//Node.prototype.init = function(k) {
//};

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

/* TODO: define an in-order traversal function which
 * takes a closure.
 */
Node.prototype.collect = function(collector) {
  if (this.left !== null) { this.left.collect(collector); }
  collector.push(this.key);
  if (this.right !== null) { this.right.collect(collector); }
};

// exports.Node = new Node();
exports.Node = Node;
