require 'spec_helper'

describe "edit" do
  it "edits home" do
    visit_path edit_wiki_page_path("Home")
    fill_in("content" , :with => "# edited")
    fill_in("message" , :with => "edited")
    find(".submit").click
    ensure_path wiki_page_path("Home")
  end
end
