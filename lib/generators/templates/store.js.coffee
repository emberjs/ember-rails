# http://emberjs.com/guides/models/using-the-store/
#
# Use DS.ActiveModelAdapter here rather than the DS.RESTAdapter because
# it is built to work nicely with the ActiveModel::Serializers gem.

<%= application_name.camelize %>.Store = DS.Store.extend
  adapter: DS.ActiveModelAdapter.extend({})
