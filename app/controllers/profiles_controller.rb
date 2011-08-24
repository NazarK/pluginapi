class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.xml
  before_filter :require_admin
  layout "admin"
  
  def require_admin
    if !current_user
       session[:login_url] = request.request_uri       
       redirect_to "/users/sign_in"
    end
  end
  
  def index
    case params[:order]
    when "data_count"
      order = "ORDER BY data_count DESC, id"
    when "id"
      order = "ORDER BY id"
    when "nick"
      order = "ORDER BY nick"
    when "organization"
      order = "ORDER BY organization_name"
    when "referrals"
      order = "ORDER BY children_count DESC"
    else
      order = ""
    end
    params[:page]=1 if !params[:page]
    #@profiles = Profile.paginate(:page => params[:page], :per_page => 10)
    @profiles = Profile.paginate_by_sql("SELECT MIN(profiles.id) as id,
    MIN(profiles.nick) as nick, 
    MIN(profiles.uid) as uid, 
    MIN(profiles.organization_id) as organization_id, 
    MIN(profiles.parent_id) as parent_id,
    MIN(organizations.name) as organization_name,
    COUNT(profile_urls.id) as data_count,
    COUNT(children.id) as children_count
    FROM profiles 
    LEFT JOIN profile_urls ON profile_urls.profile_id=profiles.id
    LEFT JOIN organizations ON organizations.id=profiles.organization_id
    LEFT JOIN profiles as children ON children.parent_id = profiles.id
    GROUP BY profiles.id
    #{order}
    ",:page => params[:page], :per_page => 10);
    #@profiles = Profile.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to(@profile, :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
end
