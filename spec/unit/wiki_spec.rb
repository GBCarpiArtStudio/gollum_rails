require 'spec_helper'
require 'fileutils'

describe GollumRails::Wiki do
  it "init from a relative path" do
    path = Pathname.new("./spec/utils/test_wiki.git")
    wiki = GollumRails::Wiki.new(path)
    expect(wiki.path) == path
  end
  it "init from a relative string" do
    path = Pathname.new("./spec/utils/test_wiki.git")
    wiki = GollumRails::Wiki.new(path.to_s)
    expect(wiki.path) == path
  end
  it "init non existing path" do
    path = Pathname.new("definately_not_there")
    wiki = GollumRails::Wiki.new(path)
    expect(wiki.path) == path
    FileUtils.rm_r path.to_s
  end
  it "creates a homepage" do
    path = Pathname.new("definately_not_there.git")
    wiki = GollumRails::Wiki.new(path)
    pages = wiki.pages
    expect(pages.length).to be 1
    expect(pages.first.class).to be WikiPage
    expect(pages.first.name).to eq "Home"
    FileUtils.rm_r path.to_s
  end
end