#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require <%= application_name.underscore %>

# for more details see: http://emberjs.com/guides/application/
window.<%= application_name.camelize %> = Ember.Application.create()
