require 'rails_helper'

RSpec.describe FriendLogic, :type => :model do
  let :user1 do FactoryGirl.create :user1, name: "User1" end
  let :user2 do FactoryGirl.create :user2, name: "User2" end
  let :user3 do FactoryGirl.create :user3, name: "User3" end

  describe "#search" do
    context "when three users exist" do
      context "and find 'User'" do
        it "should be three users" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search("User").size).to be(3)
        end
      end
      
      context "and find 'User '" do
        it "should be three users" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search("User ").size).to be(3)
        end
      end
      
      context "and find email" do
        it "should be one user" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search(user1.email).size).to be(1)
        end
      end

      context "and find email and spece" do
        it "should be one user" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search(" "+user1.email+" ").size).to be(1)
        end
      end

      context "and search null word" do 
        it "should be no user" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search("").size).to be(0)
        end
      end

      context "and search nil" do 
        it "should be nil" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search(nil)).to be(nil)
        end
      end
    end
  end

  describe "#search_by_name" do
    context "when three users exist" do
      context "and find 'User1'" do
        it "should get one user" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search_by_name("User1").size).to be(1)
        end
      end

      context "and find 'User'" do
        it "should get three user" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search_by_name("User").size).to be(3)
        end
      end

      context "and find 'Iser'" do
        it "should get no user" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search_by_name("Iser").size).to be(0)
        end
      end
    end

    context "when find nil user" do
      it "should be nil" do
        user1.id && user2.id && user3.id
        expect(FriendLogic.search_by_name(nil)).to be(nil)
      end
    end
  end

  describe "#search_by_mail" do
    context "when exist user" do
      context "and search same email" do
        it "should be one user" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search_by_email(user1.email).size).to be(1)
        end
      end

      context "and search same email with space" do
        it "should be one user" do
          user1.id && user2.id && user3.id
          expect(FriendLogic.search_by_email(" "+user1.email+" ").size).to be(1)
        end
      end

      context "and search different email" do
        it "should be no user" do
          user1.id && user2.id && user3.id
          random_str = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
          expect(FriendLogic.search_by_email(random_str + user1.email).size).to be(0)
        end
      end
    end
  end

  describe "#add_friend" do
    context "when add new friend" do
      it "should be true" do
        expect(FriendLogic.add_friend(user1, user2.id)).to be(true)
      end
    end

    context "when add already friend" do
      it "should be fail" do
        FriendLogic.add_friend(user1, user2.id)
        expect(FriendLogic.add_friend(user1, user2.id)).to be(false)
      end
    end

    context "when add friend to nil user" do
      it "should be fail" do
        expect(FriendLogic.add_friend(nil, user2.id)).to be(false)
      end
    end

    context "when -1 user_id" do
      it "should be fail" do
        expect(FriendLogic.add_friend(user1, -1)).to be(false)
      end
    end

    context "when nil user_id" do
      it "should be fail" do
        expect(FriendLogic.add_friend(user1, nil)).to be(false)
      end
    end    
  end

  describe "#is_friend?" do
    context "user2 is'nt user1 friend" do 
      it "should be false" do
        expect(FriendLogic.is_friend?(user1, user2.id)).to be(false)
      end
    end

    context "user2 already user1 friend" do 
      it "should be true" do
        FriendLogic.add_friend(user1, user2.id)
        expect(FriendLogic.is_friend?(user1, user2.id)).to be(true)
      end
    end

    context "when nil user" do 
      it "should be false" do
        expect(FriendLogic.is_friend?(nil, user2.id)).to be(false)
      end
    end

    context "when nil friend_id" do
      it "should be false" do
        expect(FriendLogic.is_friend?(user1, nil)).to be(false)
      end
    end

    context "when -1 friend_id" do
      it "should be false" do
        expect(FriendLogic.is_friend?(user1, -1)).to be(false)
      end
    end
  end
end
