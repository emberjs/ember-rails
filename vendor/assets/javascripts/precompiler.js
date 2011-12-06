// DOM
var window = {};
var document = {};

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
