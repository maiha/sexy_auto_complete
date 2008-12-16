function getElementsByAttributeName(node, attrname)
{
  var a = [];
  var re = new RegExp('\\b' + attrname + '\\b');
  var els = node.getElementsByTagName("*");
  for(var i=0,j=els.length; i<j; i++)
    if(els[i].getAttribute(attrname)) a.push(els[i]);
  return a;
}

Object.extend(Ajax.Autocompleter.prototype,{
  selectEntry: function() {
    this.active = false;
    var defs = getElementsByAttributeName(this.getCurrentEntry(), 'connect');

    if (defs.length == 0) {
      this.updateElement(this.getCurrentEntry());
    } else {
      for (var i = 0; i < defs.length; i++) {
        var connectid = defs[i].getAttribute("connect");
        if ($(connectid)) {
          if ($(connectid).tagName == "INPUT"){
            $(connectid).value = defs[i].childNodes[0].nodeValue;
          } else {
            $(connectid).innerHTML = defs[i].childNodes[0].nodeValue;
          }
        }
      }
    }

    if (this.options.afterUpdateElement)
      this.options.afterUpdateElement(this.element, this.getCurrentEntry());

    this.element.focus();
  }
});

