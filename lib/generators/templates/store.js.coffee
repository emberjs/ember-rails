# http://emberjs.com/guides/models/defining-a-store/

<%= application_name.camelize %>.Store = DS.Store.extend
  adapter: DS.RESTAdapter.create()
