# for more details see: http://emberjs.com/guides/models/defining-models/

<%= application_name.camelize %>.<%= class_name %> = DS.Model.extend<%= "()" if attributes.length == 0 %>
<% attributes.each do |attribute| -%>
  <%= attribute[:name].camelize(:lower) %>: <%=
  if %w(references belongs_to).member?(attribute[:type])
    "DS.belongsTo '%s.%s'" % [application_name.camelize, attribute[:name].camelize]
  else
    "DS.attr '%s'" % attribute[:type]
  end
  %>
<% end -%>
