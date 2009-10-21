class Comment < ActiveRecord::Base
  
  belongs_to :post
  belongs_to :user
  
  validates_presence_of :post, :body
  validates_presence_of :author_name, :author_email, :unless => :user
  validates_format_of   :author_email, :if => :author_email, :with => Authlogic::Regex.email,
    :message => 'must be a valid email address'
    
  def author_name
    return user.name if user
    self[:author_name]
  end
  
  def author_email
    return user.email if user
    self[:author_email]
  end
  
end
