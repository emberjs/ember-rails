# ember-rails  [![Build Status](https://secure.travis-ci.org/emberjs/ember-rails.png?branch=master)](http://travis-ci.org/emberjs/ember-rails) [![Dependency Status](https://gemnasium.com/emberjs/ember-rails.png)](https://gemnasium.com/emberjs/ember-rails)

ember-rails allows you to include [Ember.JS](http://emberjs.com/) into your Rails 3.1+ application.

The gem will also pre-compile your handlebars templates when building your asset pipeline. It includes development and production copies of Ember.

You can see an example of how to use the gem [here](https://github.com/keithpitt/ember-rails-example). There is also a great tutorial by [Dan Gebhardt](https://twitter.com/#!/dgeb) called "[Beginning Ember.js on Rails](http://www.cerebris.com/blog/2012/01/24/beginning-ember-js-on-rails-part-1/)" which is a great read if your just starting out with Rails and Ember.js

## Getting started

Add the gem to your application Gemfile:

    gem "ember-rails"

Run `bundle install` and add the following line to `app/assets/javascripts/application.js`:

    //= require ember

Ember-rails will use the production build of Ember.js when Rails is running in
production mode, and the development build otherwise.

## Architecture

Ember does not require an organized file structure. However, ember-rails allows you 
to use `rails g ember:bootstrap` to create the following directory structure under `app/assets/javascripts`:

    controllers/
    helpers/
    models/
    routes/
    templates/
    views/

Additionally, it will add the following lines to `app/assets/javascripts/application.js`.
By default, it uses the Rails Application's name and creates an `rails_app_name.js` 
file to setup application namespace and initial requires:

    //= require ember
    //= require ember/app

*Example:*

    rails g ember:bootstrap
      insert  app/assets/javascripts/application.js
      create  app/assets/javascripts/models
      create  app/assets/javascripts/models/.gitkeep
      create  app/assets/javascripts/controllers
      create  app/assets/javascripts/controllers/.gitkeep
      create  app/assets/javascripts/views
      create  app/assets/javascripts/views/.gitkeep
      create  app/assets/javascripts/helpers
      create  app/assets/javascripts/helpers/.gitkeep
      create  app/assets/javascripts/templates
      create  app/assets/javascripts/templates/.gitkeep
      create  app/assets/javascripts/app.js

If you want to avoid `.gitkeep` files, use the `skip git` option like
this: `rails g ember:bootstrap -g`.

Ask Rails to serve HandlebarsJS and pre-compile templates to Ember
by putting each template in a dedicated ".js.hjs", ".hbs" or ".handlebars" file
(e.g. `app/assets/javascripts/templates/admin_panel.handlebars`)
and including the assets in your layout:

    <%= javascript_include_tag "templates/admin_panel" %>

If you want to strip template root from template names, add `templates_root` option to your application configuration block :

    config.handlebars.templates_root = 'templates'

The result will be like this :

    Ember.TEMPLATES['admin_panel'] = "...";

If you want a different path separator in template names add `templates_path_separator` option to your application configuration block :

    config.handlebars.templates_path_separator = '-'

The result will be like this :

    Ember.TEMPLATES['templates-admin_panel'] = "...";

Default behavior for ember-rails is to precompile handlebars templates only in production environment.
If you don't want this behavior you can turn it off in your application configuration block :

    config.handlebars.precompile = false

Bundle all templates together thanks to Sprockets,
e.g create `app/assets/javascripts/templates/all.js` with:

    //= require_tree .

Now a single line in the layout loads everything:

    <%= javascript_include_tag "templates/all" %>

If you use Slim or Haml templates, you can use handlebars filter :

    :handlebars
        {{#view Ember.Button}}OK{{/view}}

It will be translated as :

    <script type="text/x-handlebars">
        {{#view Ember.Button}}OK{{/view}}
    </script>

## Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.
