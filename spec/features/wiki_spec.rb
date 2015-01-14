require 'spec_helper'

# this describes "singleton" actions, ie actions on the wiki, not specific pages

describe "Wiki"  do
  it "lists pages" do
    visit_path wiki_root_path
  end
end