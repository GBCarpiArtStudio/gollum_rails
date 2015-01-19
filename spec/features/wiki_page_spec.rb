require 'spec_helper'

describe WikiPage do
  
   it "creates a new page" do
     visit_path new_wiki_page_path
     fill_in("name" , :with => "page_name1")
     fill_in("content" , :with => "# header")
     find(".submit").click
#markdown disabled for now     expect(find("h1")).to have_content("header")
   end

   #TODO, this would need the repo to be created (above exists for testing)
#   it "should init from absolute (to reails root) path" do
#      expect(WikiPage.init_wiki("/spec/utils/test_wiki.git").path).to eq Rails.root.join("/spec/utils/test_wiki.git")
#   end
end

describe "Home" do
   it "shows index" do
     visit_path wiki_root_path
     expect(find(".page_link").text).to eq "Home"
     
#     fill_in("name" , :with => "page_name1")
#     fill_in("content" , :with => "# header")
#     find(".submit").click
   end
  
end