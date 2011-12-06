// DOM
var document = {};
var window = this;

// Console
var console = window.console = {};
console.log = console.info = console.warn = console.error = function(){};

// jQuery
var jQuery = function() { return jQuery };
jQuery.ready = function() { return jQuery };
var $ = jQuery;

// Precompiler
var SproutCoreRails = {
  precompile: function(string) {
    // Copied from the SC codebase. This will need to be updated as SC updates...
    var ast = Handlebars.parse(string);
    var options = { data: true, stringParams: true };
    var environment = new SC.Handlebars.Compiler().compile(ast, options);
    var templateSpec = new SC.Handlebars.JavaScriptCompiler().compile(environment, options, undefined, true);

    return templateSpec.toString();
  }
};
