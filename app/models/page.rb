class Page < ActiveRecord::Base
  
  acts_as_url :title
  
  validates_presence_of :title, :body
  
  before_save :cache_body_html, :if => :body
  
  named_scope :published, :conditions => {:published => true}
  
  def to_param
    url
  end
  
  protected
  
    def cache_body_html
      blue_cloth = BlueCloth::new(body)
      self.body_html = blue_cloth.to_html
    end
end
