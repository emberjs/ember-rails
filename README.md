# ember-rails

ember-rails allows you to include [Ember.JS](http://emberjs.com/) into your Rails 3.1 application and have it integrate with the Asset Pipeline. It includes development and production copies of Ember.

The gem will also pre-compile your handlebars templates when building your asset pipeline.

### Getting started

Add the gem to your application Gemfile:

    gem "ember-rails"

Run `bundle install` and add the following line to 
`app/assets/javascripts/application.js`:

    //= require ember

If you want to include the new date-time helpers provided by ember, you
can use:

    //= require ember-datetime

Ember-rails also provides a way to run Ember in development mode, you
can switch out your require statements to use the dev copies like so:

    //= require ember-dev
    //= require ember-datetime-dev

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
