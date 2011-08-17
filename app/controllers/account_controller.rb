class AccountController < ApplicationController

  def login
    if !params[:uid] && !params[:pass]
      render :text => "no uid and pass parameters"
      return
    end
    p = Profile.find_by_uid(params[:uid])

    if !p
      render :text => "profile not found"
      return
    end

    if params[:pass] != p.loginpass
      sleep 1
      render :text => "wrong password"
      return
    end

    session[:profile_id] = p.id

    redirect_to "/account/home"
  end

  def logout
    session[:profile_id] = nil
    redirect_to "/account/home"
  end

  def home
    
  end

end