module WikiUserHelper
  def a_user name = "John" , email = "john@doe.it" , may_edit = true
    GollumRails::WikiUser.new name , email , may_edit
  end
end

RSpec.configure do |config|
  config.include WikiUserHelper
end
