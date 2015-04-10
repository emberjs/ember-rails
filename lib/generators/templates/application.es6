//= require jquery
//= require jquery_ujs
<%= "//= require handlebars\n" if ::Rails.configuration.handlebars.ember_template == 'Handlebars' -%>
//= require ember
//= require ember-data
//= require ember-rails/application
//
//= require ./<%= application_name.underscore.dasherize %>
//= require_self

import <%= application_name.camelize %> from '<%= application_name.underscore.dasherize %>';

<%= application_name.camelize %>.create();
