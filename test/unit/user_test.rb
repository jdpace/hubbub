require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject do
    Factory(:user)
  end
  
  should_validate_presence_of :name
end
