#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates

<%= application_name.camelize %> = Ember.Application.create();
