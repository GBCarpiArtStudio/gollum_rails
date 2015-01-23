# use our own wiki class just so we have a way to extend the gollum-lib stuff

# This is singleton, ie only ever one instance is supported and you can get that instance 
# with the wiki class method

class GollumRails::Wiki

  # take a Pathname to the directory
  def initialize path
    path = Pathname.new(path) if path.is_a? String
    path = Rails.root.join(path) unless path.to_s.starts_with?("/")
    if( path.exist? )
      raise "Path is not directory #{path}"  unless path.directory?
      @repo = Rugged::Repository.new(path.to_s)
      raise "Repository is not bare, see readme" unless @repo.bare?
    else
      # create a bare repository
      @repo = Rugged::Repository.init_at(path.to_s, :bare)
    end
    @path = path
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
  
  def pages contains = ""
    list = []
    @repo.head.target.tree.each_blob do |entry| 
      list << WikiPage.init_entry(entry) if entry[:name].include?(contains)
    end
    list
  end

  def save_page page , message , committer
    commit(committer , message) do |index|
      oid = @repo.write(page.content, :blob)
      index.add(:path => "#{page.name}.#{page.ext}", :oid => oid, :mode => 0100644)
    end
  end

  def delete_page page , message , committer = { :email => "gollum_rails@github.com", :name => 'Gollum Rails' }
    commit(committer , message) do |index|
      index.remove_all( "#{page.name}.#{page.ext}")
    end
  end

  # rename is (git style) an add and remove.
  def rename_page page , old_name , message , committer = { :email => "gollum_rails@github.com", :name => 'Gollum Rails' }
    commit(committer , message) do |index|
      index.remove_all( "#{old_name}.#{page.ext}")
      oid = @repo.write(page.content, :blob)
      index.add(:path => "#{page.name}.#{page.ext}", :oid => oid, :mode => 0100644)
    end
  end

  # Finds a page based on the name 
  #
  # name - the name of the page
  #
  # Return an instance of Gollum::Page
  def find(name)
    @repo.head.target.tree.each_blob do |entry| 
      return WikiPage.init_entry(entry) if entry[:name].starts_with? name
    end
    nil
  end

  private
  def init_homepage
    # add a basic page with the default name (todo configurable, default home)
    return unless @repo.empty?
    home = WikiPage.new( :name => "Home" , :ext => "md" , :content => "Your first wiki page")
    save_page( home , "Homepage created" , GollumRails::WikiUser.new("Wiki" , "wiki@domain.com") )
  end

  # common commit code for all add,remove, rename actions
  # yields to caller with the index to let the code do what it needs
  def commit( committer , message)
    raise "Committer name may not be empty" unless committer.name
    raise "Committer email may not be empty" unless committer.email
    index = @repo.index
    index.read_tree(@repo.head.target.tree) unless @repo.head_unborn?
    yield index
    options = {}
    options[:tree] = index.write_tree(@repo)
    options[:author] = {:name => committer.name , :email => committer.email}
    options[:committer] = {:name => committer.name , :email => committer.email}
    options[:message] = message.nil? ? "" : message
    options[:parents] = @repo.empty? ? [] : [ @repo.head.target ].compact
    options[:update_ref] = "HEAD"
    Rugged::Commit.create(@repo, options)
  end
end
