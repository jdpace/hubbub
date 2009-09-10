require 'test_helper'

class Admin::DashboardsControllerTest < ActionController::TestCase
  should_require_admin :show
end
