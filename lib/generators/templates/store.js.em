class <%= application_name.camelize %>.ApplicationStore extends DS.Store

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
class <%= application_name.camelize %>.ApplicationAdapter extends DS.ActiveModelAdapter

# Adds X-CSRF-Token to all REST requests.
# Allows for the use of Rails protect_from_forgery
# The CSRF Token is normally found in app/views/layouts/application.html.*
# inserted with the rails helper: "csrf_meta_tags"
DS.RESTAdapter.reopen(
  headers:
    "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
)
