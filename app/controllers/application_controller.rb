class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  protected
  rescue_from ActiveRecord::RecordNotFound, :with => :render_missing
  def render_missing
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.xml  { head :not_found }
    end
end
  def current_user_session
    @current_user_session ||= UserSession.find
  end
  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end
  def authenticate
    unless current_user
      flash[:notice] = "You're not logged in, I'm afraid. Care to fix that?"
      redirect_to new_user_sessions_path
      return false
    end
  end
end


