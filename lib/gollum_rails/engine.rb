
module GollumRails
  class Engine < ::Rails::Engine
    engine_name "gollum_rails"

    config.i18n.default_locale = :en

    initializer "gollum_rails.assets.precompile" do |app|
      app.config.assets.precompile += %w(gollum_rails.css gollum_rails.js)
    end

    config.after_initialize do
      Wiki.init_wiki
    end
  end
end
