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


  # copy from http://stackoverflow.com/questions/26623980/user-authentication-with-grape-and-devise
  before_save :ensure_authentication_token

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  private
  def generate_authentication_token
    loop do
            token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
  # end copy
  
end
