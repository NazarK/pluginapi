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
      inst = Installation.add
      uid = inst.uid
      get 'data_post', {:data => 'first line|second line|third line', :uid => "#{uid}", :pass => '12312321'}
      response.body.should == 'wrong password'
      response.should be_success
    end
  end

  describe 'data_post' do 
    it 'should be successful' do 
      inst = Installation.add
      uid = inst.uid
      pass = Digest::MD5.hexdigest("#{uid}installation-password")
      get 'data_post', {:data => 'first line|second line|third line', :uid => uid, :pass => pass}
      response.body.should == 'data posted, 3 line(s)'
      response.should be_success
    end
  end  

  describe 'data_get' do 
    it 'should be successful' do 
      inst = Installation.add
      uid = inst.uid
      pass = Digest::MD5.hexdigest("#{uid}installation-password")
      r = inst.PluginDataPosts.new
      r.data = 'first line'
      r.save
      r = inst.PluginDataPosts.new
      r.data = 'second line'
      r.save
      r = inst.PluginDataPosts.new
      r.data = 'third line'
      r.save

      get 'data_get', { :uid => uid, :pass => pass }
      response.body.should == 'first line|second line|third line|' 
      response.should be_success
    end
  end

end