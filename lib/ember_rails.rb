require 'sprockets'
require 'sprockets/engines'

require 'ember/rails/engine'

require 'ember/version'
require 'ember/handlebars/version'

require 'ember/filters/slim' if defined? Slim
require 'ember/filters/haml' if defined? Haml
