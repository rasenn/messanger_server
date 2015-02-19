# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe RoomController, :type => :controller do
  include Devise::TestHelpers
  let :user1 do FactoryGirl.create :user1, name: "User1" end

  describe "GET index" do
    context "when non logined user access " do
      it "should returns http success" do
        #あとで書く?
#        expect{get :index}.to raise_exception("uncaught throw :warden")
      end
    end

    context "when logined user access" do
      before do
        sign_in user1 
        get :index
      end

      it "should return 302" do 
        expect(response).to have_http_status(302)
      end

      it "should redirect #home" do
        expect(response).to redirect_to( :action => "home")
      end
    end
  end

  describe "GET list" do
    context "when non logined user access " do
      it "should redirect" do
#       expect(get :list).to redirect_to new_user_session
      end
    end

    context "when logined user access " do
      before do
        sign_in  user1
        get :list
      end
      
      it "should returns http success" do 
        expect(response).to have_http_status(:success)
      end

      it "should assigned room list" do 
#        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET create" do
    before do
      sign_in  user1
    end

    it "should returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET add" do
    before do
      sign_in  user1
    end

    it "should returns http success" do
      get :add
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET post" do
    before do
      sign_in  user1
    end    

    it "returns http error" do
      get :post
      expect(response).to have_http_status(:error)
    end
  end

  describe "POST post" do
    before do
      sign_in user1
    end

    context "when include params[:message]" do
      before { post "post", :message => "test"}
      it "return http success" do
        expect(response).to have_http_status(:success)
      end

      it " render #show" do
        expect(response).to render_template("room/show")
      end
    end

    context "when not include params[:message]" do
      before { post "post"}
      it "return redirect #show" do
        expect(response).to redirect_to("room/show")
      end
    end

  end

end
