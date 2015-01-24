require 'spec_helper'

describe "delete" do
  it "delete new page" do
    page = WikiPage.new( :content => "Always unique" , :name => "go_go" , :ext => "md")
    page.save("come and" ,a_user)
    visit_path delete_wiki_page_path(page)
    fill_in("message" , :with => "maintanance")
    find(".submit").click
    ensure_path wiki_root_path
  end

  it "dont delete without message" do
    page = WikiPage.new( :content => "Always unique" , :name => "go_go" , :ext => "md")
    page.save("come and",a_user)
    visit_path delete_wiki_page_path(page)
    find(".submit").click
    ensure_path delete_wiki_page_path(page)
  end

  it "dont delete home" do
    page = WikiPage.wiki.find("Home")
    visit delete_wiki_page_path(page.name)
    ensure_path wiki_page_path(page)
  end
end