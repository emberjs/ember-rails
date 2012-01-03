Ember-Rails
================

Ember for Rails 3.1.

Getting started
---------------

Add the gem to your application Gemfile:

    gem "ember-rails"

Run `bundle install` and add the following line to 
`app/assets/javascripts/application.js`:

    //= require ember

Ask Rails to serve HandlebarsJS and pre-compile templates to Ember
by putting each template in a dedicated ".js.hjs" file
(e.g. `app/assets/javascripts/templates/admin_panel.js.hjs`)
and including the assets in your layout:

    <%= javascript_include_tag "templates/admin_panel" %>

Bundle all templates together thanks to Sprockets,
e.g create `app/assets/javascripts/templates/all.js` with:

    //= require_tree .

Now a single line in the layout loads everything:

    <%= javascript_include_tag "templates/all" %>
