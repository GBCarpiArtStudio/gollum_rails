require 'spec_helper'

describe "new page" do
  
   it "creates a new page" do
     visit_path new_wiki_page_path
     fill_in("name" , :with => "page_name1")
     fill_in("content" , :with => "# header")
     find(".submit").click
#markdown disabled for now     expect(find("h1")).to have_content("header")
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