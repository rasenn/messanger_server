class UserController < ApplicationController
  def search
  end

  def edit
    @current_user = current_user
  end

  def change
    if params["name"].present? 
      current_user.name = params["name"]
      current_user.save
      flash[:notice] = "your name were changed"      
    end
    redirect_to :action => "edit"
  end

  def status
  end

end
