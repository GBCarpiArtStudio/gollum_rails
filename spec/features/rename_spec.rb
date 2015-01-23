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
    page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md").save( "done" , a_user)
    visit_path rename_wiki_page_path("jep")
    fill_in("name" , :with => "new_name")
    find(".submit").click
    ensure_path rename_wiki_page_path("jep")
  end

  it "dont rename home" do
    page = WikiPage.wiki.find("Home")
    visit rename_wiki_page_path(page.name)
    ensure_path wiki_page_path("Home")
  end

end
