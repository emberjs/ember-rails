// DOM
var Element = {};
Element.firstChild = function () { return Element; };
Element.innerHTML = function () { return Element; };

var document = { createRange: false, createElement: function() { return Element; } };
var window = this;
this.document = document;

// null out console.log and console.warn to avoid unexpected output
if (window.console) {
  window.console.warn = function() {};
  window.console.log = function() {};
}

//// jQuery
var jQuery = window.jQuery = function() { return jQuery; };
jQuery.ready = function() { return jQuery; };
jQuery.inArray = function() { return jQuery; };
jQuery.jquery = "1.7.2";

// Precompiler
var EmberRails = {
  precompile: function(string) {
    return Ember.Handlebars.precompile(string).toString();
  }
};
