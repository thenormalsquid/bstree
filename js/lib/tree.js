var Tree = function () {};

Tree.prototype.log = function (msg) {
  console.log(msg);
};

Tree.prototype.new = function () {
  return {
    root: null
  };
}

exports.Tree = new Tree();
