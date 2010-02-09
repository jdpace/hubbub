class Post < ActiveRecord::Base
  
  acts_as_url :title
  
  belongs_to :user
  belongs_to :feed
  has_many   :comments
  
  validates_presence_of :title, :body
  validate_on_create :validate_user_is_author, :if => :user
  
  before_save :cache_html
  before_create :set_published_at
  
  named_scope :ordered, :order => 'published_at DESC'
  named_scope :limit, lambda {|max|
    { :limit => max }
  }
  
  def to_param
    url
  end
  
  def author_name
    user ? user.name : external_author
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
    
    def set_published_at
      self.published_at ||= Time.zone.now
    end
end
