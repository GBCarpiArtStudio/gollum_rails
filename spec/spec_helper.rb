require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RAILS_ENV"] = 'test'

require File.expand_path("../../test_app/config/environment",  __FILE__)

Rails.backtrace_cleaner.remove_silencers!
require 'rspec/rails'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include GollumRails::Engine.routes.url_helpers

  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.order = "random"

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

end