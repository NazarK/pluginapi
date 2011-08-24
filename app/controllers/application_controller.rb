class ApplicationController < ActionController::Base
  protect_from_forgery
  private 
  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource_or_scope)
    if session[:login_url]
      s = session[:login_url]
      session[:login_url] = nil
      return s
    else
      "/admin"
    end
    
  end  
end
