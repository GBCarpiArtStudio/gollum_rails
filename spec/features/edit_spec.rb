require 'spec_helper'

describe "edit" do
  it "edits home" do
    visit_path edit_wiki_page_path("Home")
    fill_in("content" , :with => "# edited")
    fill_in("message" , :with => "edited")
    find(".submit").click
    ensure_path wiki_page_path("Home")
  end

  it "edits new page" do
    page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md")
    expect(page.save( "done").length).to eq 40
    visit_path edit_wiki_page_path(page.name)
    fill_in("content" , :with => "some funky new stuff")
    fill_in("message" , :with => "edited")
    find(".submit").click
    ensure_path wiki_page_path(page.name)
  end

end
