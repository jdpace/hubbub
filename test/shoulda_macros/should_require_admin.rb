module ShouldRequireAdminMacro
  def default_controller_actions
    {
      :index    => :get,
      :show     => :get,
      :new      => :get,
      :edit     => :get,
      :create   => :post,
      :update   => :put,
      :destroy  => :delete
    }
  end
  
  def should_require_admin(*actions)
    extra_actions = actions.last.instance_of?(Hash) ? actions.pop : {}
    
    params = {:id => 1}
    params.merge!(extra_actions.delete(:params)) if extra_actions[:params]
    
    default_actions = default_controller_actions.merge(extra_actions)
    
    actions = default_actions.reject {|key, value| !actions.include?(key) }
    
    context 'Dealing with authorization' do
      setup do
        activate_authlogic
        @regular_user = Factory(:user)
      end
      
      actions.each do |action, method|
        context "#{method.to_s.upcase} action /#{action.to_s}" do
          context 'when logged in as a regular user' do
            setup do
              login_as @regular_user
              eval "#{method.to_s} action, params"
            end
            should_set_the_flash_to(/not authorized/)
            should_redirect_to("the login_path") { login_path }
          end
        end
      end
    end # END Dealing with authorization
  end
end

class ActiveSupport::TestCase
  extend ShouldRequireAdminMacro
end