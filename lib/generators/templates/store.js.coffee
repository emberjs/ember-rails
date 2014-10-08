# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

<%= application_name.camelize %>.ApplicationStore = DS.Store.extend({

})

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
<%= application_name.camelize %>.ApplicationAdapter = DS.ActiveModelAdapter.extend({

})

# Adds X-CSRF-Token to all REST requests.
# Allows for the use of Rails protect_from_forgery
# The CSRF Token is normally found in app/views/layouts/application.html.*
# inserted with the rails helper: "csrf_meta_tags"
DS.RESTAdapter.reopen(
  headers:
    "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
)
