require "spec_helper"

describe Api::TodosController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/api/todos")).to route_to("api/todos#index")
    end

    it "routes to #show" do
      expect(get("/api/todos/1")).to route_to("api/todos#show", :id => "1")
    end

    it "routes to #create" do
      expect(post("/api/todos")).to route_to("api/todos#create")
    end

    it "routes to #update (PUT)" do
      expect(put("/api/todos/1")).to route_to("api/todos#update", :id => "1")
    end

    it "routes to #update (PATCH)" do
      expect(patch("/api/todos/1")).to route_to("api/todos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/api/todos/1")).to route_to("api/todos#destroy", :id => "1")
    end

  end
end
