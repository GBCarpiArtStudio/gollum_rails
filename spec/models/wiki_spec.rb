require 'spec_helper'

describe Wiki do
   it "init from an relative path" do
    expect(Wiki.init_wiki("./spec/utils/test_wiki.git").path).to eq "./spec/utils/test_wiki.git"
   end

   #TODO, this would need the repo to be created (above exists for testing)
#   it "should init from absolute (to reails root) path" do
#      expect(Wiki.init_wiki("/spec/utils/test_wiki.git").path).to eq Rails.root.join("/spec/utils/test_wiki.git")
#   end
end