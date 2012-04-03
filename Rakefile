require "bundler"
Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

namespace :vendor do 
  desc "Update ember to VERSION"
  task :update_ember do
    ember_version = ENV['VERSION']
    ember_repository = "http://github.com/emberjs/ember.js"
    ember_checkout_dir = "/tmp/ember.js"
    ember_rails_assets_dir = File.join(File.dirname(__FILE__), "vendor", "assets", "javascripts")

    raise "Please specify the ember-version: bundle exec rake vendor:update_ember VERSION=x.y.z" if ember_version.nil?

    cmd = [
      "ruby -v",
      "rm -rf #{ember_checkout_dir} && mkdir #{ember_checkout_dir}",
      "git clone #{ember_repository} #{ember_checkout_dir}",
      "cd #{ember_checkout_dir} && git checkout #{ember_version} && bundle install && bundle exec rake dist",
      "cp #{ember_checkout_dir}/dist/ember.js #{ember_rails_assets_dir}/ember-dev.js",
      "cp #{ember_checkout_dir}/dist/ember.prod.js #{ember_rails_assets_dir}/ember.js",
      "cp #{ember_checkout_dir}/dist/ember-runtime.js #{ember_rails_assets_dir}/ember-runtime-dev.js",
      "cp #{ember_checkout_dir}/dist/ember-runtime.prod.js #{ember_rails_assets_dir}/ember-runtime.js"
    ].join(" && ")

    Bundler.with_clean_env do
      if system cmd
        puts "Update finished. Please check vendor/assets/javascripts/ember* and execute 'bundle exec rake' to check if everything is working."
     else
        fail "Something went wrong."
      end
    end
  end
end

task :default => :test
