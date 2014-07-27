<%= application_name.camelize %>.ApplicationStore = DS.Store.extend({

});

// Override the default adapter with the `DS.ActiveModelAdapter` which
// is built to work nicely with the ActiveModel::Serializers gem.
<%= application_name.camelize %>.ApplicationAdapter = DS.ActiveModelAdapter.extend({

});
