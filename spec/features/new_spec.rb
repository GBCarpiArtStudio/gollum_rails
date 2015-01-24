require 'spec_helper'

describe "new page" do
  
   it "creates a new page" do
     visit_path new_wiki_page_path
     fill_in("name" , :with => "page_name1")
     fill_in("content" , :with => "# MYHEADING")
     fill_in("message" , :with => "new page")
     find(".submit").click
     ensure_path wiki_page_path("page_name1")
     expect(find(:xpath , "//h1")).to have_content("MYHEADING")
   end

   it "previews a new page" , :js => true do
     visit_path new_wiki_page_path
     fill_in("content" , :with => "# MYHEADING")
     find(".preview_link").click
     expect(find(:xpath , "//h1")).to have_content("MYHEADING")
   end

   it "does not create a new page when name exists" do
     visit_path new_wiki_page_path
     fill_in("name" , :with => "Home")
     fill_in("content" , :with => "# MYHEADING")
     fill_in("message" , :with => "new page")
     find(".submit").click
     ensure_path new_wiki_page_path
   end

   it "does not create a new page without message" do
     visit_path new_wiki_page_path
     fill_in("name" , :with => "page_name2")
     find(".submit").click
     ensure_path new_wiki_page_path
   end

   it "doesnt allow new for no user" do
     allow_any_instance_of(ApplicationController).to receive(:wiki_user).and_return(nil)
     visit new_wiki_page_path
     ensure_path wiki_root_path
   end
   
end
