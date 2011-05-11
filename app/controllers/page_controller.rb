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
    @installation = Installation.add
    @installation.save
    @installation
  end

  def data_post
    if params[:uid]==''
      throw :uidNotDefined
    end
    item = Installation.find_by_uid(params[:uid])
    if item.nil?
      throw :installationNotFound
    end
    if !check_pass item
      return
    end
    data = params[:data]
    data = data.split("|")
    @count = 0
    data.each do |line|
      r = PluginDataPost.new
      r.data = line
      r.installation_id = item.id
      r.save
      @count += 1
    end

  end

  def data_get
    @installation = Installation.find_by_uid(params[:uid])
    if !check_pass @installation 
      return 
    end
  end

  def home
  end
  
  def org_set
    item = Installation.find_by_uid(params[:uid])
    if !check_pass item 
      return 
    end
    item.org_id = params[:org_id]
    item.save
  end

  def orgs
    @items = Installation.all
  end

end
