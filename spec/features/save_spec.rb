require 'spec_helper'

describe "Rename" do
  
   it "rename a page" do
     page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md")
     expect(page.save( "done").length).to eq 40
     expect(page.rename( "Page_name" , "done").length).to eq 40
     expect(page.name).to eq  "Page_name" 
     page = WikiPage.wiki.find("jep")
     expect(page).to eq nil
     page = WikiPage.wiki.find("Page_name")
     expect(page.content).to eq "Jep"
   end
   
end
