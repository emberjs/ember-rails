# Avoid conflict ActiveModel::Serializers 0.9.2 with Rails 4.2.0: https://github.com/rails-api/active_model_serializers/pull/759
# TODO Remove this code when it solved.
::ActionController::Serialization.enabled = false
