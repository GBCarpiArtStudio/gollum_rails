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
  def oid_data(oid)
    @repo.lookup(oid).content
  end
  def pages
    list = []
    @repo.head.target.tree.each_blob { |entry| list << WikiPage.new(entry) }
    list
  end

  def update_page page , content , message , commiter
    oid = @repo.write(content, :blob)
    index = @repo.index
    index.read_tree(@repo.head.target.tree)
    index.add(:path => "#{page.name}.#{page.ext}", :oid => oid, :mode => 0100644)
    options = {}
    options[:tree] = index.write_tree(@repo)
    options[:author] = { :email => "gollum_rails@github.com", :name => 'Gollum Rails' }
    options[:committer] = { :email => "gollum_rails@github.com", :name => 'Gollum Rails' }
    options[:message] ||= message
    options[:parents] = [ @repo.head.target ].compact
    options[:update_ref] = 'HEAD'

    Rugged::Commit.create(@repo, options)
  end
  # Finds a page based on the name 
  #
  # name - the name of the page
  #
  # Return an instance of Gollum::Page
  def find(name)
    @repo.head.target.tree.each_blob do |entry| 
      return WikiPage.new(entry) if entry[:name].starts_with? name
    end
    nil
  end

  private
  def init_homepage
    # add a basic page with the default name (todo configurable, default home)
    return unless @repo.empty?
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
