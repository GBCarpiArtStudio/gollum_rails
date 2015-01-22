require 'spec_helper'

describe "Save" do
  
   it "saves a new page ok" do
     page = WikiPage.new( :content => "Jep" , :name => "my" , :ext => "md")
     page.save "done"
   end
   it "saves a new page twice" do
     page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md")
     expect(page.save( "done").length).to eq 40
     page.content = "No no"
     page.save "done"
     page = WikiPage.wiki.find("jep")
     expect(page.content).to eq "No no"
   end
   
end
