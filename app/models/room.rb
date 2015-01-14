class Room < ActiveRecord::Base
  has_many :room_users
  has_many :users, :through => :room_users

  has_many :room_posts
  has_many :posts, :through => :room_posts
end
