<%= "#{app_namespace}.#{class_name}" %> = Ember.Object.extend
<% attributes.each do |attribute| -%>
  <%= attribute.name %>: <%= default_value(attribute.type) %>
<% end -%>