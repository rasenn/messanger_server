class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include ActiveModel::Serialization

  has_many :room_users
  has_many :rooms, :through => :room_users

  has_many :post_users
  has_many :posts, :through => :post_users

  has_many :friends, foreign_key: :friend_id
  has_many :users, through: :friends, class_name: "User"
  has_many :inverse_friends, foreign_key: :user_id, class_name: "Friend"
  has_many :friends, through: :inverse_friends, class_name: "User"
  
end
