
class WikiController < ApplicationController

  include GollumRails::Engine.routes.url_helpers

  before_filter :find_page, only: [ :page , :edit]

  # GET /pages
  def index
    @pages = WikiPage.wiki.pages
  end

  def create
    @page = WikiPage.new(params)
    if(@page.name_exists?)
      flash[:error] = "Page name exists, please change #{@page.name}"
      render :edit
      format = :markdown #params[:format].intern
    else
      @page.update_page(params[:message])
      redirect_to wiki_page_path(@page)
    end
  end

  def edit
    return unless request.post?
    name = @page.name
    @page.update_page(params[:content], params[:message] , {})
    return redirect_to wiki_page_path(name)
  end

  def rename
    return unless request.post?
    name = @page.name
    @page.update_content!(params[:content], {})
    return redirect_to wiki_page_path(name)


    wikip = wiki_page(params[:splat].first)
    halt 500 if wikip.nil?
    wiki   = wikip.wiki
    page   = wiki.paged(wikip.name, wikip.path, exact = true)
    rename = params[:rename]
    halt 500 if page.nil?
    halt 500 if rename.nil? or rename.empty?

    # Fixup the rename if it is a relative path
    # In 1.8.7 rename[0] != rename[0..0]
    if rename[0..0] != '/'
      source_dir                = ::File.dirname(page.path)
      source_dir                = '' if source_dir == '.'
      (target_dir, target_name) = ::File.split(rename)
      target_dir                = target_dir == '' ? source_dir : "#{source_dir}/#{target_dir}"
      rename                    = "#{target_dir}/#{target_name}"
    end

    committer = Gollum::Committer.new(wiki, commit_message)
    commit    = { :committer => committer }

    success = wiki.rename_page(page, rename, commit)
    if !success
      # This occurs on NOOPs, for example renaming A => A
      redirect to("/#{page.escaped_url_path}")
      return
    end
    committer.commit

    wikip = wiki_page(rename)
    page  = wiki.paged(wikip.name, wikip.path, exact = true)
    return if page.nil?
    redirect to("/#{page.escaped_url_path}")
  end
  def page
  end

  private

  def find_page
    @page = WikiPage.wiki.find(params[:page])
    redirect_to new_wiki_page_path(title: params[:page]), notice: t(:notice_page_does_to_exist) unless @page
  end

end
