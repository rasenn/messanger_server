# -*- coding: utf-8 -*-
class RoomLogic
  # 入力のuserのみActiveRecordとする。
  # それ以外の引数は基本idとする。

  # 部屋を作成
  # return room_id -> 作成成功
  # return nil -> 作成失敗
  def create_room(user, room_name)
    room = Room.create(:name => room_name)
    if room.new_record?
      room.users.push user
      return room.id
    else
      return nil
    end
  end
  
  # 自分の所属している部屋の一覧を表示
  # return rooms
  def get_room_list(user)
    user.rooms
  end

  # 部屋の情報を表示
  # return [users,messages] / ユーザが部屋のメンバ中にいる場合
  # return nil / ユーザが部屋のメンバ中にいない場合
  def show_room(user, room_id)
    room = is_member?(user, room_id)

    # userがroom内にいない場合、nilを返す
    return nil unless room

    messages = room.messages
    return [users,messages]
  end

  # 部屋にメンバを追加
  # return true / 部屋とメンバが見つかり、登録できた場合
  # return false / 部屋かメンバが見つからず、登録できなかった場合
  def add_member(user, room_id, member_id)
    member = User.find(member_id)
    room = Room.find(room_id)

    in_room = is_member?(member, room_id)

    # member,roomが見つからない、すでに部屋にいる場合にはエラーを返す
    if member.present? && room.present? && !in_room
      room.users.push member
      return true
    else
      return false
    end
  end

  # メッセージの投稿
  # retrun true / 成功
  # return false / 失敗
  def post_message(user, room_id, message)
    room = is_member?(user, room_id)
    if room
      messa = Message.create(:message => message)
      if messa.new_record?
        room.messages.push messa        
        return true
      end
    end
    return false
  end



  private 

  # 部屋のメンバーならroomを、そうでなければnilを返す
  def is_member?(user, room_id)
    room = Room.find(room_id)
    if room.users.include? user
      return room
    else
      return nil
    end
    
  end

end
