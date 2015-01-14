# Our model of a page is derived from the gollum page, from which it inherites it's persistance

# There one more "model", the wiki, but it is a singleton and we use the gollums class as a
# class variable on Page

# TODO, when set up rightly, gollum-lib will instantiate this not it's own Page class. need to pass to wiki
require 'gollum_rails/path_helpers'
class WikiPage < Gollum::Page
  include GollumRails::PathHelpers

  # reader for class attribute :wiki
  cattr_reader :wiki

  # The singleton wiki (currently) is instantiated from the after_init in the engine
  # this can definately be improved, but it's a nice low key start
  def self.init_wiki
    @@wiki = Gollum::Wiki.new(GollumRails::PathHelpers.configure_path(Rails.application.config.wiki_path))
  end



  
end
