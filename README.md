# GollumRails
[![Build Status](https://travis-ci.org/gollum/gollum_rails.svg)](https://travis-ci.org/gollum/gollum_rails)

Gollum Rails lets you integrate a git based wiki into your application. In other words, Gollum Rails is 
a Ruby on Rails engine that wraps [gollum-lib](https://github.com/gollum/gollum-lib).

## Status

This project has just rebooted. The previous version was not an engine, so we are adding controllers and views now.

ETA: 4-6 months.

**DO not touch this unless you want to participate.**

## Installation

Add `gem 'gollum_rails'` to your **Gemfile** and bundle.

Create a git repository where you want, possibly bare. eg 

```bash
$ mkdir wiki.git
$ cd wiki
$ git init --bare
```

in your application.rb 

```
  config.wiki_path = "wiki.git"
```
if the path does not start with "/" it will be relative to Rails.root

Application controller `current_wiki_user` , aliased or implemented ...
User class ...

## Change appearance

#### Add style or js to ... 

#### Redefine template


## Contributing

### Development

When the repo is checked out you can develop in the root as if it were a normal rails app.
The app used is actually the test_app, but normal files like Gemfile and bin/rails exist in the root.
So
- bundle
- bundle exec rails s
- bundle exec rspec

all work from the root directory.

### Testing

Tests are as always in the **spec** folder. Running them also works in the root directory by bundle exec rspec.

Tests shoud accompany new code and bug fixes. **Rspec should be run before pushing**

### Feedback and Issues

## License

