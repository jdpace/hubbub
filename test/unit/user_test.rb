require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject do
    Factory(:user)
  end
  
  should_be_authentic
  should_validate_presence_of :name
  
  should_have_many :blog_posts
end
