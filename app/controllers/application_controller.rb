class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :current_user, :logged_in?
  def current_user
    byebug
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    # byebug
    if !logged_in?
      flash[:notice]="You must be logged in to perform that action"
      byebug
      render :json => {status: "not logged in"}

      # redirect_to login_path
    end
  end

end
