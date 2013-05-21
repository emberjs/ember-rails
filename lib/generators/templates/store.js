<%= application_name.camelize %>.Store = DS.Store.extend({
  revision: 11,
  adapter: DS.RESTAdapter.create()
});
