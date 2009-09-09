class ActiveSupport::TestCase
  def self.should_act_as_url(attribute, options = {})
    options[:column] ||= :url
    
    klass = self.name.gsub(/Test$/, '').constantize
    
    context "To support acts_as_url" do
      should_have_db_column("#{options[:column]}", :type => :string)
    
      should "should parse a url from the #{attribute}" do
        record = Factory(klass.name.underscore.to_sym)
        assert_match(/#{record.send(attribute.to_sym).to_url}/, record.send(options[:column].to_sym))
      end  
    end
  end
end