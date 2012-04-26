require "bundler"
Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

desc 'Build and copy Ember.js and Ember Data assets from submodules into vendor/assets'
task :assets do
  # Only initialize submodules if uninitialized, to avoid kicking users off
  # their checked-out branches
  sh 'git submodule update --init' unless File.exist?('ember.js/Rakefile') || File.exist?('ember-data/Rakefile')
  Bundler.with_clean_env do
    sh 'cd ember.js && bundle install --quiet && bundle exec rake dist'
    sh 'cd ember-data && bundle install --quiet && bundle exec rake dist'
  end

  mkdir_p 'vendor/ember/development'
  cp 'ember.js/dist/ember.js', 'vendor/ember/development/'
  cp 'ember.js/dist/ember-runtime.js', 'vendor/ember/development/'
  cp 'ember-data/dist/ember-data.js', 'vendor/ember/development/'

  mkdir_p 'vendor/ember/production'
  cp 'ember.js/dist/ember.prod.js', 'vendor/ember/production/ember.js'
  cp 'ember.js/dist/ember-runtime.prod.js', 'vendor/ember/production/ember-runtime.js'
  cp 'ember-data/dist/ember-data.prod.js', 'vendor/ember/production/ember-data.js'

  mkdir_p 'vendor/ember/spade'
  cp 'ember.js/dist/ember-spade.js', 'vendor/ember/spade/ember.js'
  cp 'ember-data/dist/ember-data-spade.js', 'vendor/ember/spade/ember-data.js'
end

task :default => :test
