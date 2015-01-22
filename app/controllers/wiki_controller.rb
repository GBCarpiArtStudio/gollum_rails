
class WikiController < ApplicationController

  include GollumRails::Engine.routes.url_helpers

  before_filter :find_page, only: [ :page , :edit , :delete , :rename]

  # GET /pages
  def index
    @pages = WikiPage.wiki.pages
  end

  def create
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
    name = @page.name
    @page.content = params[:content]
    @page.save( params[:message] )
    return redirect_to wiki_page_path(name)
  end

  def delete
    return unless request.post?
    name = @page.name
    @page.delete( params[:message] )
    flash.notice = "Page deleted "
    return redirect_to wiki_root_path
  end

  def rename
    return unless request.post?
    @page.rename( params[:name] , params[:message] )
    flash.notice = "Page renamed "
    return redirect_to wiki_page_path(@page.name)
  end
  def page
  end

  private

  def find_page
    @page = WikiPage.wiki.find(params[:page])
    redirect_to new_wiki_page_path(title: params[:page]), notice: t(:notice_page_does_to_exist) unless @page
  end

end
