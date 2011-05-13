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

  describe 'data_set wrong password' do 
    it 'should be successful' do 
      prof = Profile.add
      uid = prof.uid
      get 'data_set', {:data => 'first line|second line|third line', :uid => "#{uid}", :pass => '12312321'}
      response.body.should == 'wrong password'
      response.should be_success
    end
  end

  describe 'data_set' do 
    it 'should be successful' do 
      prof = Profile.add
      uid = prof.uid
      pass = Digest::MD5.hexdigest("#{uid}installation-password")
      get 'data_set', {:data => 'first line|second line|third line', :uid => uid, :pass => pass}
      response.body.should == 'data posted, 3 line(s)'
      response.should be_success
    end
  end  

  describe 'data_get' do 
    it 'should be successful' do 
      prof = Profile.add
      uid = prof.uid
      pass = Digest::MD5.hexdigest("#{uid}installation-password")
      r = prof.ProfileURLs.new
      r.data = 'first line'
      r.save
      r = prof.ProfileURLs.new
      r.data = 'second line'
      r.save
      r = prof.ProfileURLs.new
      r.data = 'third line'
      r.save

      get 'data_get', { :uid => uid, :pass => pass }
      response.body.should == 'first line|second line|third line|' 
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
      prof.Organization.name = '123'
      prof.Organization.save
      prof.save
      uid = prof.uid
      pass = Digest::MD5.hexdigest("#{uid}installation-password")
      get 'org_get', {:uid => uid, :pass => pass}
      response.body.should == '123'
      response.should be_success
    end
  end

end