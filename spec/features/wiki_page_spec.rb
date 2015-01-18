require 'spec_helper'

describe WikiPage do
   it "creates a new page" do
     visit_path new_wiki_page_path
     fill_in("title" , :with => "page_name1")
     fill_in("content" , :with => "# header")
     find(".submit").click
     expect(find("h1")).to have_content("header")
   end

   #TODO, this would need the repo to be created (above exists for testing)
#   it "should init from absolute (to reails root) path" do
#      expect(WikiPage.init_wiki("/spec/utils/test_wiki.git").path).to eq Rails.root.join("/spec/utils/test_wiki.git")
#   end
end