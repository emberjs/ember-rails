#= require jquery
#= require jquery_ujs
<%= "#= require handlebars\n" if Ember::Handlebars::Template.handlebars_available? -%>
#= require ./environment
#= require ember
#= require ember-data
#= require active-model-adapter
#= require_self
#= require ./<%= application_name.underscore.dasherize %>

# for more details see: http://emberjs.com/guides/application/
window.<%= application_name.camelize %> = Ember.Application.create()
