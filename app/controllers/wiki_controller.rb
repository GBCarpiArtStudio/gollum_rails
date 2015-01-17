
class WikiController < ApplicationController

  include GollumRails::Engine.routes.url_helpers

  before_filter :find_page, only: [ :page , :edit]

  # GET /pages
  def index
    @pages = Wiki.wiki.pages
  end

  def create
    name   = params[:title]
    format = :markdown #params[:format].intern
    begin
      Wiki.wiki.write_page(name, format, params[:content])
      return redirect_to wiki_page_path(name)
    rescue Gollum::DuplicatePageError => e
      flash.error = "Duplicate page: #{e.message}"
      render :edit
    end
  end

  def edit
    if request.post?
      name = @page.name
      @page.update_content!(params[:content], {})
      return redirect_to wiki_page_path(name)
    end
  end
  def page
  end

  private

  def find_page
    @page = Wiki.wiki.find(params[:page])
    redirect_to new_wiki_page_path(title: params[:page]), notice: t(:notice_page_does_to_exist) unless @page
  end

end
