require 'spec_helper'

# this describes functions of the wiki, not specific pages (Home is autogenerated and part of wiki)

describe "Home" do
   it "shows index" do
     visit_path wiki_root_path
     expect(find(".page_link").text).to eq "Home"
     expect(all(".page_link").length).to eq 1
   end

   it "shows home" do
     visit_path wiki_page_path("Home")
     expect(find(".edit_link").text).to eq "Edit"
     expect(find(".rename_link").text).to eq "Rename"
   end   
end

describe "List" do
  before(:all) {    WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md").save("go") }
  it "shows only list" do
    visit_path wiki_list_path("Home")
    expect(find(".page_link").text).to eq "Home"
    expect(all(".page_link").length).to eq 1
  end

  it "shows index with both pages" do
    visit_path wiki_root_path
    expect(all(".page_link").length).to eq 2
  end

end

