#= require jquery
#= require jquery_ujs
<%= "#= require handlebars\n" if ::Rails.configuration.handlebars.ember_template == 'Handlebars' -%>
#= require ember
#= require ember-data
#= require active-model-adapter
#= require_self
#= require <%= application_name.underscore %>

# for more details see: http://emberjs.com/guides/application/
window.<%= application_name.camelize %> = Ember.Application.create()
