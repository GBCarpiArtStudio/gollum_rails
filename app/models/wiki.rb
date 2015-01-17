# use our own wiki class just so we have a way to extend the gollum-lib stuff

# This is singleton, ie only ever one instance is supported and you can get that instance 
# with the wiki class method

class Wiki < Gollum::Wiki

  # reader for class attribute :wiki
  cattr_reader :wiki

  # The singleton wiki (currently) is instantiated from the after_init in the engine
  # this can definately be improved, but it's a nice low key start
  def self.init_wiki path = Rails.application.config.wiki_path
    path = Rails.root.join(path) if path.starts_with?("/")
    begin
      @@wiki = Gollum::Wiki.new(path)
    rescue Gollum::NoSuchPathError
      puts "No path #{path}"
      raise
    end
    @@wiki
  end

  def self.path
    
  end
  # Find an existing page or create it
  #
  # name - The name
  # commit - Hash
  #
  # Returns self
  def find_or_initialize_by_name(name, commit={})
    result = find(name)
    if result
      result
    else
      WikiPage.new(:format => :markdown, :name => name, :content => ".", :commit => commit)
    end
  end

  # Finds a page based on the name and specified version
  #
  # name - the name of the page
  # version - optional - The pages version
  # exact - optional - perform an exact match
  #
  # Return an instance of Gollum::Page
  def find(name, version=nil, exact=true)
    name = name[:name] if name.kind_of?(Hash) && name.has_key?(:name)
    wiki.clear_cache
    path = File.split(name)
    if path.first == '/' || path.first == '.'
      folder = nil
    else
      folder = path.first
    end
    page = wiki.paged(path.last, folder, exact, version)
    if page
      new(gollum_page: page)
    else
      nil
    end
  end

  # == Searches the wiki for files CONTENT!
  #
  # string - Searchstring
  #
  # Returns an Array
  def search(string)
    wiki.search(string)
  end

  # Gets all pages in the wiki
  #
  # Returns an Array with GollumRails::Page s
  def all(options={})
    set_folder(options)
    pages = wiki.pages
    pages.map do |page|
      self.new(gollum_page: page)
    end
  end

end
