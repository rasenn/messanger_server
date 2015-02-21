class FriendController < ApplicationController
  def list
    if params["search"].present?
      @users = FriendLogic.search(params["search"])
    end

    @friends = FriendLogic.get_friends(current_user)
  end

  def add
    FriendLogic.add_friend(current_user, params["user_id"].to_i)
    redirect_to action: "list"
  end
end
