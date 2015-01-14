require 'rails_helper'

RSpec.describe UserController, :type => :controller do

  describe "GET search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET status" do
    it "returns http success" do
      get :status
      expect(response).to have_http_status(:success)
    end
  end

end
