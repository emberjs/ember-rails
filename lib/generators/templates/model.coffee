# for more details see: http://emberjs.com/guides/models/defining-models/

<%= application_name.camelize %>.<%= class_name %> = DS.Model.extend<%= "()" if attributes.length == 0 %>
<% attributes.each do |attribute| -%>
  <%= attribute[:name].camelize(:lower) %>: <%=
  if %w(references belongs_to).member?(attribute[:type])
    "DS.belongsTo '%s'" % attribute[:name].camelize(:lower)
  else
    "DS.attr '%s'" % attribute[:type]
  end
  %>
<% end -%>
