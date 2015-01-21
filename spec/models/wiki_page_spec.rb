require 'spec_helper'

describe WikiPage do
  
   it "creates a new page" do
     page = WikiPage.new( :content => "Jep" , :name => "my" , :ext => "md")
     expect(page.content).to eq "Jep"
     expect(page.name).to eq "my"
     expect(page.ext).to eq "md"
   end
   it "saves a new page ok" do
     page = WikiPage.new( :content => "Jep" , :name => "my" , :ext => "md")
     page.save "done"
   end
   it "saves a new page twice" do
     page = WikiPage.new( :content => "Jep" , :name => "jep" , :ext => "md")
     expect(page.save( "done").length).to eq 40
     page.content = "No no"
     page.save "done"
   end
   it "doesnt save without commiter" do
     page = WikiPage.new( :content => "Jep" , :name => "ututu" , :ext => "md")
     expect{ page.save( "done" , {}) }.to raise_error(RuntimeError, /Committer/) 
   end
   it "doesnt save without email" do
     page = WikiPage.new( :content => "Jep" , :name => "ututu" , :ext => "md")
     expect{ page.save( "done" , {:name => "john doe"}) }.to raise_error(RuntimeError, /Committer/) 
   end
   
end
