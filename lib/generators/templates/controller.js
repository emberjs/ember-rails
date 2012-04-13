<%= application_name.camelize %>.<%= class_name %>Controller = Ember.<%= options.array? ? "ArrayController" : "Object" %>.extend({
	// Implement your controller here.
});

<%= application_name.camelize %>.<%= class_name.camelize(:lower) %>Controller = <%= application_name.camelize %>.<%= class_name %>Controller.create();