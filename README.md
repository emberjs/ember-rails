# ember-rails  [![Build Status](https://secure.travis-ci.org/emberjs/ember-rails.svg?branch=master)](http://travis-ci.org/emberjs/ember-rails) [![Dependency Status](https://gemnasium.com/emberjs/ember-rails.png)](https://gemnasium.com/emberjs/ember-rails) [![Code Climate](https://codeclimate.com/github/emberjs/ember-rails/badges/gpa.svg)](https://codeclimate.com/github/emberjs/ember-rails)

ember-rails makes developing an [Ember.JS](http://emberjs.com/) application much easier in Rails 3.1+.

The following functionalities are included in this gem:
- Pre-compiling of your handlebars templates when building your asset pipeline.
- Inclusion of development and production copies of Ember, [Ember Data](https://github.com/emberjs/data) and [Handlebars](https://github.com/wycats/handlebars.js).
- Inclusion of [ActiveModel::Serializer](https://github.com/rails-api/active_model_serializers) for integration with Ember Data.

You can see an example of how to use the gem [here](https://github.com/keithpitt/ember-rails-example). There is also a great tutorial by [Dan Gebhardt](https://twitter.com/#!/dgeb) called "[Beginning Ember.js on Rails](http://www.cerebris.com/blog/2012/01/24/beginning-ember-js-on-rails-part-1/)" which is a great read if you're just starting out with Rails and Ember.js.

## Getting started
* Add the gem to your application Gemfile:

```ruby
gem 'ember-rails'
gem 'ember-source', '~> 1.9.0' # or the version you need
```

* Run `bundle install`
* Next, generate the application structure:

```shell
rails generate ember:bootstrap
```

* Restart your server (if it's running)

## Building a new project from scratch

Rails supports the ability to build projects from a template source ruby file.

To build an Ember centric Rails project you can simply type the following into your command line:

```
rails new my_app -m http://emberjs.com/edge_template.rb
```

Read more about [Rails application templates](http://edgeguides.rubyonrails.org/rails_application_templates.html) and take a look at the edge_template.rb [source code](https://github.com/emberjs/website/blob/master/source/edge_template.rb).

Notes:

To install the latest builds of ember and ember-data. It should be noted that the
examples in the [getting started guide](http://emberjs.com/guides/getting-started/)
have been designed to use the released version of ember:

```shell
rails generate ember:install
```

You'll probably need to clear out your cache after doing this with:

```shell
rake tmp:clear
```

Also, ember-rails includes some flags for the bootstrap generator:

```
--ember-path or -d   # custom ember path
--skip-git or -g     # skip git keeps
--javascript-engine  # engine for javascript (js, coffee or em)
--app-name or -n     # custom ember app name
```


## For CoffeeScript support

Add coffee-rails to the Gemfile
```ruby
gem 'coffee-rails'
```

Run the bootstrap generator in step 4 with an extra flag instead:
```sh
rails g ember:bootstrap -g --javascript-engine coffee
```

## For EmberScript support

[EmberScript](http://www.emberscript.com) is a dialect of CoffeeScript
with extra support for computed properties (which do not have to be
explicitly declared), the `class` / `extends` syntax, and extra syntax
to support observers and mixins.

To get EmberScript support, make sure you have the following in your
Gemfile:

```ruby
gem 'ember_script-rails', :github => 'ghempton/ember-script-rails'
```

You can now use the flag `--javascript-engine=em` to specify EmberScript
assets in your generators, but all of the generators will default to
using an EmberScript variant first.


## Configuration Options

The following options are available for configuration in your application or environment-level
config files (`config/application.rb`, `config/environments/development.rb`, etc.):

| Configuration Option                         | Description                                                                                                         |
|----------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| `config.ember.variant`                       | Determines which Ember variant to use. Valid options: `:development`, `:production`. Defaults to `:production` in production, and `:development` everywhere else.                               |
| `config.ember.app_name`                      | Specificies a default application name for all generators.                                                          |
| `config.ember.ember_path`                    | Specifies a default custom root path for all generators.                                                            |
| `config.handlebars.precompile`               | Enables or disables precompilation. Default value: `true`.                                                          |
| `config.handlebars.templates_root`           | Sets the root path (under `app/assets/javascripts`) for templates to be looked up in. Default value: `"templates"`. |
| `config.handlebars.templates_path_separator` | The path separator to use for templates. Default value: `'/'`.                                                      |
| `config.handlebars.output_type`              | Configures the style of output (options are `:amd` and `:global`). Default value: `:global`.                        |
| `config.handlebars.amd_namespace`            | Configures the module prefix for AMD formatted output. Default value: `nil`.                        |
| `config.handlebars.ember_template`           | Default which Ember template type to compile. Valid options: `'Handlebars', `HTMLBars`. Defaults to 'Handlebars`' when `Ember::VERSION` is under 1.10.0, `HTMLBars` when `Ember::VERSION` is over 1.10.0. |

Note:

In a mountable engine, ember-rails will not recognize any configurations.
Instead, use command line options.

## Enabling Features with Feature Flags
See [the guide](http://emberjs.com/guides/configuring-ember/feature-flags/#toc_flagging-details) and check [features.json](https://github.com/emberjs/ember.js/blob/master/features.json) for the version of Ember you're using.

If a feature is set to false, you will need to compile ember from source yourself to include it.

### Important note for projects that render JSON responses

ember-rails includes [active_model_serializers](https://github.com/rails-api/active_model_serializers) which affects how ActiveModel and ActiveRecord objects get serialized to JSON, such as when using `render json:` or `respond_with`. By default active_model_serializers adds root elements to these responses (such as adding `{"posts": [...]}` for `render json: @posts`) which will affect the structure of your JSON responses.

To disable this effect on your JSON responses, put this in an initializer:
```Ruby
# Stop active_model_serializers from adding root elements to JSON responses.
ActiveModel::Serializer.root = false
ActiveModel::ArraySerializer.root = false
```

See the [active_model_serializers](https://github.com/rails-api/active_model_serializers) documentation for a more complete understanding of other effects this dependency might have on your app.

## Architecture

Ember does not require an organized file structure. However, ember-rails allows you
to use `rails g ember:bootstrap` to create the following directory structure under `app/assets/javascripts`:

```
├── adapters
├── components
├── controllers
├── helpers
├── mixins
├── models
├── practicality.js.coffee
├── router.js.coffee
├── routes
├── store.js.coffee
├── templates
│   └── components
└── views
```

Additionally, it will add the following lines to `app/assets/javascripts/application.js`.
By default, it uses the Rails Application's name and creates an `rails_app_name.js`
file to set up application namespace and initial requires:

```javascript
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require rails_app_name
RailsAppName = Ember.Application.create();
```

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
      create  app/assets/javascripts/components
      create  app/assets/javascripts/components/.gitkeep
      create  app/assets/javascripts/templates
      create  app/assets/javascripts/templates/.gitkeep
      create  app/assets/javascripts/templates/components
      create  app/assets/javascripts/templates/components/.gitkeep
      create  app/assets/javascripts/mixins
      create  app/assets/javascripts/mixins/.gitkeep
      create  app/assets/javascripts/adapters
      create  app/assets/javascripts/adapters/.gitkeep
      create  app/assets/javascripts/app.js

If you want to avoid `.gitkeep` files, use the `skip git` option like
this: `rails g ember:bootstrap -g`.

Ask Rails to serve HandlebarsJS and pre-compile templates to Ember
by putting each template in a dedicated ".js.hjs", ".hbs" or ".handlebars" file
(e.g. `app/assets/javascripts/templates/admin_panel.handlebars`)
and including the assets in your layout:

    <%= javascript_include_tag "templates/admin_panel" %>

If you want to avoid the `templates` prefix, set the `templates_root` option in your application configuration block:

    config.handlebars.templates_root = 'ember_templates'

If you store templates in a file like `app/assets/javascripts/ember_templates/admin_panel.handlebars` after setting the above config,
it will be made available to Ember as the `admin_panel` template.

_(Note: you must clear the local sprockets cache after modifying `templates_root`, stored by default in `tmp/cache/assets`)_

Default behavior for ember-rails is to precompile handlebars templates.
If you don't want this behavior you can turn it off in your application configuration (or per environment in: `config/environments/development.rb`) block:

    config.handlebars.precompile = false

_(Note: you must clear the local sprockets cache if you disable precompilation, stored by default in `tmp/cache/assets`)_

Bundle all templates together thanks to Sprockets,
e.g create `app/assets/javascripts/templates/all.js` with:

    //= require_tree .

Now a single line in the layout loads everything:

    <%= javascript_include_tag "templates/all" %>

### Note about ember components

When necessary, ember-rails adheres to a conventional folder structure. To create an ember component you must define the handlebars file *inside* the *components* folder under the templates folder of your project to properly register your handlebars component file.

*Example*

Given the following folder structure:

```
├── adapters
├── components
├── controllers
├── helpers
├── mixins
├── models
├── practicality.js.coffee
├── router.js.coffee
├── routes
├── store.js.coffee
├── templates
│   └── components
│       └── my-component.handlebars
└── views
```

and a `my-component.handlebars` file with the following contents:

    <h1>My Component</h1>

It will produce the following handlebars output:

    <script type="text/x-handlebars" id="components/my-component">
      <h1>My Component</h1>
    </script>

You can reference your component inside your other handlebars template files by the handlebars file name:

     {{ my-component }}

## Specifying Different Versions of Ember/Handlebars/Ember-Data

By default, ember-rails ships with the latest version of
[Ember](https://rubygems.org/gems/ember-source/versions),
[Handlebars](https://rubygems.org/gems/handlebars-source/versions),
and [Ember-Data](https://rubygems.org/gems/ember-data-source/versions).

To specify a different version that'll be used for both template
precompilation and serving to the browser, you can specify the desired
version of one of the above-linked gems in the Gemfile, e.g.:

    gem 'ember-source', '1.7.0'

You can also specify versions of 'handlebars-source' and
'ember-data-source', but note that an appropriate 'handlebars-source'
will be automatically chosen depending on the version of 'ember-source'
that's specified.

You can also override the specific ember.js, handlebars.js, and
ember-data.js files that'll be `require`d by the Asset pipeline by
placing these files in `vendor/assets/ember/development` and
`vendor/assets/ember/production`, depending on the `config.ember.variant`
you've specified in your app's configuration, e.g.:

    config.ember.variant = :production
    #config.ember.variant = :development

## Updating Ember

If at any point you need to update Ember.js from any of the release channels, you can do that with

    rails generate ember:install --channel=<channel>

This will fetch both Ember.js and Ember Data from [http://builds.emberjs.com/](http://builds.emberjs.com/) and copy to the right directory. You can choose between the following channels:
* canary - This references the 'master' branch and is not recommended for production use.
* beta - This references the 'beta' branch, and will ultimately become the next stable version. It is not recommended for production use.
* release - This references the 'stable' branch, and is recommended for production use.

When you don't specify a channel, the release channel is used.

It is also possible to download a specific tagged release. To do this, use the following syntax:


    rails generate ember:install --tag=v1.2.0-beta.2 --ember

or for ember-data

    rails generate ember:install --tag=v1.0.0-beta.2 --ember-data

## CSRF Token

Rails [`protect_from_forgery`](http://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html#method-i-protect_from_forgery) requires CSRF token for every XHR except GET.
The CSRF token is normally found in `app/views/layouts/application.html.*` inserted with the rails helper: [`csrf_meta_tags`](http://api.rubyonrails.org/classes/ActionView/Helpers/CsrfHelper.html#method-i-csrf_meta_tags).

When you use [jquery-ujs](https://github.com/rails/jquery-ujs),
the CSRF token will be sent to the rails application on every XHR automatically.
If not so, the following JavaScript is required in your code.

``` javascript
$.ajaxPrefilter(function(options, originalOptions, xhr) {
  var token = $('meta[name="csrf-token"]').attr('content');
  xhr.setRequestHeader('X-CSRF-Token', token);
});
```

## Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.
