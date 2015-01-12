
class WikiController < ApplicationController

  include GollumRails::Engine.routes.url_helpers

  before_filter :find_page, only: [ :page ]

  # GET /pages
  def index
    @pages = WikiPage.wiki.pages
  end


  private

end
