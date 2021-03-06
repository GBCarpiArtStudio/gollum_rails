require 'spec_helper'

describe WikiPage do
  
   it "creates a new page" do
     page = WikiPage.new( :content => "Jep" , :name => "created" , :ext => "md")
     expect(page.content).to eq "Jep"
     expect(page.name).to eq "created"
     expect(page.ext).to eq "md"
   end

   it "saves a new page" do
     page = WikiPage.new( :content => "More content" , :name => "some_page" , :ext => "md")
     page.save( "save me" , a_user)
     page = WikiPage.wiki.find("some_page")
     expect(page.content).to eq "More content"
     expect(page.name).to eq "some_page"
     expect(page.ext).to eq "md"
   end

   it "doesnt save without wiki_user" do
     page = WikiPage.new( :content => "Jep" , :name => "ututu" , :ext => "md")
     expect{ page.save( "done" , a_user(nil,nil)) }.to raise_error(RuntimeError, /Committer/) 
   end
   it "doesnt save without email" do
     page = WikiPage.new( :content => "Jep" , :name => "ututu" , :ext => "md")
     expect{ page.save( "done" , a_user( "john doe" , nil)) }.to raise_error(RuntimeError, /Committer/) 
   end

   it "deletes a page" do
     page = WikiPage.new( :content => "Always unique" , :name => "go_go" , :ext => "md")
     page.save("come and" , a_user)
     page.delete("go away" , a_user)
     page = WikiPage.wiki.find("go_go")
     expect(page).to eq nil
   end

   it "renames a page" do
     page = WikiPage.new( :content => "More unique" , :name => "ho_ho" , :ext => "md")
     page.save("come here" , a_user)
     page.rename("ro_ro" , "and go there" , a_user)
     page = WikiPage.wiki.find("ho_ho")
     expect(page).to eq nil
     page = WikiPage.wiki.find("ro_ro")
     expect(page.content).to eq "More unique"
   end

end
