module Messanger
  class Room < Grape::API
    resource :room do 
      desc "return user's room list"
      get :list do
        RoomLogic.get_room_list(current_user)
      end

      desc "create new room"
      params do 
        requires :room_name, type: String, desc: "new room name"
      end
      post :create do
        RoomLogic.create_room(current_user, params["room_name"])
      end
      

      desc "add user to room"
      params do 
        requires :user_id, type: Integer, desc: "user id" 
        requires :room_id, type: Integer, desc: "room id"
      end
      post :add do
        RoomLogic.add_member(current_user, params["room_id"].to_i, params["user_id"].to_i)
      end

      
      desc "post message"
      params do 
        requires :message, type: String, desc: "message"
        requires :room_id, type: Integer, desc: "room id"
      end
      post :add do
        RoomLogic.add_member(current_user, params["room_id"].to_i, params["user_id"].to_i)
      end

      desc "show room"
      params do
        requires :room_id, type: Integer, desc: "room id"
      end
      get :show do
        RoomLogic.show_room(current_user, params["room_id"].to_i)
      end
    end
  end    
end
