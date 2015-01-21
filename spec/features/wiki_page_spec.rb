require 'spec_helper'

describe WikiPage do
  
   it "creates a new page" do
     visit_path new_wiki_page_path
     fill_in("name" , :with => "page_name1")
     fill_in("content" , :with => "# header")
     find(".submit").click
#markdown disabled for now     expect(find("h1")).to have_content("header")
   end

end

describe "Home" do
   it "shows index" do
     visit_path wiki_root_path
     expect(find(".page_link").text).to eq "Home"
   end

   it "shows home" do
     visit_path wiki_page_path("Home")
     expect(find(".edit_link").text).to eq "Edit"
     expect(find(".rename_link").text).to eq "Rename"
   end
   
   it "shows home in edit mode" do
     visit_path edit_wiki_page_path("Home")
   end
end

describe "edit" do
  it "edits home" do
    visit_path edit_wiki_page_path("Home")
    fill_in("content" , :with => "# edited")
    fill_in("message" , :with => "edited")
    find(".submit").click
    ensure_path wiki_page_path("Home")
  end
end
describe "delete" do
  it "delete home" do
    visit_path delete_wiki_page_path("Home")
    fill_in("message" , :with => "edited")
    find(".submit").click
    ensure_path wiki_root_path
  end
end