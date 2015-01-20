# -*- coding: utf-8 -*-
class FriendLogic
  def self.search(search_string)
    return nil unless search_string.kind_of?(String)
    return_users = []
    tmp_users1 = self.search_by_name(search_string)
    tmp_users1.each {|u| return_users.push u}
    tmp_users2 = self.search_by_email(search_string)
    tmp_users2.each {|u| return_users.push u}
    return return_users
  end

  # 名前で検索
  # return users / 対象ユーザがいれば
  # return nil / 検索の入力が間違っていれば
  def self.search_by_name(search_string)
    return nil unless search_string.kind_of?(String)
    return [] unless search_string.strip.lstrip.present?
    return User.where("name like ?", "%"+self.escape_like(search_string.strip.lstrip)+"%")
  end

  # emailは微妙か
  # emailで検索
  # return user / 対象ユーザがいれば
  # return nil / 検索の入力が間違っていれば
  def self.search_by_email(search_string)
    return nil unless search_string.kind_of?(String)
    return [] unless search_string.strip.lstrip.present?
    return User.where("email=?", search_string.strip.lstrip)
  end

  # friendに登録(片方向)
  # return true / 成功
  # return false / 失敗|すでに登録されている
  def self.add_friend(user, friend_id)
    return false unless user.kind_of?(User) && friend_id.kind_of?(Fixnum)
    
    friend = User.find_by_id(friend_id)
    if friend && !(user.friends.include?(friend))
      user.friends.push friend
      return true
    end
    return false
  end

  # friend登録されているか否か。
  # return false / 登録されていない場合
  # return true / 登録されている場合
  def self.is_friend?(user, member_id)
    return false unless user.kind_of?(User) && member_id.kind_of?(Fixnum)
    member = User.find_by_id(member_id)
    return user.friends.include?(member)
  end

  private

  def self.escape_like(str)
    return str.gsub(/\\/, "\\\\").gsub(/%/, "\\%").gsub(/_/, "\\_")
  end  
end
