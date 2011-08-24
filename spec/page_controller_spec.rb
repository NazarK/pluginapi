require "spec_helper"
require "pp"
require "digest/md5"

describe PageController do 
  render_views
  describe "install" do 
    it 'should be successful' do 
      get 'install'
      response.should be_success
    end
  end

  describe 'data_post wrong password' do 
    it 'should be successful' do 
      prof = Profile.add
      uid = prof.uid
      get 'data_post', {:data => 'first line|second line|third line', :uid => "#{uid}", :pass => '12312321'}
      response.body.should == 'wrong password'
      response.should be_success
    end
  end

  describe 'data_post' do 
    it 'should be successful' do 
      r = DomainFilter.new
      r.domain = "yahoo.com"
      r.save

      r = DomainFilter.new
      r.domain = "amazon.com"
      r.save

      prof = Profile.add
      uid = prof.uid
      pass = Digest::MD5.hexdigest("#{uid}installation-password")
      get 'data_post', {:data => 'http://www.AMAZON.com|second line|http://somewhere.com|http://WWW.yahoo.com/123', :uid => uid, :pass => pass}
      response.body.should == 'data posted, 2 line(s)'
      response.should be_success
    end
  end  

  describe 'data_get' do 
    it 'should be successful' do 
      prof = Profile.add
      uid = prof.uid
      pass = Digest::MD5.hexdigest("#{uid}installation-password")
      r = prof.ProfileUrls.new
      r.data = 'http://something.com/123'
      r.save
      r = prof.ProfileUrls.new
      r.data = 'http://yahoo.com/111'
      r.save
      r = prof.ProfileUrls.new
      r.data = 'http://yahoo.com/222'
      r.save

      get 'data_get', { :uid => uid, :pass => pass }
      response.body.should == 'http://something.com/123|http://yahoo.com/111|http://yahoo.com/222|' 
      response.should be_success
    end
  end

  describe 'org_set' do 
    it 'should be successfull' do
      prof = Profile.add
      uid = prof.uid
      pass = Digest::MD5.hexdigest("#{uid}installation-password")
      get 'org_set', {:org_id => '123', :uid => uid, :pass => pass}
      response.should be_success
    end
  end
  
  describe 'org_get' do 
    it 'should be successfull' do
      prof = Profile.add
      
      org = Organization.new
      org.name = '123'
      org.save
      
      prof.organization_id = org.id
      prof.save
      
      uid = prof.uid
      pass = Digest::MD5.hexdigest("#{uid}installation-password")
      get 'org_get', {:uid => uid, :pass => pass}
      response.body.should == '123'
      response.should be_success
    end
  end

  describe 'filter_get' do 
    it 'should be successfull' do 
      r = DomainFilter.new
      r.domain = "yahoo.com"
      r.save

      r = DomainFilter.new
      r.domain = "amazon.com"
      r.save

      prof = Profile.add
      prof.save
      get 'filter_get', {:uid => prof.uid, :pass => prof.pass}

      response.body.should == 'yahoo.com|amazon.com|'
   
    end
  end

end