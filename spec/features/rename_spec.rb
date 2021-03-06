require 'spec_helper'

describe "Rename" do
  
  it "rename a page" do
    page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md").save( "done" , a_user)
    visit_path rename_wiki_page_path("jep")
    fill_in("name" , :with => "new_name")
    fill_in("message" , :with => "renamed")
    find(".submit").click
    ensure_path wiki_page_path("new_name")
  end

  it "need message to rename" do
    page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md")
    page.save("new p" , a_user)
    visit_path rename_wiki_page_path(page)
    fill_in("name" , :with => "new_name")
    find(".submit").click
    ensure_path rename_wiki_page_path(page)
  end

  it "dont rename home" do
    page = WikiPage.wiki.find("Home")
    visit rename_wiki_page_path(page.name)
    ensure_path wiki_page_path(page)
  end

  it "doesnt allow rename for no user" do
    page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md").save( "done" , a_user)
    allow_any_instance_of(ApplicationController).to receive(:wiki_user).and_return(nil)
    visit rename_wiki_page_path(page)
    ensure_path wiki_root_path
  end

end
