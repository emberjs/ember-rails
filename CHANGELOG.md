## 0.20.2 (Mar 6, 2016)

  - Fix to generated app file path for coffee & em
  - Allow `transforms` directory as an module compilation target

## 0.20.1 (Feb 20, 2016)

  - Fix environment.coffee/em generator typo

## 0.20.0 (Feb 9, 2016)

  - Support ES6 syntax

## 0.19.3 (Dec 9, 2015)

  - Use the 'prod' variant when downloading ember

## 0.19.2 (Aug 28, 2015)

  - Support sprockets-rails 3.0.0

## 0.19.1 (Aug 14, 2015)

  - Fix to be compatible with Sprockets 2 and 3

## 0.19.0 (July 13, 2015)

  - Add support for the active-model-adapter as a gem

## 0.18.3 (July 5, 2015)

  - Fix to support jRuby without handlebars-source

## 0.18.2 (April 11, 2015)

  - Update generator using `Ember.Controller` instead of `Ember.ObjectController`

## 0.18.1 (April 2, 2015)

  - Support to precompile handlebars with vendored ember-template-compiler.js

## 0.18.0 (Mar 30, 2015)

  - Extract `Ember::Handlebars::Template` to [ember-handlebars-template](https://github.com/tricknotes/ember-handlebars-template) gem.
  - Support sprockets 3 beta

## 0.17.0 (Mar 14, 2015)

  - Remove Handlebars dependency (It becomes an optional feature.)

## 0.16.4 (Feb 17, 2015)

  - Append all assets to sprockets path that bundled in ember-source & ember-data-source

## 0.16.3 (Feb 13, 2015)

  - Remove extra heading `/` from AMD module name

## 0.16.2 (Feb 11, 2015)

  - Restrict handlebars-source version < 3 because of precompilation failed.
  - Update generator using `jquery_ujs` to deal with CSRF Token correctly.

## 0.16.1 (Jan 1, 2015)

  - Fix to support ember-data.js.map

## 0.16.0 (Dec 28, 2014)

  - Support HTMLBars compilation
  - Add adapter generator

## 0.15.1 (Dec 13, 2014)

  - Fix `ember:install` for ember-data to work with `--channel=release`.
  - Stop generation `App.Store`.
  - Support for CSRF Token to DS.RESTAdapter in store
  - Fix handlebars amd output compatibility with IE8

## 0.15.0 (April 30, 2014)

  - Load app.js with relative path.
  - Bootstrap generator should add code at the end of application.js if there's no newline.
  - coffee-script template should require jQuery.
  - Ensure Ember Data 1.0.0-beta is used.
  - Use App.ApplicationAdapter instead of using `_ams`.

## 0.14.1 (Nov 27, 2013)

  - Fixed 404 error detection in `ember:install` generator.
  - Fixed bootstrap generator for Rails engines.
  - Override channel to beta for Ember Data if `--channel=release` was specified. This is needed
    because Ember Data does not have any builds in the release channel (since it has not hit 1.0).
  - Fixed a few typos.

## 0.14.0 (Nov 4, 2013)

  - Added support for most recent stable releases of ember js and ember data.
  - Added various fixes to better support Rails 4.0 projects out of the box
  - Added generators for ember components
  - Append source url and timestamp when manually fetching ember js source files via install command.
  - Added support for DS.ActiveModelAdapter and support for underscore to camelCased model properties. 
    For more info see issue #268
  - Added support for selective downloading of ember source via channels: canary, beta, release
  - Added support to selectively download tagged releases
  - Added support for compilation of project code as AMD modules in addition to the default behavior of 
    compiling a global AppName namespace. For more info on AMD modules see http://requirejs.org/docs/whyamd.html
  - Added support for customizing ember generators output with custom ember_path. 
    If your ember project source lives in a non standard directory
  - Added additional configuration options for customizing some of the behavior of ember-rails.
    For more info see Configuration Options section of readme.
  - Added support for EmberScript in the generators
  - Various bug fixes and improved test coverage

## 0.11.0 (Feb 28, 2013)

  - Use handlebars-source and ember-source gems

## 0.10.0 (Feb 17, 2013)

  - Updated Ember.js to version 1.0-rc.1
  - Updated Handlebars.js to version 1.0-rc.3

## 0.9.1 (Jan 23, 2013)

  - Updated Ember.js to version 1.0-pre.4
  - Updated Handlebars.js to version 1.0-rc2

  - Remove filters as Ember do not support
  anonymous templates anymore

## 0.8.0 (Oct 27, 2012)

  - Updated Ember.js to version 1.0-pre.2

## 0.5.0 (Mai 25, 2012)

  - Updated Ember.js to version 0.9.8.1

  Improvements:

  - The development/production switch was rewriten and should be muche more robust
  - Lots of work on generators

## 0.4.0 (Avr 20, 2012)

  - Updated Ember.js to version 0.9.7.1

  Improvements:

  - Ember-rails will use the production build of Ember.js when Rails is
    running in production mode, and the development build otherwise.

## 0.3.1 (Avr 19, 2012)

  - Updated Ember.js to version 0.9.7

  Improvements:

  - Fix #34

## 0.3.0 (Avr 9, 2012)

  - Updated Ember.js to version 0.9.6

  Improvements:

  - Use precompilation only in production environment
  - Expose some options related to templates paths
  - Slim and Haml filters

## 0.2.4 (Jan 27, 2012)

  - Updated Ember.js to version 0.9.4

  Improvements:

  - Removing ember-datetime. Just vanilla ember.js will be included in
    this gem for the immediate future.
  - Use precompilation provided by Ember.js to reduce duplication
