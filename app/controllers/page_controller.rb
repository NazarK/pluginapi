class PageController < ApplicationController
  layout 'raw'
  def check_pass item
    if params[:pass] != item.pass 
      render 'wrong_password'
      false
    end
    true
  end

  def install
    @profile = Profile.add
    @profile.save
    @profile
  end

  def data_set
    if params[:uid]==''
      throw :uidNotDefined
    end
    item = Profile.find_by_uid(params[:uid])
    if item.nil?
      throw :profileNotFound
    end
    if !check_pass item
      return
    end
    data = params[:data]
    data = data.split("|")
    @count = 0
    allowed_all = AllowLink.all
    data.each do |line|   
      allowed = false
      allowed_all.each do |allowed_link|
        if line.downcase.starts_with? allowed_link.link.downcase
	  allowed = true
	  break
        end
      end

      if allowed 
        r = ProfileUrl.new
        r.data = line
        r.profile_id = item.id
        r.save
        @count += 1
      end
    end

  end

  def data_get
    @profile = Profile.find_by_uid(params[:uid])
    if !check_pass @profile 
      return 
    end
  end

  def home
  end
  
  def org_set
    item = Profile.find_by_uid(params[:uid])
    if !check_pass item 
      return 
    end
    item.Organization.name = params[:org_id]
    item.Organization.save
    item.save
  end

  def orgs
    @items = Profile.all
  end

  def org_get
    item = Profile.find_by_uid(params[:uid])
    if !check_pass item 
      return 
    end
    @profile = item
  end

end
