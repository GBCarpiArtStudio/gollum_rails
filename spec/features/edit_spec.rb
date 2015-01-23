require 'spec_helper'

describe "edit" do
  it "edits home" do
    visit_path edit_wiki_page_path("Home")
    fill_in("content" , :with => "# edited")
    fill_in("message" , :with => "edited")
    find(".submit").click
    ensure_path wiki_page_path("Home")
  end

  it "need message to edit" do
    visit_path edit_wiki_page_path("Home")
    fill_in("content" , :with => "# edited")
    find(".submit").click
    ensure_path edit_wiki_page_path("Home")
  end

  it "edits new page" do
    page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md")
    expect(page.save( "done" , a_user).length).to eq 40
    visit_path edit_wiki_page_path(page.name)
    fill_in("content" , :with => "some funky new stuff")
    fill_in("message" , :with => "edited")
    find(".submit").click
    ensure_path wiki_page_path(page.name)
  end

  it "doesnt allow edit for no user" do
    allow_any_instance_of(ApplicationController).to receive(:wiki_user).and_return(nil)
    visit edit_wiki_page_path("Home")
    ensure_path wiki_root_path
  end
end
