# GollumRails
[![Build Status](https://travis-ci.org/gollum/gollum_rails.svg)](https://travis-ci.org/gollum/gollum_rails)
[![Code Climate](https://codeclimate.com/github/gollum/gollum_rails/badges/gpa.svg)](https://codeclimate.com/github/gollum/gollum_rails)
[![Test Coverage](https://codeclimate.com/github/gollum/gollum_rails/badges/coverage.svg)](https://codeclimate.com/github/gollum/gollum_rails)

Gollum Rails lets you integrate a git based wiki into your application. It is
a Ruby on Rails *engine* that does a subset of what [gollum](https://github.com/gollum/gollum) does.

## Status

This project has just rebooted. The previous version was not an engine, so i have added controllers and views now.

We are soon going into beta testing with what is believed to be rough but just usable software.

Release of version 2.0 will be about summer.

## Engine

(skip this if you know what an engine is)

A Rails **engine** is in most respect like an application, but is meant to be used by an application rather than being standalone.
Specifically it may have any of the following: models, controllers,views, assets, and migrations.

GollumRails is Git based, so while it has a model (the page) it does not have migrations. It does have views and controllers to provide a wiki.

The way an engine is used inside an application is by "mounting" it to a specific path in the router. The engine then handles all urls under that path.

## Installation

### Add the gem

Add

`gem 'gollum_rails' , :github => "gollum/gollum_rails.git"`

to your **Gemfile** and bundle.

**For macs** GollumRails is currently using [rugged](https://github.com/libgit2/rugged) and that means you'll need
to install cmake

```bash
$ brew install cmake
```

### Add the assets

Add requires to your applications css and js assets, like

```
// file application.css (and also for .js)

//= require "gollum_rails"
```

#### WikiUser

We track all modifications and these require a
[WikiUser](https://github.com/gollum/gollum_rails/blob/master/lib/gollum_rails/wiki_user.rb).

You **must** implement a wiki_user method on your **ApplicationController**. Something like

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

### Mount the engine

In rour contig/routes.rb include something like:

```
Rails.application.routes.draw do
  mount GollumRails::Engine => "/wiki"
end
```
After that you should be able to start your server and go to /wiki and start creating pages.


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

## A short note on History

GollumRails was started by [Florian](https://github.com/nirnanaaa/gollum_rails) and used company internally. [I](https://github.com/dancinglightning) approached him to make an engine out of his code and he responded enthusuastically and initiated the rewrite. Unfortunately his bosses were not so taken and cancelled his participation, after which i was left to do much more work than anticipated.
To get stared quickly i implemented the git layer as quickly as possible, which means that gollum-lib is not actually used at the moment, but rugged instead.
The actual git layer is very small but may be replaced by the much larger gollum-lib if somebody steps forward to do so.
