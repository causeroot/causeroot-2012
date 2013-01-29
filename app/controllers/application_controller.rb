class ApplicationController < ActionController::Base
  before_filter :require_login
  protect_from_forgery

  protected
  def not_authenticated
      redirect_to login_path, :alert => "Please login first."
  end
end
