<%= application_name.camelize %>.<%= class_name %> = DS.Model.extend({
<% attributes.each_index do |idx| -%>
  <%= attributes[idx][:name].camelize(:lower) %>: <%=
  if %w(references belongs_to).member?(attributes[idx][:type])
    "DS.belongsTo('%s.%s')" % [application_name.camelize, attributes[idx][:name].camelize]
  else
    "DS.attr('%s')" % attributes[idx][:type]
  end
  %><% if (idx < attributes.length-1) %>,<% end %>
<% end -%>
});