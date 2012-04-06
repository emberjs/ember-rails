module Slim
  class EmbeddedEngine
    register :handlebars, TagEngine, :tag => :script, :attributes => { :type => 'text/x-handlebars' }
  end
end
