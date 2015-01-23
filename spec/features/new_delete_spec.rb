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
  it "delete new page" do
    page = WikiPage.new( :content => "Always unique" , :name => "go_go" , :ext => "md")
    page.save("come and" ,a_user)
    visit_path delete_wiki_page_path("go_go")
    fill_in("message" , :with => "maintanance")
    find(".submit").click
    ensure_path wiki_root_path
  end

  it "dont delete without message" do
    WikiPage.new( :content => "Always unique" , :name => "go_go" , :ext => "md").save("come and",a_user)
    visit_path delete_wiki_page_path("go_go")
    find(".submit").click
    ensure_path delete_wiki_page_path("go_go")
  end

  it "dont delete home" do
    page = WikiPage.wiki.find("Home")
    visit delete_wiki_page_path(page.name)
    ensure_path wiki_page_path("Home")
  end
end