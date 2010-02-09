class Post < ActiveRecord::Base
  
  acts_as_url :title
  
  belongs_to :user
  has_many   :comments
  
  validates_presence_of :title, :body, :user
  validate_on_create :validate_user_is_author
  
  before_save :cache_html
  
  named_scope :ordered, :order => 'id DESC'
  named_scope :limit, lambda {|max|
    { :limit => max }
  }
  
  def to_param
    url
  end
  
  protected
  
    def cache_html
      blue_cloth = BlueCloth::new(body)
      self.body_html = blue_cloth.to_html
      
      unless excerpt.blank?
        blue_cloth = BlueCloth::new(excerpt)
        self.excerpt_html = blue_cloth.to_html
      end
    end
  
    def validate_user_is_author
      errors.add(:user, 'must be an author') unless user.nil? || user.author?
    end
end
