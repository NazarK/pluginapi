class AccountController < ApplicationController

  def login
    if !params[:uid] && !params[:pass]
      render :text => "no uid and pass parameters"
      return
    end
    p = Profile.find_by_uid(params[:uid])

    if p.nick.blank?
      flash[:message] = "You are logging in first time. Please specify your nick."
      redirect_to "/account/nick"
      return
    end

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

  def nick
    if !session[:profile_id] 
      render :text => "not allowed, please login first"
      return
    end

    @profile = Profile.find(session[:profile_id])    

    if params[:nick] 
      if params[:nick].blank?
        flash[:error] = "Nick can't be blank"
      elsif Profile.find_by_nick(params[:nick], :conditions => ["id<>?",@profile.id])
        flash[:error] = "This nick is already in use."
      elsif params[:nick] == @profile.nick
      elsif
        flash[:message] = "Nick updated"
        @profile.nick = params[:nick]
        @profile.save
      end
    end


  end

  def style

  end

end