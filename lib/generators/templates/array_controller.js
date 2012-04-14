<%= application_name.camelize %>.<%= class_name %>Controller = Ember.ArrayController.extend({
  /**
    You can set the content of the ArrayController to any object that implements 
    Ember.Array. You can bind your views to this controller, then change the array 
    represented by it at any time; your views will update automatically.
  */
  content: null
});

<%= application_name.camelize %>.<%= class_name.camelize(:lower) %>Controller = <%= application_name.camelize %>.<%= class_name %>Controller.create();
