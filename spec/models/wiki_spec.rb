require 'spec_helper'

describe "Wiki" do
  
   it "finds a new page" do
     page = WikiPage.new( :content => "Jep" , :name => "my" , :ext => "md" )
     page.save("go", a_user)
     page = WikiPage.wiki.find("my")
     expect(page.content).to eq "Jep"
     expect(page.name).to eq "my"
     expect(page.ext).to eq "md"
   end

end
