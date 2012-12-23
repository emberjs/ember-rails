appraise "rails3" do
  gem 'rails', '~> 3.1'
end

unless RUBY_VERSION == "1.8.7"
  appraise "rails4" do
    gem 'rails', :git => 'https://github.com/rails/rails.git'
    gem 'activerecord-deprecated_finders', :git => 'https://github.com/rails/activerecord-deprecated_finders.git'
  end
end