# -*- coding: utf-8 -*-
class RoomController < ApplicationController
#  before_action :authenticate_user!, except: [:index] 

  # トップ画面
  def index
=begin
    unless current_user
      # ログインしていない場合
      render :action => :home 
    else
      # ログインしている場合
      @name = current_user.name || current_user.email
      @rooms = current_user.rooms
    end
=end
  end

  # 自分の参加している部屋の一覧
  def list

  end

  # 部屋を新規作成
  def create
#    redirect_to :action => :index unless params["room_name"]    
  end

  def home
  end

  # ユーザを追加
  def add
  end

  # メッセージを投稿
  def post
  end
end
