require "bundler"
Bundler::GemHelper.install_tasks
require 'appraisal'

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :update_vendor do
  ember_js_dir = ENV['EMBER_JS_DIR'] || '../ember.js'
  abort "Cannot find ember.js repo at '#{ember_js_dir}'.\nPlease clone it or tell Rake where it is with EMBER_JS_DIR=/path/to/ember.js" unless File.exists? ember_js_dir


  FileUtils.cd ember_js_dir do
    Bundler.clean_system "git checkout v#{EmberRails::EMBER_VERSION} && bundle && bundle exec rake dist"
  end
  FileUtils.cp "#{ember_js_dir}/dist/ember-runtime.js",     'vendor/assets/javascripts/ember-runtime-dev.js'
  FileUtils.cp "#{ember_js_dir}/dist/ember-runtime.min.js", 'vendor/assets/javascripts/ember-runtime.js'
  FileUtils.cp "#{ember_js_dir}/dist/ember.js",             'vendor/assets/javascripts/ember-dev.js'
  FileUtils.cp "#{ember_js_dir}/dist/ember.min.js",         'vendor/assets/javascripts/ember.js'

  puts "Updated js files in vendor/assets to ember.js v#{EmberRails::EMBER_VERSION}"
end

task :default => :test
