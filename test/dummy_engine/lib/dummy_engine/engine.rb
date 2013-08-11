require 'rails/all'

module DummyEngine
  class Engine < ::Rails::Engine
    isolate_namespace DummyEngine
  end
end
