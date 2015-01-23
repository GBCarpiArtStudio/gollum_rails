class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def wiki_user
    GollumRails::WikiUser.new( "John" , "john@doeinc.com" )
  end
end
