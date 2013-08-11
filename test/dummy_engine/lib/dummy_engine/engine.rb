$:.unshift(File.expand_path('../../../../../lib', __FILE__))
require 'rails/all'

ENGINE_ROOT = File.expand_path('../../../', __FILE__)
ENGINE_PATH = File.expand_path(__FILE__)

module DummyEngine
  class Engine < ::Rails::Engine
    isolate_namespace DummyEngine
  end
end
