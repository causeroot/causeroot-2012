class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        format.html { redirect_back_or_to(root_url, :notice => 'Login successful.') }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
      end
    end
  end
    
  def destroy
    logout
    redirect_to(:users, :notice => 'Logged out!')
  end
end