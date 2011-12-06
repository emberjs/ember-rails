// Console
var console = {};
console.log = console.info = console.warn = console.error = function(){};

// DOM
var document = {};
var window = { console: console };

// jQuery
var jQuery = function() { return jQuery };
jQuery.ready = function() { return jQuery };
var $ = jQuery;

// SC
var sc_assert = function() {};

// Precompiler
var SproutCoreRails = {
  precompile: function(template) {
    return SC.Handlebars.compile(template).toString();
  }
};
