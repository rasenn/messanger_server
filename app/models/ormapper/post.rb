class Post < ActiveRecord::Base
  include ActiveModel::Serialization

  has_one :room_post
  has_one :room, :through => :room_post

  has_one :post_user
  has_one :user, :through => :post_user
end
