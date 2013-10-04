// http://emberjs.com/guides/models/using-the-store/

<%= application_name.camelize %>.Store = DS.Store.extend({
  Adapter: DS.RESTAdapter.create()
});
