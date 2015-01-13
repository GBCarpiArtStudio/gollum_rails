require 'spec_helper'
require 'gollum_rails/path_helpers'

describe GollumRails::PathHelpers do
   it "should return a sanitized path string for an absolute path" do
    expect(GollumRails::PathHelpers.configure_path("/some_wiki.git")) == "/test"
   end

   it "should return a path relative to rails root if trailing character is no slash" do
    expect(GollumRails::PathHelpers.configure_path("some_wiki.git")) == Rails.root.join("some_wiki.git")
   end
end