# Basic model of a page, for access to content etc

# Pages are stored in a git, not db

# The Wiki class (in lib) is to us what a db-connection would be to AR-model

class WikiPage

  attr_reader :name , :ext , :oid

  # init from an exising git entry
  def initialize(entry)
    @name , @ext = entry[:name].split(".")
    @oid = entry[:oid]
  end

  def to_param
    @title
  end

  def formatted_data
    WikiPage.wiki.oid_data(self.oid)
  end
  # this is on an existing page, just stuff new content in
  # TODO comit data
  def update_page content , message , commiter
    WikiPage.wiki.update_page(self, content , message,  commiter)
  end

  ## TODO move this stuff into a concern or something
  ## Note: The wiki is to a WikiPage what a db is to a normal model. ie something like a connection

  @@wiki = nil
  # reader for class attribute :wiki
  def self.wiki
    @@wiki || init_wiki
  end
  # The singleton wiki (currently) is instantiated from the after_init in the engine
  # this can definately be improved, but it's a nice low key start
  def self.init_wiki 
    path = Rails.application.config.wiki_path
    @@wiki = GollumRails::Wiki.new(path)
  end
  
end
