# -*- coding: utf-8 -*-
class RoomLogic
  # 入力のuserのみActiveRecordとする。
  # それ以外の引数は基本idとする。

  # 部屋を作成
  # return room_id -> 作成成功
  # return nil -> 作成失敗
  def self.create_room(user, room_name)
    return nil unless user.kind_of?(User) && room_name.kind_of?(String)
    
    room = Room.create(:name => room_name)
    unless room.new_record?
      room.users.push  user
      return room.id
    else
      return nil
    end
  end
  
  # 自分の所属している部屋の一覧を表示
  # return rooms
  # return nil / userがUserではない。
  def self.get_room_list(user)
    return nil unless user.kind_of?(User)
    user.rooms
  end

  # 部屋の情報を表示
  # return [users,messages] / ユーザが部屋のメンバ中にいる場合
  # return nil / ユーザが部屋のメンバ中にいない場合
  def self.show_room(user, room_id)
    return nil unless user.kind_of?(User) && room_id.kind_of?(Fixnum)

    room = is_member?(user, room_id)
    # userがroom内にいない場合、nilを返す
    return nil unless room

    users = room.users
    posts = room.posts.includes(:user)
    return [users,posts]
  end

  # 部屋にメンバを追加
  # return true / 部屋とメンバが見つかり、登録できた場合
  # return false / 部屋かメンバが見つからず、登録できなかった場合
  def self.add_member(user, room_id, member_id)
    return false unless user.kind_of?(User) && room_id.kind_of?(Fixnum) && member_id.kind_of?(Fixnum)
    member = User.find_by_id(member_id)
    room = Room.find_by_id(room_id)

    user_in_room = is_member?(user, room_id)
    new_member_in_room  = is_member?(member, room_id)

    # member,roomが見つからない、すでに部屋にいる場合にはエラーを返す
    if member.present? && room.present? && user_in_room && !new_member_in_room
      room.users.push  member
      return true
    else
      return false
    end
  end

  # メッセージの投稿
  # retrun true / 成功
  # return false / 失敗
  def self.post_message(user, room_id, message)
    return false unless user.kind_of?(User) && room_id.kind_of?(Fixnum) && message.kind_of?(String)

    room = is_member?(user, room_id)
    if room
      messa = Post.create(:message => message)
      messa.user = user
      unless messa.new_record?
        room.posts.push  messa
        room.save
        return true
      end
    end
    return false
  end

  def self.get_friends(user,room_id)
    return nil unless user.kind_of?(User) && room_id.kind_of?(Fixnum)
    
    room = is_member?(user, room_id)
    # userがroom内にいない場合、nilを返す
    return nil unless room

    friends = user.friends
    users = room.users
    
    return friends - users
  end

  private 

  # 部屋のメンバーならroomを、そうでなければnilを返す
  def self.is_member?(user, room_id)
    return nil unless user.kind_of?(User) && room_id.kind_of?(Fixnum)

    room = Room.find_by_id(room_id)
    if room && room.users.include?(user)
      return room
    else
      return nil
    end
  end
end
