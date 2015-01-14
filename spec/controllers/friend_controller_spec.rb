require 'rails_helper'

RSpec.describe FriendController, :type => :controller do

  describe "GET list" do
    it "returns http success" do
      get :list
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET add" do
    it "returns http success" do
      get :add
      expect(response).to have_http_status(:success)
    end
  end

end
