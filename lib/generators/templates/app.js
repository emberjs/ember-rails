//= require ./store
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./routes
//= require_self

var router = <%= application_name.camelize %>.router = <%= application_name.camelize %>.Router.create({
  location: 'hash'
});

<%= application_name.camelize %>.Store = DS.Store.extend({
  revision: 4,
  adapter: DS.RESTAdapter.create()
});

<%= application_name.camelize %>.initialize(router);

