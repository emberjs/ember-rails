# ember-rails  [![Build Status](https://secure.travis-ci.org/keithpitt/ember-rails.png)](http://travis-ci.org/keithpitt/ember-rails)

ember-rails allows you to include [Ember.JS](http://emberjs.com/) into your Rails 3.1 application.

The gem will also pre-compile your handlebars templates when building your asset pipeline. It includes development and production copies of Ember.

You can see an example of how to use the gem [here](https://github.com/keithpitt/ember-rails-example)

## Getting started

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

## History

ember-rails is based on https://github.com/kiskolabs/sproutcore-rails.

## Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.