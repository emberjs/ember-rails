# http://emberjs.com/guides/models/defining-a-store/

class <%= application_name.camelize %>.Store extends DS.Store
  revision: 11
  adapter: DS.RESTAdapter.create()

