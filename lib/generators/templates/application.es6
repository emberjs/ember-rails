//= require jquery
//= require jquery_ujs
<%= "//= require handlebars\n" if ::Rails.configuration.handlebars.ember_template == 'Handlebars' -%>
//= require ./environment
//= require ember
//= require ember-data
//= require ember-rails/application
//
//= require ./<%= application_name.underscore.dasherize %>
//= require_self

import <%= application_name.camelize %> from '<%= application_name.underscore.dasherize %>';
// import config from 'environment'; // You can use `config` for application specific variables such as API key, etc.

<%= application_name.camelize %>.create();
