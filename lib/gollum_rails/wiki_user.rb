# simple user class that can be used to pass reuired information to the wiki

# - name
# - email
# - may_edit (default to true)

# The ApplicationController.wiki_user function should return a user like this

# it may off course return anything that responds to those three methods, or use this class


class GollumRails::WikiUser

  attr_accessor :name , :email , :may_edit

  # initialize with name,email and may_edit
  def initialize name , email , may_edit = true
    @name = name
    @email = email
    @may_edit = may_edit
  end

end
