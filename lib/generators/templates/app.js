//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./states
//= require_self

var router = <%= application_name.camelize %>.router = <%= application_name.camelize %>.Router.create();
<%= application_name.camelize %>.initialize(router);

jQuery(function() {
  router.send('ready');
});

