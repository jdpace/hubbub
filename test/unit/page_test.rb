require 'test_helper'

class PageTest < ActiveSupport::TestCase
  
  should_validate_presence_of :title, :body
  should_act_as_url :title
  
  context 'A Page being created' do
    setup do
      @page = Factory(:page, :body => 'paragraph')
    end
    
    should 'cache the body html' do
      assert_equal '<p>paragraph</p>', @page.body_html
    end
    
    should 'use its url as its param' do
      assert_equal @page.url, @page.to_param
    end
  end
  
  context 'Looking for published pages' do
    setup do
      @unpublished  = Factory(:page, :published => false)
      @published    = Factory(:page, :published => true)
    end
    
    should 'have a named scope for that' do
      assert_equal Page.published.all, Page.find(:all, :conditions => {:published => true})
    end
    
    should 'find the published page' do
      assert_contains Page.published.all, @published
    end
    
    should 'not find the unpublished page' do
      assert_does_not_contain Page.published.all, @unpublished
    end
  end
  
end
