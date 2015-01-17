$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gollum_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name              = "gollum_rails"
  s.rubyforge_project = s.name
  s.version           = GollumRails::VERSION
  s.authors           = ["Florian Kasper, Torsten Ruger"]
  s.email             = ["mosny@zyg.li , torsten@villataika.fi"]
  s.homepage          = "https://github.com/gollum/gollum_rails"
  s.summary           = "Gollum Rails is a rails engine that embeds the gollum-lib, git based wiki, into your app."
  s.description       = s.summary
  s.license           = "MIT"

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.add_dependency         "rails", "~> 4.1.9"
  s.add_dependency         "gollum-lib", "~> 4.0.1"
  s.add_dependency         'github-markdown', '~> 0.6.5'
  s.add_runtime_dependency "sass-rails" , "~> 4.0"
  s.add_runtime_dependency "haml" , "~> 4.0"
  s.add_runtime_dependency "jquery-rails" , '~> 3.1'
  s.add_runtime_dependency 'coffee-rails' , '~> 4.0'
  s.add_runtime_dependency 'jquery-ui-rails' , '~> 5.0'
  s.add_runtime_dependency 'bootstrap-sass', '~> 3.1'
  s.add_runtime_dependency 'bootstrap_form' , '~> 2.2'
  s.add_runtime_dependency "paperclip" , '~> 4.1'
  s.add_runtime_dependency 'rails-i18n' , '~> 4.0'
end
