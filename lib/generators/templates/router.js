<%= application_name.camelize %>.Router = Ember.Router.extend({
  root: Ember.State.extend({
    index: Ember.State.extend({
      route: '/'

      // You'll likely want to connect a view here.
      // connectOutlets: function(router) {
      //   router.get('applicationController').connectOutlet(App.MainView);
      // }

      // Layout your routes here...
    })
  })
});

