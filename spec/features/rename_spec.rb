require 'spec_helper'

describe "Rename" do
  
  it "rename a page" do
    page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md")
    expect(page.save( "done").length).to eq 40
    visit_path rename_wiki_page_path(page.name)
    fill_in("name" , :with => "new_name")
    fill_in("message" , :with => "renamed")
    find(".submit").click
    ensure_path wiki_page_path("new_name")
  end

  it "dont rename home" do
    page = WikiPage.wiki.find("Home")
    visit rename_wiki_page_path(page.name)
    ensure_path wiki_page_path("Home")
  end
   
end
