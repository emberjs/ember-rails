//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./states
//= require_self

// <%= application_name.camelize %>.stateManager is useful for debugging,
// but don't use it directly in application code.
var stateManager = <%= application_name.camelize %>.stateManager = <%= application_name.camelize %>.StateManager.create();
<%= application_name.camelize %>.injectControllers(stateManager);

jQuery(function() {
  stateManager.send('ready');
});

