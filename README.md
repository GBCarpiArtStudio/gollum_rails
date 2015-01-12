# GollumRails

Gollumn rails lets you integrate a git based wiki into your application. In other words, GollumRail is 
a rails engine that wraps gollum-lib.

## Status

This project has just rebooted. The previous version was not an engine, so we are adding controllers and views now.
ETA: 2-4 months.

## Installation

Add gem 'gollum_rails' to your **Gemfile** and bundle

Create a git repository where you want, possibly bare. eg 

```bash
$ mkdir wiki
$ cd wiki
$ git init --bare
```

in your application.rb 

```
  config.wiki_path = "wiki"
```
if the path does not start with "/" it will be relative to Rails.root

Application controller current_wiki_user , aliased or implemented ...
User class ...

## Change appearance

#### Add style or js to ... 

#### Redefine template


## Contributing

### Testing

### Feedback and Issues

## License

