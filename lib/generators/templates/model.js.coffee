<%= application_name.camelize %>.<%= class_name %> = DS.Model.extend
<% attributes.each_index do |idx| -%>
  <%= attributes[idx][:name].camelize(:lower) %>: DS.attr('<%= attributes[idx][:type] %>')
<% end -%>
