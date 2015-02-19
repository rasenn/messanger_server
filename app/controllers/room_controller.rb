# -*- coding: utf-8 -*-
class RoomController < ApplicationController
  before_action :authenticate_user!, except: [:index] 

  # トップ画面
  def index
    unless user_signed_in?
      # ログインしていない場合
    else
      # ログインしている場合
      redirect_to :action => :home
    end
  end

  # 自分の参加している部屋の一覧
  def list
    @rooms = RoomLogic.get_room_list(current_user)
  end

  # 部屋を新規作成
  def create
    unless params["room_name"].present?
      @message = "please input room name"
    else
      RoomLogic.create_room(current_user, params["room_name"].to_s)
    end
    redirect_to :action => :index
  end

  def home
    @name = current_user.name || current_user.email
    @rooms = current_user.rooms
  end

  # ユーザを追加
  def add
    unless params["user_id"].present? && params["room_id"].present?
      @message = "none room_id or user_id"
    else
      RoomLogic.add_member(current_user, params["room_id"].to_i, params["user_id"].to_i)
    end
    redirect_to :action => "show"
  end

  # メッセージを投稿
  def post
    unless params["room_id"].present? && params["message"].present?
      @message = "none room_id or message"
      redirect_to :action => "show"
    else
      RoomLogic.post_message(current_user, params["room_id"].to_i, params["message"].to_s)
      redirect_to :action => "show", room_id: params["room_id"].to_i
    end
  end

  # 部屋を見る
  def show
    room = RoomLogic.show_room(current_user, params["room_id"].to_i)

    redirect_to :action => "home" unless room

    @users,@posts = room
    @room_id = params["room_id"]
  end

end
