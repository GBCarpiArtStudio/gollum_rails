# Our model of a page is derived from the gollum page, from which it inherites it's persistance

# There one more "model", the wiki, but it is a singleton and we use the gollums class as a
# class variable on Page

# TODO, when set up rightly, gollum-lib will instantiate this not it's own Page class. need to pass to wiki


class WikiPage < Gollum::Page
  # this is on an existing page, just stuff new content in
  # TODO comit data
  def update_content! content , commit
    WikiPage.wiki.update_page(self, self.name, self.format, content)
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
  def self.init_wiki path = Rails.application.config.wiki_path
    path = Rails.root.join(path) if path.starts_with?("/")
    begin
      @@wiki = GollumRails::Wiki.new(path)
    rescue Gollum::NoSuchPathError
      puts "No path #{path}"
      raise
    end
    @@wiki
  end
  
end
