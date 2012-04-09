require 'sprockets'
require 'sprockets/engines'

require "ember/rails/engine"

require "ember/filters/slim" if defined? Slim
require "ember/filters/haml" if defined? Haml
