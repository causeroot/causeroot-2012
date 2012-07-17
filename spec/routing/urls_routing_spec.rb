require "spec_helper"

describe UrlsController do
  describe "routing" do

    it "routes to #index" do
      get("/urls").should route_to("urls#index")
    end

    it "routes to #new" do
      get("/urls/new").should route_to("urls#new")
    end

    it "routes to #show" do
      get("/urls/1").should route_to("urls#show", :id => "1")
    end

    it "routes to #edit" do
      get("/urls/1/edit").should route_to("urls#edit", :id => "1")
    end

    it "routes to #create" do
      post("/urls").should route_to("urls#create")
    end

    it "routes to #update" do
      put("/urls/1").should route_to("urls#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/urls/1").should route_to("urls#destroy", :id => "1")
    end

  end
end
