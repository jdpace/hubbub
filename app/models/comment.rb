class Comment < ActiveRecord::Base
  EmailNameRegex = '[A-Z0-9_\.%\+\-]+'
  DomainHeadRegex = '(?:[A-Z0-9\-]+\.)+'
  DomainTldRegex = '(?:[A-Z]{2,4}|museum|travel)'
  EmailRegex = /\A#{EmailNameRegex}@#{DomainHeadRegex}#{DomainTldRegex}\z/i
  
  belongs_to :post
  belongs_to :user
  
  validates_presence_of :post, :body
  validates_presence_of :author_name, :author_email, :unless => :user
  validates_format_of   :author_email, :if => :author_email, :with => EmailRegex,
    :message => 'must be a valid email address'
  
end
