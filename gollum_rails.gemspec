$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gollum_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name              = "gollum_rails"
  s.rubyforge_project = s.name
  s.version           = GollumRails::VERSION
  s.authors           = ["Torsten Ruger , Florian Kasper"]
  s.email             = ["torsten@villataika.fi , mosny@zyg.li"]
  s.homepage          = "https://github.com/dancinglightning/gollum_rails"
  s.summary           = "A simple git based wiki, as a rails engine"
  s.description       = s.summary
  s.license           = "MIT"

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.add_dependency         "rails", "~> 4.0"
  s.add_runtime_dependency "rugged" , "~> 0.21"
  s.add_runtime_dependency "sass-rails" , "~> 5.0"
  s.add_runtime_dependency "haml" , "~> 4.0"
  s.add_runtime_dependency "jquery-rails" , '~> 3.1'
  s.add_runtime_dependency 'coffee-rails' , '~> 4.0'
  s.add_runtime_dependency 'jquery-ui-rails' , '~> 5.0'
  s.add_runtime_dependency 'bootstrap-sass', '~> 3.1'
  s.add_runtime_dependency 'bootstrap_form' , '~> 2.2'
  s.add_runtime_dependency "paperclip" , '~> 4.1'
  s.add_runtime_dependency 'rails-i18n' , '~> 4.0'
  # html pipeline creates output with various filters, here dependents
  s.add_runtime_dependency 'html-pipeline' , '~> 1.0'
  s.add_runtime_dependency 'rinku' , '~> 1.7'
  s.add_runtime_dependency 'sanitize' , '~> 3.0'
  s.add_runtime_dependency 'github-markdown' , '~> 0.6'
end
