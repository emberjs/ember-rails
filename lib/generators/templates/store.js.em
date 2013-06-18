# http://emberjs.com/guides/models/using-the-store/

class <%= application_name.camelize %>.Store extends DS.Store
  # Override the default adapter with the `DS.ActiveModelAdapter` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  adapter: '_ams'

