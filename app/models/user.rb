class User < ActiveRecord::Base
  acts_as_authentic

  has_one :meetup,  :class_name => "MeetupToken",   :dependent => :destroy
  has_one :twitter, :class_name => "TwitterToken",  :dependent => :destroy

  validates_presence_of :name
end
