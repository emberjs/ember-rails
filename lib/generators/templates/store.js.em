class <%= application_name.camelize %>.ApplicationStore extends DS.Store

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
class <%= application_name.camelize %>.ApplicationAdapter extends DS.ActiveModelAdapter
