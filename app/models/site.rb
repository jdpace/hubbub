class Site < ActiveRecord::Base
  
  acts_as_url :name
  
  validates_presence_of :name, :url, :meetup_group_id
  
end
