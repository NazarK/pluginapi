require "digest/md5"
class Profile < ActiveRecord::Base
  has_many :ProfileUrls
  belongs_to :Organization, :foreign_key => "organization_id"
  belongs_to :Parent, :foreign_key => "parent_id", :class_name => "Profile"
  has_many :Child, :foreign_key => "parent_id", :class_name => "Profile"
  #after_create :create_Organization

  def self.add
    rec = self.new
    rec.save

    time = Time.new
    i = 1
    uid = ""
    begin 
      uid = Digest::MD5.hexdigest("--#{time.inspect}#--#{rec.id}--#{i}")
    end while not self.find_by_uid(uid).nil?
    rec.uid = uid
    rec.save
    rec
  end

  def pass
    Digest::MD5.hexdigest("#{uid}installation-password")
  end

  def loginpass
    Digest::MD5.hexdigest("#{uid}login-password")
  end

end
