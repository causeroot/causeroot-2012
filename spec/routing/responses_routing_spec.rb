require "spec_helper"

describe ResponsesController do
  describe "routing" do

    it "routes to #index" do
      get("/responses").should route_to("responses#index")
    end

    it "routes to #new" do
      get("/responses/new").should route_to("responses#new")
    end

    it "routes to #show" do
      get("/responses/1").should route_to("responses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/responses/1/edit").should route_to("responses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/responses").should route_to("responses#create")
    end

    it "routes to #update" do
      put("/responses/1").should route_to("responses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/responses/1").should route_to("responses#destroy", :id => "1")
    end

  end
end
