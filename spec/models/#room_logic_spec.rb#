require 'rails_helper'

RSpec.describe RoomLogic, :type => :model do
  let :user1 do FactoryGirl.create :user1 end
  let :user2 do FactoryGirl.create :user2 end
  let :user3 do FactoryGirl.create :user3 end

  describe "#create_room" do
    context "when normal case" do
      it "should return room id" do
        expect((RoomLogic.create_room(user1, "test")).kind_of?(Integer)).to be(true)
      end
    end

    context "when input nil user" do 
      it "should be nil" do
        expect(RoomLogic.create_room(nil, "test")).to be_nil
      end
    end

    context "when input nil message" do
      it "should be nil" do
        expect(RoomLogic.create_room(user1, nil)).to be_nil
      end
    end
  end

  describe "#get_room_list" do
    before :each do
      RoomLogic.create_room(user1, "Test Room")
    end

    context "when exist user" do 
      it "have one room ,should be got one" do
        expect((RoomLogic.get_room_list(user1)).size).to be(1)
      end
      
      it "have two room, should be got two" do
        RoomLogic.create_room(user1, "Test Room2")
        expect((RoomLogic.get_room_list(user1)).size).to be(2)
      end

      it "have no room, should be got zero" do
        expect((RoomLogic.get_room_list(user2).size)).to be(0)
      end
    end
    
    context "when nil" do
      it "should be nil" do
        expect(RoomLogic.get_room_list(nil)).to be_nil
      end
    end
  end
  
  describe "#show_room" do
    context "when user1 don't join the room" do
      it "should be nil" do
        room_id = RoomLogic.create_room(user2,"test room")
        expect(RoomLogic.show_room(user1,room_id)).to be_nil
      end
    end

    context "when user1 join the room" do
      it "should get users and messages" do
        room_id = RoomLogic.create_room(user1,"test room")
        test_message = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
        RoomLogic.post_message(user1, room_id, test_message)

        expect(RoomLogic.show_room(user1,room_id).kind_of?(Array)).to be(true)
        expect(RoomLogic.show_room(user1,room_id)[0].include? user1).to be(true)
        expect(RoomLogic.show_room(user1,room_id)[1][0].message).to eq(test_message)
      end
    end

    context "when user1 and user2 join the room" do 
      it "should get users and messages " do
        room_id = RoomLogic.create_room(user1,"test room")
        expect(RoomLogic.add_member(user1, room_id, user2.id)).to be(true)
        test_message1 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
        test_message2 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
        RoomLogic.post_message(user1, room_id, test_message1)
        RoomLogic.post_message(user2, room_id, test_message2)

        expect(RoomLogic.show_room(user1,room_id).kind_of?(Array)).to be(true)
        expect(RoomLogic.show_room(user1,room_id)[0].include? user1).to be(true)
        expect(RoomLogic.show_room(user1,room_id)[0].include? user2).to be(true)
        expect(RoomLogic.show_room(user1,room_id)[1].map{|p|p.message==test_message1}.include?(true)).to eq(true)
        expect(RoomLogic.show_room(user1,room_id)[1].map{|p|p.message==test_message2}.include?(true)).to eq(true)
      end

      context "when another member " do
        it "should not get users and messages " do
          room_id = RoomLogic.create_room(user1,"test room")
          expect(RoomLogic.add_member(user1, room_id, user2.id)).to be(true)
          test_message1 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
          test_message2 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
          RoomLogic.post_message(user1, room_id, test_message1)
          RoomLogic.post_message(user2, room_id, test_message2)
          
          expect(RoomLogic.show_room(user2,room_id).kind_of?(Array)).to be(true)
          expect(RoomLogic.show_room(user2,room_id)[0].include? user1).to be(true)
          expect(RoomLogic.show_room(user2,room_id)[0].include? user2).to be(true)
          expect(RoomLogic.show_room(user2,room_id)[1].map{|p|p.message==test_message1}.include?(true)).to be(true)
          expect(RoomLogic.show_room(user2,room_id)[1].map{|p|p.message==test_message2}.include?(true)).to be(true)
        end
      end
    end

    context "when nil user" do 
      it "should be nil" do
        expect(RoomLogic.show_room(nil,1)).to be_nil
      end
    end
      
    context "when nil room_id" do
      it "should be nil" do
        expect(RoomLogic.show_room(user1,nil)).to be_nil
      end
    end

    context "when -1 room_id" do
      it "should be nil" do
        expect(RoomLogic.show_room(user1,-1)).to be_nil
      end
    end
  end

  describe "#add_member" do
    context "when room have user1 and don't have user2" do
      it "should add user2" do
        room_id = RoomLogic.create_room(user1, "test room")
        expect(RoomLogic.add_member(user1, room_id, user2.id)).to be(true)
      end

      it "shouldn't add user1" do 
        room_id = RoomLogic.create_room(user1, "test room")
        expect(RoomLogic.add_member(user1, room_id, user1.id)).to be(false)
      end
    end

    context "when nil user" do 
      it "should be fail" do 
        room_id = RoomLogic.create_room(user1, "test room")
        expect(RoomLogic.add_member(nil, room_id, user2.id)).to be(false)
      end
    end

    context "when nil room_id" do
      it "should be fail" do
        room_id = RoomLogic.create_room(user1, "test room")
        expect(RoomLogic.add_member(user1, nil, user2.id)).to be(false)
      end
    end

    context "when -1 room_id" do
      it "should be fail" do
        room_id = RoomLogic.create_room(user1, "test room")
        expect(RoomLogic.add_member(user1, -1, user2.id)).to be(false)
      end
    end

    context "when nil member_id" do
      it "should be fail" do
        room_id = RoomLogic.create_room(user1, "test room")
        expect(RoomLogic.add_member(user1, room_id, nil)).to be(false)
      end
    end
    
    context "when -1 user_id" do
      it "should be fail" do
        room_id = RoomLogic.create_room(user1, "test room")
        expect(RoomLogic.add_member(user1, room_id, -1)).to be(false)
      end
    end
  end
  
  describe "#post_message" do
    context "when user1 and user2 is room member" do
      context "and user1 post" do
        it "should be success" do
          room_id = RoomLogic.create_room(user1, "test room")
          RoomLogic.add_member(user1, room_id, user2.id)
          test_message1 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
          expect(RoomLogic.post_message(user1, room_id, test_message1)).to be(true)
          expect(Room.find_by_id(room_id).posts.map{|p|p.message==test_message1}.include?(true)).to be(true)
        end
      end
    
      context "and user2 post" do
        it "should be success" do
          room_id = RoomLogic.create_room(user1, "test room")
          RoomLogic.add_member(user1, room_id, user2.id)
          test_message1 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
          expect(RoomLogic.post_message(user2, room_id, test_message1)).to be(true)
          expect(Room.find_by_id(room_id).posts.map{|p|p.message==test_message1}.include?(true)).to be(true)
        end
      end

      context "and user3 post" do 
        it "should be fail" do
          room_id = RoomLogic.create_room(user1, "test room")
          RoomLogic.add_member(user1, room_id, user2.id)
          test_message1 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
          expect(RoomLogic.post_message(user3, room_id, test_message1)).to be(false)
          expect(Room.find_by_id(room_id).posts.map{|p|p.message==test_message1}.include?(true)).to be(false)
        end
      end
    end

    context "when nil user" do 
      it "should be fail" do
        room_id = RoomLogic.create_room(user1, "test room")
        test_message1 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
        expect(RoomLogic.post_message(nil, room_id, test_message1)).to be(false)
      end
    end

    context "when nil room_id" do
      it "should be fail" do
        room_id = RoomLogic.create_room(user1, "test room")
        test_message1 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
        expect(RoomLogic.post_message(user1, nil, test_message1)).to be(false)
      end
    end

    context "when -1 room_id" do
      it "should be fail" do
        room_id = RoomLogic.create_room(user1, "test room")
        test_message1 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
        expect(RoomLogic.post_message(user1, -1, test_message1)).to be(false)
      end
    end

    context "when nil message" do
      it "should be fail" do
        room_id = RoomLogic.create_room(user1, "test room")
        test_message1 = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
        expect(RoomLogic.post_message(user1, room_id, nil)).to be(false)
      end
    end
  end
end

