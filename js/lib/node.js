var Node = function (k) {
  this.key = k;
  this.left = null;
  this.right = null;
  this.parent = null;
};

Node.prototype.log = function (msg) {
  console.log(msg);
};

//Node.prototype.init = function(k) {
//};

Node.prototype.insert = function(n) {
  if (n.key < this.key) {
    if (this.left === null) {
      n.parent = this;
      this.left = n;
    } else {
      this.left.insert(n);
    }
  } else {
    if (this.right === null) {
      n.parent = this;
      this.right = n;
    } else {
      this.right.insert(n);
    }
  }
};

Node.prototype.maximum = function() {
  if (this.right !== null) { return this.right.maximum(); }
  return this;
}

Node.prototype.minimum = function() {
  if (this.left !== null) { return this.left.minimum(); }
  return this;
}

Node.prototype.search = function(key) {
  if (key === this.key) { return this; }

  if (key < this.key) {
    if (this.left !== null) { return this.left.search(key); }
  } else {
    if (this.right !== null) { return this.right.search(key); }
  }
}

Node.prototype.is_present = function(key) {
  if (key === this.key) { return true; }

  if (key < this.key) {
    if (this.left !== null) { return this.left.is_present(key); }
  } else {
    if (this.right !== null) { return this.right.is_present(key); }
  }
  return false;
}

/* TODO: define an in-order traversal function which
 * takes a closure.
 */
Node.prototype.collect = function(collector) {
  if (this.left !== null) { this.left.collect(collector); }
  collector.push(this.key);
  if (this.right !== null) { this.right.collect(collector); }
};

Node.prototype.post_order_traverse = function(callback) {
  if (this.left !== null) {  this.left.post_order_traverse(callback); }
  if (this.right !== null) {this.right.post_order_traverse(callback); }
  callback();
}

Node.prototype.size = function() {
  var size = 0;
  this.post_order_traverse(function() {
    size++;
  });
  return size;
}

Node.prototype.successor = function(node) {
  var get_successor = function(self, node, parent, successor) {
    if (parent.left !== null && parent.left === self) successor = parent;

    if (node === self) {
      if (self.right !== null) {
        return self.right.minimum();
      } else {
        return successor;
      }
    }

    if (node.key < self.key) {
      if (self.left !== null) {
        return get_successor(self.left, node, self, successor);
      }
    } else {
      if (self.right !== null) {
        return get_successor(self.right, node, self, successor);
      }
    }
  }

  return get_successor(this, node, this, node);
}

Node.prototype.predecessor = function(node) {
  var get_predecessor = function(self, node, parent, predecessor) {
    if (parent.right !== null && parent.right === self) { predecessor = parent; }

    if (node === self) {
      if (self.left !== null) {
        return self.left.maximum();
      } else {
        return predecessor;
      }
    }

    if (node.key < self.key) {
      if (self.left !== null) {
        return get_predecessor(self.left, node, self, predecessor);
      }
    } else {
      if (self.right !== null) {
        return get_predecessor(self.right, node, self, predecessor);
      }
    }
  }

  return get_predecessor(this, node, this, node);
}

Node.prototype.height = function() {
  var height = 0;

  var get_height = function(n, height) {
    current = height;
    current++;
    // console.log(current)
    var max = 0;
    // if (n.left !== null) { max = n.left.get_height(current); }
    // if (n.right !== null) { max = n.right.get_height(current); }

    if (n.left !== null) { max = get_height(n.left, current); }
    if (n.right !== null) { max = get_height(n.right, current); }

    current--;
    // console.log(current)
    max = current > max ? current : max;
    return max;
  }

  return get_height(this, height);
}

Node.prototype.is_bst = function() {
  var in_order_traverse = function(n, callback) {
    if (n.left !== null) { in_order_traverse(n.left, callback); }
    callback(n);
    if (n.right !== null) { in_order_traverse(n.right, callback); }
  }

  var result = true;
  var minimum = -10000;
  in_order_traverse(this, function(node) {
    if (minimum >= node.key) { result = false; }
    minimum = node.key;
  });
  return result;
}


// exports.Node = new Node();
exports.Node = Node;
