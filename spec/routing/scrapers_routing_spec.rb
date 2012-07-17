require "spec_helper"

describe ScrapersController do
  describe "routing" do

    it "routes to #index" do
      get("/scrapers").should route_to("scrapers#index")
    end

    it "routes to #new" do
      get("/scrapers/new").should route_to("scrapers#new")
    end

    it "routes to #show" do
      get("/scrapers/1").should route_to("scrapers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/scrapers/1/edit").should route_to("scrapers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/scrapers").should route_to("scrapers#create")
    end

    it "routes to #update" do
      put("/scrapers/1").should route_to("scrapers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/scrapers/1").should route_to("scrapers#destroy", :id => "1")
    end

  end
end
