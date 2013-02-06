require 'csv'

class GraphsController < ApplicationController
  # GET /graphs
  # GET /graphs.json

#  caches_action :index, :expires_in => 600
  
  def index
  
   #TODO: Add if statement, to catch global data request from graphes page, else current_user
  
    csvstr = Graph.grabdata(@current_user)
    
    respond_to do |format|
      #format.html # index.html.erb
      format.json { render json: @graphs }
      format.csv { send_data csvstr }
    end
  end
end

        
