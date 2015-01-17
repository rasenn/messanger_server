class Room < ActiveRecord::Base
  include ActiveModel::Serialization  
  
  has_many :room_users
  has_many :users, :through => :room_users

  has_many :room_posts
  has_many :posts, :through => :room_posts
end
