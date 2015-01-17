# Our model of a page is derived from the gollum page, from which it inherites it's persistance

# There one more "model", the wiki, but it is a singleton and we use the gollums class as a
# class variable on Page

# TODO, when set up rightly, gollum-lib will instantiate this not it's own Page class. need to pass to wiki


class WikiPage < Gollum::Page

  # this is on an existing page, just stuff new content in
  # TODO comit data
  def update_content! content , commit
    Wiki.wiki.update_page(self, self.name, self.format, content)
  end
end
