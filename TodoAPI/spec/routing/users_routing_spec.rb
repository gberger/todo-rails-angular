require "spec_helper"

describe Api::UsersController do
  describe "routing" do

    it "routes to #signup" do
      post("/api/users/signup").should route_to("api/users#signup")
    end

    it "routes to #login" do
      post("/api/users/login").should route_to("api/users#login")
    end

    it "routes to #reset_api_key (PUT)" do
      put("/api/users/reset_api_key").should route_to("api/users#reset_api_key")
    end

    it "routes to #reset_api_key (PATCH)" do
      patch("/api/users/reset_api_key").should route_to("api/users#reset_api_key")
    end

    it "routes to #change_password (PUT)" do
      put("/api/users/change_password").should route_to("api/users#change_password")
    end

    it "routes to #change_password (PATCH)" do
      patch("/api/users/change_password").should route_to("api/users#change_password")
    end

  end
end
