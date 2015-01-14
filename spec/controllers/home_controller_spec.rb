require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET rooms" do
    it "returns http success" do
      get :rooms
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET room" do
    it "returns http success" do
      get :room
      expect(response).to have_http_status(:success)
    end
  end

end
