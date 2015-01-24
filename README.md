# GollumRails
[![Build Status](https://travis-ci.org/gollum/gollum_rails.svg)](https://travis-ci.org/gollum/gollum_rails)
[![Code Climate](https://codeclimate.com/github/gollum/gollum_rails/badges/gpa.svg)](https://codeclimate.com/github/gollum/gollum_rails)
[![Test Coverage](https://codeclimate.com/github/gollum/gollum_rails/badges/coverage.svg)](https://codeclimate.com/github/gollum/gollum_rails)

Gollum Rails lets you integrate a git based wiki into your application. It is 
a Ruby on Rails engine that does a subset of what [gollum](https://github.com/gollum/gollum) does.

## Status

This project has just rebooted. The previous version was not an engine, so we are adding controllers and views now.

We are soon going into beta testing with what is believed to be rough but just usable software.

Release of version 2.0 will be about summer.

## Installation

Add `gem 'gollum_rails'` to your **Gemfile** and bundle.

**For macs** GollumRails is using [rugged](https://github.com/libgit2/rugged) and that means you'll need
to install cmake

```bash
$ brew install cmake
```

Add requires to your applications css and js assets, like

```
// file application.css (and also for .js)

//= require "gollum_rails"
```

#### WikiUser

We track all modifications and these require a
[WikiUser](https://github.com/gollum/gollum_rails/blob/master/lib/gollum_rails/wiki_user.rb).

You **must** implement a wiki_user method on your **ApplicatioController**. Something like

```
class ApplicationController < ActionController::Base
...
..
def wiki_user
  if logged_in?
    return GollumRails::WikiUser.new( user_name , user_email , may_edit)
  else
    return nil # may not edit
  end
end

```

## Configure

#### Repository

In application.rb

```
  config.wiki_path = "wiki.git"
```

Is the default, if you want something else, add to application.rb.
If the path does not start with "/" it will be relative to Rails.root

If the repository does not exist, it will be created. If it does exist, it must be bare.
The working directory is not updated (as usual on serevers), but you may clone and push to it from elsewhere.

## Change appearance

GollumRails is a normal engine, as such you can change a lot by standard rails practices and ruby patching.
Sprecifically:

#### Add style or js

If you add your own style definitions for classes that gollum_rails uses, those will be used.

If you redefine and js function, that will take affect.

You can use jquery to target and html in the dom to change it.

#### Redefine template

If you define a template that gollu_rails uses at the same place with the same name, it will be used instead.
So you can easily change the whole of the look. The templates are really easy.

## Contributing

Anything welcome. Bugs, (small) requests, doc improvement. For bigger things talk to me first. 
Threre is no list so you can send mail or open an issue

Things that are planned and you are welcome to help with:

- history
- diffs
- layout
- documentation
- gollum_lib (re)integration

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

## Enjoy

Torsten (@villataik.fi)
