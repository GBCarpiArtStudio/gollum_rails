require 'spec_helper'

describe WikiPage do
  
   it "creates a new page" do
     page = WikiPage.new( :content => "Jep" , :name => "my" , :ext => "md")
     expect(page.content).to eq "Jep"
     expect(page.name).to eq "my"
     expect(page.ext).to eq "md"
   end

   it "deletes a page" do
     page = WikiPage.new( :content => "Goner" , :name => "my" , :ext => "md")
     page.delete("gone")
   end

end
