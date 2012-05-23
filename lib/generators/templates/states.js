<%= application_name.camelize %>.StateManager = Ember.Router.extend({
  initialState: 'bootstrap',

  states: {
    bootstrap: Ember.State.extend({
      ready: function(manager) {
        // put your bootstrap logic here
        var store = DS.Store.create({
          adapter: DS.RESTAdapter.create(),
          revision: 4
        });

        manager.set('store', store);
      }
    })
  }
});

