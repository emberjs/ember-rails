# ember-rails  [![Build Status](https://secure.travis-ci.org/keithpitt/ember-rails.png)](http://travis-ci.org/keithpitt/ember-rails)

ember-rails allows you to include [Ember.JS](http://emberjs.com/) into your Rails 3.x application.

The gem will also pre-compile your handlebars templates when building your asset pipeline. It includes development and production copies of Ember.

You can see an example of how to use the gem [here](https://github.com/keithpitt/ember-rails-example)

## Getting started

Add the gem to your application Gemfile:

```ruby
gem "ember-rails"
```

Run `bundle install` and add the following line to
`app/assets/javascripts/application.js`:

```javascript
//= require ember
```

If yopu just want to use Ember Metal (no View or Handlebars support)
you can use:

```javascript
//= require ember-runtime
```

Ember-rails also provides a way to run Ember in development mode, you
can switch out your require statements to use the dev copies like so:

```javascript
//= require ember-dev
```

If you want to copy ember to your own project, you can use the inbuilt
generator

```bash
rails g ember_rails:install
```

If you want to use the latest and greatest Ember, you can use the
generator to download and compile the latest version for you.

```bash
rails g ember_rails:install --head
```

Ask Rails to serve HandlebarsJS and pre-compile templates to Ember
by putting each template in a dedicated ".js.hjs" or ".handlebars" file
(e.g. `app/assets/javascripts/templates/admin_panel.handlebars`)
and including the assets in your layout:

```ruby
<%= javascript_include_tag "templates/admin_panel" %>
```

Bundle all templates together thanks to Sprockets,
e.g create `app/assets/javascripts/templates/all.js` with:

```javascript
//= require_tree .
```

Now a single line in the layout loads everything:

```ruby
<%= javascript_include_tag "templates/all" %>
```

## Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.
