# for more details see: http://emberjs.com/guides/views/

class <%= application_name.camelize %>.<%= class_name.camelize %>View extends Ember.View
  templateName: '<%= handlebars_template_path %>'
