module AuthlogicMacros
  def should_be_authentic
    klass = model_class
    should "acts as authentic" do
      assert klass.new.respond_to?(:password=)
      assert klass.new.respond_to?(:valid_password?)
    end
  end
end

class Test::Unit::TestCase
  extend AuthlogicMacros
end