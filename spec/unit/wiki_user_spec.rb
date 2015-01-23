require 'spec_helper'
require 'fileutils'

describe GollumRails::WikiUser do
  it "returns values given" do
    user = GollumRails::WikiUser.new( "John" , "john@doeinc.com" , false)
    expect(user.name).to eq "John"
    expect(user.email).to eq "john@doeinc.com"
    expect(user.may_edit).to eq false
  end
  it "defaults editable to true" do
    user = GollumRails::WikiUser.new( "John" , "john@doeinc.com" )
    expect(user.may_edit).to eq true
  end
end