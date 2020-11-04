remark.macros.scale = function (percentage) {
  var url = this;
  return '<img src="' + url + '" style="width: ' + percentage + '" />';
};

remark.macros.width_and_height = function (width, height) {
  var url = this;
  return '<img src="' + url + '" style="width: ' + width + '; height: ' + height + '" />';
};