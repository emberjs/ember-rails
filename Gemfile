source 'https://rubygems.org'
gemspec

if RUBY_VERSION <= '1.9.3'
  gem 'json'
end

if RUBY_VERSION >= '2.2.0'
  gem 'test-unit'
  gem 'safe_yaml', '>= 1.0.4' # To avoid https://github.com/dtao/safe_yaml/issues/67
end
