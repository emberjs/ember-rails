<%= application_name.camelize %>.<%= class_name.camelize %>View = Ember.View.extend({
  templateName: 'ember/templates/<%= controller_name.camelize(:lower) %>/<%= class_name.underscore %>',
  controller: <%= application_name.camelize %>.<%= controller_name.camelize(:lower) %>Controller
});