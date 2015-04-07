# for more details see: http://emberjs.com/guides/views/

<%= application_name.camelize %>.<%= class_name.camelize %>View = Ember.View.extend
  templateName: '<%= handlebars_template_path %>'
