require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  subject do
    Factory(:site)
  end

  should_validate_presence_of :name, :url, :meetup_group_id
  should_have_permalink :name
end
