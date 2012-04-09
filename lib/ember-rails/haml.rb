module Haml
  module Filters
    module Handlebars
      include Base
      def render_with_options(text, options)
        type = "type=#{options[:attr_wrapper]}text/x-handlebars#{options[:attr_wrapper]}"
        "<script #{type}>\n#{text.rstrip}\n</script>"
      end
    end
  end
end
