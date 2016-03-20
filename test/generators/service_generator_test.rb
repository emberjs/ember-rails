require 'test_helper'
require 'generators/ember/service_generator'

class ServiceGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ServiceGenerator

  destination File.join(Rails.root, "tmp", "generator_test_output")
  setup :prepare_destination

  def copy_directory(dir)
    source = Rails.root.join(dir)
    dest = Rails.root.join("tmp", "generator_test_output", File.dirname(dir))

    FileUtils.mkdir_p dest
    FileUtils.cp_r source, dest
  end

  def prepare_destination
    super

    copy_directory "app/assets/javascripts"
    copy_directory "config"
  end

  %w(js coffee em es6).each do |engine|

    test "create service with #{engine} engine" do
      run_generator ["session","--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/services/session.#{engine_to_extension(engine)}"
    end

    test "create namespaced service with #{engine} engine" do
      run_generator ["user/session","--javascript-engine=#{engine}"]
      assert_file "#{ember_path}/services/user/session.#{engine_to_extension(engine)}", /UserSessionService|export default Ember\.Service\.extend/
    end
  end

  test "Assert files are properly created" do
    run_generator %w(session)
    assert_file "#{ember_path}/services/session.js"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "session", "-d", custom_path ]
    assert_file "#{custom_path}/services/session.js"
  end

  test "Assert files are properly created with custom app name" do
    run_generator [ "session", "-n", "MyApp" ]
    assert_file "#{ember_path}/services/session.js", /MyApp\.SessionService/
  end

  test "Uses config.ember.app_name as the app name" do
    begin
      old, ::Rails.configuration.ember.app_name = ::Rails.configuration.ember.app_name, 'MyApp'

      run_generator %w(session)
      assert_file "#{ember_path}/services/session.js", /MyApp\.SessionService/
    ensure
      ::Rails.configuration.ember.app_name = old
    end
  end

  private

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end

  def engine_to_extension(engine)
    engine = "module.#{engine}" if engine == 'es6'
    engine
  end

end
