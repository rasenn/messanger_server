class UserController < ApplicationController
  def search
  end

  def edit
    @email = current_user.email
    @name = current_user.name
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
