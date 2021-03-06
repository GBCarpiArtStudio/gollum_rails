# Basic model of a page, for access to content etc

# Pages are stored in a git, not db

# The Wiki class (in lib) is to us what a db-connection would be to AR-model

class WikiPage

  attr_reader :name , :ext , :oid
  attr_accessor :content

  # init from an exising git entry
  def self.init_entry entry
    name , ext = entry[:name].split(".")
    entry[:name] = name
    entry[:ext] = ext
    WikiPage.new entry
  end

  #Initialize from a hash that may have all the attributes set
  def initialize(entry)
    @name = entry[:name]
    @ext = entry[:ext] || :md
    @oid = entry[:oid]
    @content = entry[:content]
  end

  def to_param
    @name
  end

  def content
    return @content unless @content.nil?
    return "" if self.oid.nil?
    WikiPage.wiki.oid_data(self.oid)
  end

  # checks to see if a page by this name is alread in the rep
  def name_exists?
    !WikiPage.wiki.find(self.name).nil?
  end

  # writes the current page data to the git
  # new or old doesn't really matter, git will decide
  def save  message , wiki_user
    WikiPage.wiki.save_page(self, message,  wiki_user)
  end

  def delete  message , wiki_user
    WikiPage.wiki.delete_page(self, message,  wiki_user)
  end

  # rename to the given new name. message and wiki_user like other actions
  def rename( new_name , message ,  wiki_user )
    old_name = @name
    @name = new_name
    sha = WikiPage.wiki.rename_page(self, old_name , message,  wiki_user)
    sha
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
    begin
      wiki_path = Rails.application.config.wiki_path
    rescue
      wiki_path = "wiki.git"
    end
    @@wiki = GollumRails::Wiki.new(wiki_path)
  end

end
