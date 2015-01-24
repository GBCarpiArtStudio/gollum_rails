source "https://rubygems.org"

# gemspec declares only runtime dependencies
gemspec

# here we define test and development dependencies

gem 'sqlite3'

#asset / production related

gem "therubyracer" 
gem "libv8" , "3.16.14.3"
gem "rb-readline"
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'better_errors' , :platforms=>[:mri_20, :mri_21, :rbx]
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :mri_21,:rbx]
  gem 'quiet_assets' , :platforms=>[ :mri_20, :mri_21,:rbx]
  gem "i18n-tasks"
  gem "codeclimate-test-reporter"
end

group :test do
  gem "poltergeist"
  gem 'rspec-rails'
  gem 'capybara'
  gem "factory_girl_rails"
  gem 'i18n-spec'
  gem 'guard-rails'
  gem 'guard-rspec'
end
