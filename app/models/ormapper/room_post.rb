class RoomPost < ActiveRecord::Base
  belongs_to :room
  belongs_to :post
end
