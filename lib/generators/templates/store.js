// http://emberjs.com/guides/models/using-the-store/

<%= application_name.camelize %>.Store = DS.Store.extend({
  revision: 13,
  adapter: DS.RESTAdapter.create()
});
