var Node = function (k) {};

Node.prototype.log = function () {
  console.log('Node!');
};

Node.prototype.new = function(k) {
  return {
    key: k,
    left: null,
    right: null
  };
};

exports.Node = new Node();
