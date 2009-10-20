require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  context 'A Comment' do
    should_belong_to :post
    should_belong_to :user
    
    should_validate_presence_of :post, :body
  end
  
  context 'A Comment from an annonymous user' do
    setup do
      @comment = Factory.build(:comment, :user => nil)
    end
    
    context 'without any author info provided' do
      setup do
        @comment.author_name  = nil
        @comment.author_email = nil
        @comment.valid? 
      end
      
      should 'have an error on author name' do
        assert_match /can't be blank/, @comment.errors.on(:author_name)
      end
      
      should 'have an error on author email' do
        assert_match /can't be blank/, @comment.errors.on(:author_email)
      end
    end
    
    context 'with a bad email address' do
      setup do
        @comment.author_email = 'bad internets'
        @comment.valid?
      end
      
      should 'have an error on author email' do
        assert_match /must be a valid email address/, @comment.errors.on(:author_email)
      end
    end
    
    context 'with correct author info' do
      setup do
        @comment.author_name  = 'John Doe'
        @comment.author_email = 'jdoe@example.com'
      end
      should 'be valid' do
        assert @comment.valid?
      end
    end
  end
  
end
