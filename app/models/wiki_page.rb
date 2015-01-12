# Our model of a page is derived from the gollum page, from which it inherites it's persistance

# There one more "model", the wiki, but it is a singleton and we use the gollums class as a
# class variable on Page

# TODO, when set up rightly, gollum-lib will instantiate this not it's own Page class. need to pass to wiki

class WikiPage < Gollum::Page

  # The singleton wiki (currently) is instantiated from the after_init in the engine
  # this can definately be improved, but it's a nice low key start
  def self.init_wiki
    @wiki = Gollum::Wiki.new(Rails.application.config.wiki_path)
  end

  # TODO forgot the syntax for class attribute
  def self.wiki
    @wiki
  end
  
end
