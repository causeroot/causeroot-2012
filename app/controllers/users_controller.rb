class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.update_attributes(params[:user])
    if @user.save
      flash[:success] = "Welcome!"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Please try again."
      render 'new'
    end
  end

  #TODO: finish the controller...
  def edit
#    @user = User.find(params[:id])
  end

  def update
  	
  end

  def destroy
  end
end
