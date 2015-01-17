
class WikiController < ApplicationController

  include GollumRails::Engine.routes.url_helpers

  before_filter :find_page, only: [ :page ]

  # GET /pages
  def index
    @pages = Wiki.wiki.pages
  end

  def create
    title = params[:title]

    

    
  end
  def page
  end

  private

  def find_page
    @page = WikiPage.find(params[:page])
    redirect_to new_page_path(title: params[:page]), notice: t(:notice_page_does_to_exist) unless @page
  end

end
