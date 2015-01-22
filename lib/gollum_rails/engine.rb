module GollumRails
  class Engine < ::Rails::Engine
    engine_name "gollum_rails"

    config.i18n.default_locale = :en
    config.autoload_paths += %W(#{config.root}/lib)

    initializer "gollum_rails.assets.precompile" do |app|
      app.config.assets.precompile += %w(gollum_rails.css gollum_rails.js *.png *.jpg *.jpeg *.gif)
    end

    config.after_initialize do
      WikiPage.init_wiki
    end
  end
end
