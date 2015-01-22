
class WikiController < ApplicationController

  include GollumRails::Engine.routes.url_helpers

  before_filter :find_page, only: [ :page , :edit , :delete , :rename]

  # GET all pages, unpaginated, useful only for small wikis
  def index
    @pages = WikiPage.wiki.pages
  end

  # return a list of pages that contain the "str" from /wiki/list/str
  def list
    @pages = WikiPage.wiki.pages( params[:str] )
    render :list , :layout => false
  end

  def new_page
    return unless request.post?
    return if needs_message
    @page = WikiPage.new(params)
    if(@page.name_exists?)
      flash[:error] = "Page name exists, please change #{@page.name}"
      render :edit
    else
      @page.save(params[:message])
      redirect_to wiki_page_path(@page)
    end
  end

  def edit
    return unless request.post?
    return if needs_message
    @page.content = params[:content]
    @page.save( params[:message] )
    return redirect_to wiki_page_path(@page.name)
  end

  def delete
    return redirect_to wiki_page_path("Home") if @page.name == "Home"
    return unless request.post?
    return if needs_message
    name = @page.name
    @page.delete( params[:message] )
    flash.notice = "Page deleted "
    return redirect_to wiki_root_path
  end

  def rename
    return redirect_to wiki_page_path("Home") if @page.name == "Home"
    return unless request.post?
    return if needs_message
    @page.rename( params[:name] , params[:message] )
    flash.notice = "Page renamed "
    return redirect_to wiki_page_path(@page.name)
  end

  private

  def needs_message
    if params[:message].blank?
      flash.notice = "message must be given"
      return true
    else
      return false
    end
  end
  def find_page
    @page = WikiPage.wiki.find(params[:page])
    redirect_to new_wiki_page_path(:name => params[:page]), notice: t(:notice_page_does_to_exist) unless @page
  end

end
