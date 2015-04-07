// for more details see: http://emberjs.com/guides/models/defining-models/

import DS from 'ember-data';

export default DS.Model.extend({
<% attributes.each_with_index do |attribute, idx| -%>
  <%= attribute[:name].camelize(:lower) %>: <%=
  if %w(references belongs_to).member?(attribute[:type])
    "DS.belongsTo('%s')" % attribute[:name].camelize(:lower)
  else
    "DS.attr('%s')" % attribute[:type]
  end
  %><% if (idx < attributes.length-1) %>,<% end %>
<% end -%>
});
