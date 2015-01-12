
module GollumRails
  class Engine < ::Rails::Engine
    engine_name "gollum_rails"

    initializer "gollum_rails.assets.precompile" do |app|
#      app.config.assets.precompile += %w(office_clerk.css office_clerk.js)
    end

    # for testing this makes engine factories available
    initializer "model_core.factories", :after => "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
    end

  end
end
