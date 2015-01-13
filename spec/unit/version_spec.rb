require 'spec_helper'
require 'gollum_rails/version'

describe GollumRails::VERSION do
  it "should have version 0.0.1" do
    expect(GollumRails::VERSION).to match "0.0.1"
  end
end