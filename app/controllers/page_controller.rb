require "uri"
require "pp"
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
    
    if params[:org_name]
      org = Organization.find_by_name(params[:org_name])
      if !org
        org = Organization.new
        org.name = params[:org_name]
        org.save
      end
      @profile.organization_id = org.id
    end
    
    if params[:referer_uid]
      parent = Profile.find_by_uid(params[:referer_uid])
      if !parent
        render :text => "ERROR: Profile for referer_uid not found"
        return
      end
      @profile.parent_id = parent.id
      if !@profile.organization_id
        @profile.organization_id = parent.organization_id
      end
    end

    @profile.save
    render :text => @profile.uid
  end

  def data_post
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
    allowed_all = DomainFilter.all

    data.each do |line|   
      allowed = false

      # extracting domain from url line
      begin
        host = URI.parse(line).host.downcase
      rescue
        logger.error("ERROR:FILTER: not valid url:'#{line}' profile: #{item.id} org: '#{item.Organization.name rescue ""}'");
        next
      end
      parts = host.split(".")
      if parts.count == 3
	      host = parts[1]+"."+parts[2]
      end

      allowed_all.each do |allowed_link|
        if host == allowed_link.domain.downcase
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
      else
        logger.error("ERROR:FILTER: not filtered url passed: '#{line}' profile: #{item.id} org: '#{item.Organization.name rescue ""}'")
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
    org = Organization.find_by_name(params[:org_id])
    if !org
      org = Organization.new
      org.name = params[:org_id]
      org.save
    end
    item.Organization = org
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
    render :text => (item.Organization.name rescue "")
  end

  def filter_get
    @domains = DomainFilter.order(:id).all
  end

end
