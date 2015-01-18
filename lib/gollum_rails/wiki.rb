# use our own wiki class just so we have a way to extend the gollum-lib stuff

# This is singleton, ie only ever one instance is supported and you can get that instance 
# with the wiki class method

class GollumRails::Wiki

  # take a Pathname to the directory
  def initialize path
    path = Pathname.new(path) if path.is_a? String
    @path = Rails.root.join(path) unless path.to_s.starts_with?("/")
    if( path.exist? )
      raise "Path is not directory #{path}"  unless path.directory?
      @repo = Rugged::Repository.new(path.to_s)
    else
      if( path.extname == ".git" ) # create a bare repository
        @repo = Rugged::Repository.init_at(path.to_s, :bare)
      else
        @repo = Rugged::Repository.init_at(path.to_s)
      end
    end
    init_homepage
  end

  # give the directory of the git as a Pathname
  # this is not from the repo, but from the init
  # as somehow the paths that come back are relative to pwd,
  # and we want relative to rails.root 
  def path
    @path
  end

  def pages
    list = []
    @repo.head.target.tree.each_blob { |entry| list << WikiPage.new(entry) }
    list
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
  #
  # Return an instance of Gollum::Page
  def find(name, version=nil)
    paged(name)
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

  private
  def init_homepage
    # add a basic page with the default name (todo configurable, default home)
    return unless @repo.empty?
    # NOTE this is the long way, as the short way involves repo.head which does not exist yet
    # Improvements welcome
    oid = @repo.write("Your first wiki page", :blob)
    builder = Rugged::Tree::Builder.new
    builder << { :type => :blob, :name => "Home.md", :oid => oid, :filemode => 0100644 }
    options = {}
    options[:tree] = builder.write(@repo)
    options[:author] = { :email => "gollum_rails@github.com", :name => 'Gollum Rails', :time => Time.now }
    options[:committer] = { :email => "gollum_rails@github.com", :name => 'Gollum Rails', :time => Time.now }
    options[:message] ||= "Homepage created"
    options[:parents] = []
    options[:update_ref] = 'HEAD'
    Rugged::Commit.create(@repo, options)
  end
end
