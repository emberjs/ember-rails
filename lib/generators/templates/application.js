//= require jquery
//= require jquery_ujs
<%= "//= require handlebars\n" if ::Rails.configuration.handlebars.ember_template == 'Handlebars' -%>
//= require ember
//= require ember-data
//= require active-model-adapter
<%- if engine_extension == 'module.es6' -%>
//= require ember-rails/application
//
//= require ./<%= application_name.underscore.dasherize %>
//= require_self

require('<%= application_name.underscore.dasherize %>');
<%- else -%>

//= require_self
//= require ./<%= application_name.underscore.dasherize %>
<%- end -%>

// for more details see: http://emberjs.com/guides/application/
<%= application_name.camelize %> = Ember.Application.create();
