<%= application_name.camelize %>.<%= class_name %> = DS.Model.extend({
<% attributes.each_with_index do |attribute, idx| -%>
  <%= attribute[:name].camelize(:lower) %>: <%=
  if %w(references belongs_to).member?(attribute[:type])
    "DS.belongsTo('%s.%s')" % [application_name.camelize, attribute[:name].camelize]
  else
    "DS.attr('%s')" % attribute[:type]
  end
  %><% if (idx < attributes.length-1) %>,<% end %>
<% end -%>
});