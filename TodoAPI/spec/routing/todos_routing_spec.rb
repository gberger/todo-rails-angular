require "spec_helper"

describe Api::TodosController do
  describe "routing" do

    it "routes to #index" do
      get("/api/todos").should route_to("api/todos#index")
    end

    it "routes to #show" do
      get("/api/todos/1").should route_to("api/todos#show", :id => "1")
    end

    it "routes to #create" do
      post("/api/todos").should route_to("api/todos#create")
    end

    it "routes to #update (PUT)" do
      put("/api/todos/1").should route_to("api/todos#update", :id => "1")
    end

    it "routes to #update (PATCH)" do
      patch("/api/todos/1").should route_to("api/todos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/api/todos/1").should route_to("api/todos#destroy", :id => "1")
    end

  end
end
