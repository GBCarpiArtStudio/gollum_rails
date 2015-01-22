require 'spec_helper'

describe "Rename" do
  
  it "saves a new page twice" do
    page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md")
    expect(page.save( "done").length).to eq 40
    visit_path rename_wiki_page_path(page.name)
    fill_in("name" , :with => "new_name")
    fill_in("message" , :with => "renamed")
    find(".submit").click
    ensure_path wiki_page_path("new_name")
  end
   
end
