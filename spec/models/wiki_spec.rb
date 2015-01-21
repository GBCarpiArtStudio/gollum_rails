require 'spec_helper'

describe "Wiki" do
  
   it "finds a new page" do
     page = WikiPage.new( :content => "Jep" , :name => "my" , :ext => "md")
     page.save("go")
     page = WikiPage.wiki.find("my")
     expect(page.content).to eq "Jep"
     expect(page.name).to eq "my"
     expect(page.ext).to eq "md"
   end

   it "deletes a page" do
     page = WikiPage.new( :content => "Jep" , :name => "go_go" , :ext => "md")
     page.save("come and")
     page.delete("go away")
     page = WikiPage.wiki.find("go_go")
     expect(page).to eq nil
   end

end
