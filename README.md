# GollumRails
[![Build Status](https://travis-ci.org/gollum/gollum_rails.svg)](https://travis-ci.org/gollum/gollum_rails)

Gollum Rails lets you integrate a git based wiki into your application. It is 
a Ruby on Rails engine that wraps that does a subset of what [gollum](https://github.com/gollum/gollum) does.

## Status

This project has just rebooted. The previous version was not an engine, so we are adding controllers and views now.

ETA: 4-6 months.

**DO not touch this unless you want to participate.**

## Installation

**For macs** GollumRails is using [rugged](https://github.com/libgit2/rugged) and that means you'll need
to install cmake

```bash
$ brew install cmake
```

Add `gem 'gollum_rails'` to your **Gemfile** and bundle.

## Configure

#### Repository
```
  config.wiki_path = "wiki.git"
```

Is the default, if you want something else, add to application.rb.
If the path does not start with "/" it will be relative to Rails.root

If the repository does not exist, it will be created. If it does exist, it must be bare.
The working directory is not updated (as usual on serevers), but you may clone and push to it from elsewhere.

#### Commit data

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

