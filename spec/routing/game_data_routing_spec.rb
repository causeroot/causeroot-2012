require "spec_helper"

describe GameDataController do
  describe "routing" do

    it "routes to #index" do
      get("/game_data").should route_to("game_data#index")
    end

    it "routes to #new" do
      get("/game_data/new").should route_to("game_data#new")
    end

    it "routes to #show" do
      get("/game_data/1").should route_to("game_data#show", :id => "1")
    end

    it "routes to #edit" do
      get("/game_data/1/edit").should route_to("game_data#edit", :id => "1")
    end

    it "routes to #create" do
      post("/game_data").should route_to("game_data#create")
    end

    it "routes to #update" do
      put("/game_data/1").should route_to("game_data#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/game_data/1").should route_to("game_data#destroy", :id => "1")
    end

  end
end
