appraise "rails31_ember_pre4" do
  gem 'rails', '~> 3.1'
  gem 'ember-source', '1.0.0.pre4.2'
end

appraise "rails31_ember_rc1" do
  gem 'rails', '~> 3.1'
  gem 'ember-source', "1.0.0.rc1.2"
end

appraise "rails32_ember_pre4" do
  gem 'rails', '~> 3.2'
  gem 'ember-source', '1.0.0.pre4.2'
end

appraise "rails32_ember_rc1" do
  gem 'rails', '~> 3.2'
  gem 'ember-source', "1.0.0.rc1.2"
end

unless RUBY_VERSION == "1.8.7"
  appraise "rails4_ember_pre4" do
    gem 'rails', :git => 'https://github.com/rails/rails.git'
    gem 'activerecord-deprecated_finders', :git => 'https://github.com/rails/activerecord-deprecated_finders.git'
    gem 'ember-source', '1.0.0.pre4.2'
  end

  appraise "rails4_ember_rc1" do
    gem 'rails', :git => 'https://github.com/rails/rails.git'
    gem 'activerecord-deprecated_finders', :git => 'https://github.com/rails/activerecord-deprecated_finders.git'
    gem 'ember-source', "1.0.0.rc1.2"
  end
end


