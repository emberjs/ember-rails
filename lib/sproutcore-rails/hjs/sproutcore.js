var SC = { Handlebars : {} };

SC.Handlebars.Compiler = function() {};
SC.Handlebars.Compiler.prototype = Object.create( Handlebars.Compiler.prototype );
SC.Handlebars.Compiler.prototype.compiler = SC.Handlebars.Compiler;

SC.Handlebars.JavaScriptCompiler = function() {};
SC.Handlebars.JavaScriptCompiler.prototype = Object.create(Handlebars.JavaScriptCompiler.prototype);
SC.Handlebars.JavaScriptCompiler.prototype.compiler = SC.Handlebars.JavaScriptCompiler;

/**
  Override the default property lookup semantics of Handlebars.

  By default, Handlebars uses object[property] to look up properties. SproutCore's Handlebars
  uses SC.get().

  @private
*/
SC.Handlebars.JavaScriptCompiler.prototype.nameLookup = function(parent, name, type) {
  if (type === 'context') {
    return "SC.get(" + parent + ", " + this.quotedString(name) + ");";
  } else {
    return Handlebars.JavaScriptCompiler.prototype.nameLookup.call(this, parent, name, type);
  }
};

SC.Handlebars.JavaScriptCompiler.prototype.initializeBuffer = function() {
  return "''";
};

/**
  Override the default buffer for SproutCore Handlebars. By default, Handlebars creates
  an empty String at the beginning of each invocation and appends to it. SproutCore's
  Handlebars overrides this to append to a single shared buffer.

  @private
*/
SC.Handlebars.JavaScriptCompiler.prototype.appendToBuffer = function(string) {
  return "data.buffer.push("+string+");";
};

/**
  Rewrite simple mustaches from {{foo}} to {{bind "foo"}}. This means that all simple
  mustaches in SproutCore's Handlebars will also set up an observer to keep the DOM
  up to date when the underlying property changes.

  @private
*/
SC.Handlebars.Compiler.prototype.mustache = function(mustache) {
  if (mustache.params.length || mustache.hash) {
    return Handlebars.Compiler.prototype.mustache.call(this, mustache);
  } else {
    var id = new Handlebars.AST.IdNode(['bind']);

    // Update the mustache node to include a hash value indicating whether the original node
    // was escaped. This will allow us to properly escape values when the underlying value
    // changes and we need to re-render the value.
    if(mustache.escaped) {
      mustache.hash = mustache.hash || new Handlebars.AST.HashNode([]);
      mustache.hash.pairs.push(["escaped", new Handlebars.AST.StringNode("true")]);
    }
    mustache = new Handlebars.AST.MustacheNode([id].concat([mustache.id]), mustache.hash, !mustache.escaped);
    return Handlebars.Compiler.prototype.mustache.call(this, mustache);
  }
};

SC.Handlebars.precompile = function(string) {
  var options = { data: true, stringParams: true };
  var ast = Handlebars.parse(string);
  var environment = new SC.Handlebars.Compiler().compile(ast, options);
  return (new SC.Handlebars.JavaScriptCompiler().compile(environment, options)).toString();
};
