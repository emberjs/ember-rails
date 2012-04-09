require 'haml'

module EmberRails
  module HamlFilter
    module Handlebars
      include ::Haml::Filters::Base

      def render(text)
        <<-HJS
<script type="text/x-handlebars">
  #{text}
</script>
        HJS
      end
    end
  end
end
